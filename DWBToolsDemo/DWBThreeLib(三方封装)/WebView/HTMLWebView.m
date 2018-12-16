
//
//  HTMLWebView.m
//  XiaoYuanSheQu
//
//  Created by 戴维保 on 16/9/9.
//  Copyright © 2016年 北京嗅美科技有限公司. All rights reserved.
//

#import "HTMLWebView.h"
#import "JZAlbumViewController.h"
@interface HTMLWebView()<WKNavigationDelegate,UIGestureRecognizerDelegate>
//html
@property(nonatomic,copy)NSString * stringHtml;

//类型
@property(nonatomic,strong)NSString * typeString;

//图片链接数组
@property (strong, nonatomic)NSMutableArray * mArrayUrl;

@end


@implementation HTMLWebView

// 在initWithFrame:方法中添加子控件
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //必须在初始化时创建否则会崩溃
        [self createUI];
    }
    return self;
}


-(void)createUI{
    
    
#pragma mark ==================== html============================
    //打开垂直滚动条
    self.scrollView.showsVerticalScrollIndicator=NO;
    //关闭水平滚动条
    self.scrollView.showsHorizontalScrollIndicator=NO;
    //设置滚动视图的背景颜色
    self.scrollView.backgroundColor = [UIColor whiteColor];
    self.navigationDelegate = self;
    //两条属性关闭黑影
    self.backgroundColor = [UIColor whiteColor];
    self.opaque = NO;
    //关闭网页滚动(必须)
    self.scrollView.scrollEnabled = NO;
    
    //添加长按手势
    UILongPressGestureRecognizer *longPressRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    longPressRecognizer.allowableMovement = 20;
    longPressRecognizer.minimumPressDuration = 1.0f;
    [self addGestureRecognizer:longPressRecognizer];
    
    //添加点击手势（点击查看大图）
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapPress:)];
    tap.delegate = self;
    [self addGestureRecognizer:tap];
    
    
    //KVO获取网页高度
    [self.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
    
}

//加载数据
-(void)WebViewload{
    //判空
    NSString * string;
    if (!self.stringHtml) {
        string = @" ";
    }else{
        string = self.stringHtml;
    }
    
    // reSizeImageWithHTML设置约束样式
    [self loadHTMLString:[self reSizeImageWithHTML:string] baseURL:nil];


}

//由于后台返回的HTML代码里……你懂的，所以只能添加样式来适配屏幕，下面的方法可以调节文字和图片大小来适配屏幕。(删者必死)
- (NSString *)reSizeImageWithHTML:(NSString *)html {
    // 顶部留出空白（用来创建头部视图）：<p style='padding-top:200px;'></p>   底部留出空白（用力啊创建尾部视图）：<p style='padding-bottom:200px;'></p>
    
        if ([self.typeString isEqual:@"话题详情"]) {
           
            //设置头部、尾部空白和设置html图片自适应手机
            return [NSString stringWithFormat:@"<p style='padding-top:%fpx;'></p><meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0'><meta name='apple-mobile-web-app-capable' content='yes'><meta name='apple-mobile-web-app-status-bar-style' content='black'><meta name='format-detection' content='telephone=no'><style type='text/css'>img{width:%fpx}</style>%@<p style='padding-bottom:%fpx;'></p>",0.0, SCREEN_WIDTH - 30-15, html,0.0];
    
        }else if ([self.typeString isEqual:@"免费课程详情"]){
        
            //设置头部、尾部空白和设置html图片自适应手机
            return [NSString stringWithFormat:@"<p style='padding-top:%fpx;'></p><meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0'><meta name='apple-mobile-web-app-capable' content='yes'><meta name='apple-mobile-web-app-status-bar-style' content='black'><meta name='format-detection' content='telephone=no'><style type='text/css'>img{width:%fpx}</style>%@<p style='padding-bottom:%fpx;'></p>",0.0, SCREEN_WIDTH - 15, html,0.0];
    
        }else{
            //设置头部、尾部空白和设置html图片自适应手机
            return [NSString stringWithFormat:@"<p style='padding-top:%fpx;'></p><meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0'><meta name='apple-mobile-web-app-capable' content='yes'><meta name='apple-mobile-web-app-status-bar-style' content='black'><meta name='format-detection' content='telephone=no'><style type='text/css'>img{width:%fpx}</style>%@<p style='padding-bottom:%fpx;'></p>",0.0, SCREEN_WIDTH - 15, html,0.0];
            
        }
}

//KVO获取网页高度
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
    CGSize size = [[change objectForKey:NSKeyValueChangeNewKey] CGSizeValue];
    //网页高度回调
    if (self.WebviewHeight) {
        self.WebviewHeight(size.height);
    }
    
}



//网页加载完成
//页面加载完后获取高度，设置脚,注意，控制器里不能重写代理方法，否则这里会不执行
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    
    
    // 不执行前段界面弹出列表的JS代码，关闭系统的长按保存图片
    [self evaluateJavaScript:@"document.documentElement.style.webkitTouchCallout='none';" completionHandler:nil];

    
    [webView evaluateJavaScript:@"document.body.offsetHeight;" completionHandler:^(id Result, NSError * error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            //必须加上一点
            CGFloat height = [Result doubleValue]+15.00;
            //网页加载完成
            if (self.webviewFinishLoad) {
                self.webviewFinishLoad(height);
            }
            //销毁通知KVO
            // 最后一步：移除监听的KVO
            //防止KVO多次移除崩溃，这种方法只能针对多次删除KVO的处理，原理就是try catch可以捕获异常，不让程序catch。这样就实现了防止多次删除KVO。
            @try {
                //移除观察者
                [self.scrollView removeObserver:self forKeyPath:@"contentSize" context:nil];
            }
            @catch (NSException *exception) {
                NSLog(@"KVO多次删除了");
            }
            
            
        });
    }];
    
    
    //网页加载完成后通过js获取htlm中所有图片url
    [self getImageUrlByJS:self];

}

// 类似 UIWebView 的 -webView: shouldStartLoadWithRequest: navigationType:
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    //点击内容里面的网址，如果是跳转一个新页面
    if (navigationAction.targetFrame == nil) {
        //在当前页面打开URL
        //        [webView loadRequest:navigationAction.request];
        
        //打开新的WebView控制器--在App内部
        NSString * webUrlStr = navigationAction.request.URL.absoluteString;
        
        //        YZTitleWebViewController * vc = [[YZTitleWebViewController alloc] init];
        //        vc.url = webUrlStr;//网址
        //        [[UIViewController getTopWindowController].navigationController pushViewController:vc animated:YES];
        
        //在App外部浏览器打开
        [NSString openOutUrl:webUrlStr];
        
    }
    
    decisionHandler(WKNavigationActionPolicyAllow);
}

//block回调，控制器里调用
-(void)htmlWebViewHtml:(NSString*)stringhtml Type:(NSString*)typeString htmlHeightKVO:(void (^)(CGFloat webHeight))htmlHeight FinishLoadeEnd:(void (^)(CGFloat endHeight))FinishLoadeEnd{
    //类型放在最上面
    self.typeString = typeString;
    //内容
    _stringHtml = stringhtml;
  
    //加载数据
    [self WebViewload];
    
    
    //回调网页高度
    [self setWebviewHeight:^(CGFloat WebHeight) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (htmlHeight) {
                htmlHeight(WebHeight);
            }
        });
    }];
    
    //网页加载完成
    [self setWebviewFinishLoad:^(CGFloat endheight) {
        //走一遍KVO的
        dispatch_async(dispatch_get_main_queue(), ^{
            if (htmlHeight) {
                htmlHeight(endheight);
            }
        });
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (FinishLoadeEnd) {
                FinishLoadeEnd(endheight);
            }
        });
    }];

}


//移除KVO
-(void)dealloc{
    //移除观察者
    // 最后一步：移除监听的KVO
    //防止KVO多次移除崩溃，这种方法只能针对多次删除KVO的处理，原理就是try catch可以捕获异常，不让程序catch。这样就实现了防止多次删除KVO。
    @try {
        //移除观察者
        [self.scrollView removeObserver:self forKeyPath:@"contentSize" context:nil];
    }
    @catch (NSException *exception) {
        NSLog(@"KVO多次删除了");
    }
    
}


#pragma mark ===================长按保存图片==================================
-(void)handleLongPress:(UILongPressGestureRecognizer *)sender{
    
    CGPoint touchPoint = [sender locationInView:self];
    // 获取长按位置对应的图片url的JS代码
    NSString *imgJS = [NSString stringWithFormat:@"document.elementFromPoint(%f, %f).src", touchPoint.x, touchPoint.y];
    // 执行对应的JS代码 获取url
    [self evaluateJavaScript:imgJS completionHandler:^(id _Nullable imgUrl, NSError * _Nullable error) {
        if (imgUrl) {
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imgUrl]];
            UIImage *image = [UIImage imageWithData:data];
            if (!image) {
                NSLog(@"读取图片失败");
                return;
            }
            //获取到图片image

            //自定义底部弹窗
            [DWBAlertView AlertMyCXSheetAllViewWithController:[UIApplication sharedApplication].keyWindow.rootViewController Title:nil otherItemArrays:@[@"保存图片"] ShowRedindex:-1 isShowCancel:YES CancelTitle:@"取消" Type:-1 handler:^(NSInteger index) {
                if (index==0) {
                    //保存
                    dispatch_async(dispatch_get_main_queue(), ^{
                        //保存图片到相册
                        UIImageWriteToSavedPhotosAlbum(image, self, @selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:), nil);
                        
                    });
                }
            }];
            
            
            
        }
    }];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}
//保存照片到本地相册
- (void)imageSavedToPhotosAlbum:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if(!error){
        //延迟显示，否则会移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [MBProgressHUD showSuccess:@"保存成功"];
            
        });
        
    }else{
        //延迟显示，否则会移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [MBProgressHUD showSuccess:@"保存失败"];
        });
        
    }
    
}



#pragma mark ========= 点击获取所有图片，并查看大图 ========================
//通过js获取htlm中图片url
-(void)getImageUrlByJS:(WKWebView *)wkWebView{
    
    //js方法遍历图片添加点击事件返回图片个数
    //这里是js，主要目的实现对url的获取
    static  NSString * const jsGetImages =
    @"function getImages(){\
    var objs = document.getElementsByTagName(\"img\");\
    var imgScr = '';\
    for(var i=0;i<objs.length;i++){\
    imgScr = imgScr + objs[i].src + '+';\
    };\
    return imgScr;\
    };";
    
    //用js获取全部图片,传质给js
    [wkWebView evaluateJavaScript:jsGetImages completionHandler:nil];
    
    //得到所有图片
    NSString *jsString = @"getImages()";
    
    [wkWebView evaluateJavaScript:jsString completionHandler:^(id Result, NSError * error) {
        
        NSString *resurlt=[NSString stringWithFormat:@"%@",Result];
        
        if([resurlt hasPrefix:@"+"]){
            
            resurlt=[resurlt substringFromIndex:1];
            
        }
        
        NSArray * array=[resurlt componentsSeparatedByString:@"+"];
        
        [self.mArrayUrl removeAllObjects];
        //添加到可变数组
        [self.mArrayUrl addObjectsFromArray:array];
        //移除最后一个元素（空白）
        [self.mArrayUrl removeLastObject];
        
        //        NSLog(@"得到所有图片url：%@",self.mArrayUrl);
        
    }];
}

//点击手势
- (void)handleTapPress:(UITapGestureRecognizer *)sender{
    
    CGPoint touchPoint = [sender locationInView:self];
    // 获取长按位置对应的图片url的JS代码
    NSString *imgJS = [NSString stringWithFormat:@"document.elementFromPoint(%f, %f).src", touchPoint.x, touchPoint.y];
    // 执行对应的JS代码 获取url
    [self evaluateJavaScript:imgJS completionHandler:^(id _Nullable imgUrl, NSError * _Nullable error) {
        if (imgUrl) {
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imgUrl]];
            UIImage *image = [UIImage imageWithData:data];
            if (!image) {
                NSLog(@"读取图片失败");
                return;
            }
            //获取到图片image
            
            //图片大于0才创建
            if (self.mArrayUrl.count>0) {
                NSInteger currentIndex = 0;
                //得到索引
                for (int i= 0; i< self.mArrayUrl.count; i++) {
                    if ([imgUrl isEqual:self.mArrayUrl[i]]) {
                        //当前点击了第几张图片
                        currentIndex = i;
                    }
                }
                
                //控制器跳转
                JZAlbumViewController *jzAlbumVC = [[JZAlbumViewController alloc]init];
                //当前点击图片的索引
                jzAlbumVC.currentIndex = currentIndex;
                //imgArr可以为url数组, 可以为urlString 数组, 可以为二进制 UIImage 数组
                jzAlbumVC.imgArr = self.mArrayUrl;
                
                [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:jzAlbumVC animated:NO completion:nil];
                
            }else{
                //如果加载完后拿不到所有图片数组，就查看当前点击的图片
                //控制器跳转
                JZAlbumViewController *jzAlbumVC = [[JZAlbumViewController alloc]init];
                //当前点击图片的索引
                jzAlbumVC.currentIndex = 0;
                //imgArr可以为url数组, 可以为urlString 数组, 可以为二进制 UIImage 数组
                jzAlbumVC.imgArr = [NSMutableArray arrayWithArray:@[imgUrl]];
                
                [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:jzAlbumVC animated:NO completion:nil];
                
                
            }
        }
    }];
    
    
}


//图片数组
-(NSMutableArray *)mArrayUrl{
    if (!_mArrayUrl) {
        _mArrayUrl = [NSMutableArray array];
    }
    return _mArrayUrl;
}





@end
