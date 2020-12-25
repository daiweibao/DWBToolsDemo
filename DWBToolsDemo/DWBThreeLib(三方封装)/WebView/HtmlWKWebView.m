//
//  HtmlWKWebView.m
//  XiaoYuanSheQu
//
//  Created by chaoxi on 2017/3/31.
//  Copyright © 2017年 chaoxi科技有限公司. All rights reserved.
//

#import "HtmlWKWebView.h"
#import "JZAlbumViewController.h"
@interface HtmlWKWebView()<WKNavigationDelegate,UIGestureRecognizerDelegate>
//图片链接数组
@property (strong, nonatomic)NSMutableArray * mArrayUrl;
//进度条
@property (strong, nonatomic) UIProgressView *progressView;
@end

@implementation HtmlWKWebView

// 在initWithFrame:方法中添加子控件
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //必须在初始化时创建否则会崩溃
        [self createUI];
        
    }
    return self;
}

//和JS有交互的
-(void)setActionJS:(NSString *)actionJS{
    _actionJS  = actionJS;
    //因为和JS有交互的WKWebViewConfiguration不走inint方法，所有手动调用
     [self createUI];
}

//注册KVO开启进度条
-(void)setWkWebview:(WKWebView *)wkWebview{
    _wkWebview = wkWebview;
    self.progressView.hidden = NO;
//    NSLog(@"wkWebview：%@",self.wkWebview);
    // KVO，监听webView属性值得变化(estimatedProgress,title为特定的key)
    [self.wkWebview addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
}

//得到html
-(void)setHtmlString:(NSString *)htmlString{
    _htmlString = htmlString;
    
    //刷新脚步影藏（不然会跑到头部，删者必死）
    _footView.hidden = YES;

    // reSizeImageWithHTML设置头样式
    [self loadHTMLString:[self reSizeImageWithHTML:self.htmlString] baseURL:nil];

    
}

//创建UI
-(void)createUI{
      //打开垂直滚动条
     self.scrollView.showsVerticalScrollIndicator=YES;
    //关闭水平滚动条
     self.scrollView.showsHorizontalScrollIndicator=NO;
    //设置滚动视图的背景颜色
    self.scrollView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.navigationDelegate = self;
    //两条属性关闭黑影
    self.backgroundColor = [UIColor clearColor];
    self.opaque = NO;
    

    // 添加头部
    _headerView = [[UIView alloc] init];
    _headerView.backgroundColor = [UIColor whiteColor];
    _headerView.userInteractionEnabled = YES;
    [self.scrollView addSubview:_headerView];
    
    
    //添加脚步
    _footView = [[UIView alloc] init];
    //开始加载时不设置脚步坐标
    _footView.frame = CGRectZero;
    _footView.backgroundColor = [UIColor whiteColor];
    _footView.userInteractionEnabled = YES;
    //先影藏
    _footView.hidden = YES;
    [self.scrollView addSubview:_footView];
    
    
    //添加长按手势
    self.userInteractionEnabled = YES;
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    longPress.allowableMovement = 20;
    longPress.minimumPressDuration = 1.0f;
    longPress.delegate = self;
    [self addGestureRecognizer:longPress];
    
    if (self.actionJS.length>0) {
        //不创建点击手势，不然点击的时候又弹框有出现图片浏览的
        
    }else{
        //添加点击手势（点击查看大图）
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapPress:)];
        tap.delegate = self;
        [self addGestureRecognizer:tap];
        
    }
    
    
    // UIProgressView初始化
    self.progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    self.progressView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 2);
    self.progressView.trackTintColor = [UIColor clearColor]; // 设置进度条的色彩
//    self.progressView.progressTintColor = [UIColor blueColor];
    // 设置初始的进度，防止用户进来就懵逼了（微信大概也是一开始设置的10%的默认值）
    self.progressView.hidden = YES;
    [self.progressView setProgress:0.1 animated:YES];
    [self addSubview:self.progressView];



}
//由于后台返回的HTML代码里……你懂的，所以只能添加样式来适配屏幕，下面的方法可以调节文字和图片大小来适配屏幕。(删者必死)
- (NSString *)reSizeImageWithHTML:(NSString *)html {
    // 顶部留出空白（用来创建头部视图）：<p style='padding-top:200px;'></p>   底部留出空白（用力啊创建尾部视图）：<p style='padding-bottom:200px;'></p>
    //设置头部、尾部空白和设置html图片自适应手机
    return [NSString stringWithFormat:@"<p style='padding-top:%fpx;'></p><meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0'><meta name='apple-mobile-web-app-capable' content='yes'><meta name='apple-mobile-web-app-status-bar-style' content='black'><meta name='format-detection' content='telephone=no'><style type='text/css'>img{width:%fpx}</style>%@<p style='padding-bottom:%fpx;'></p>",self.headerView.frame.size.height, SCREEN_WIDTH - 15, html,self.footView.frame.size.height];
}


//页面加载完后获取高度，设置脚,注意，控制器里不能重写代理方法，否则这里会不执行
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    
    // 不执行前段界面弹出列表的JS代码，关闭系统的长按保存图片
    [self evaluateJavaScript:@"document.documentElement.style.webkitTouchCallout='none';" completionHandler:nil];
    
    // WKWebView禁止放大缩小(捏合手势)
    NSString *injectionJSString = @"var script = document.createElement('meta');"
    "script.name = 'viewport';"
    "script.content=\"width=device-width, initial-scale=1.0,maximum-scale=1.0, minimum-scale=1.0, user-scalable=no\";"
    "document.getElementsByTagName('head')[0].appendChild(script);";
    [webView evaluateJavaScript:injectionJSString completionHandler:nil];
 
    //获取网页高度
    [webView evaluateJavaScript:@"document.body.offsetHeight;" completionHandler:^(id Result, NSError * error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            CGFloat documentHeight = [Result doubleValue]+15.00;
//            NSLog(@"高度%f",documentHeight);
            //            [DWBToast showCenterWithText:[NSString stringWithFormat:@"%f",documentHeight]];
            if (self.htmlString.length>0) {
                //啥也不干
            }else{
                documentHeight = 0.0;
            }
            
            _footView.frame = CGRectMake(0, documentHeight-self.footView.frame.size.height, SCREEN_WIDTH, self.footView.frame.size.height);
            //加载完设置好坐标打开
            _footView.hidden = NO;

            
        });
    }];
    
    
    //网页加载完成后通过js获取htlm中所有图片url
    [self getImageUrlByJS:self];
    
    //清除WK缓存，否则H5界面跟新，这边不会更新
    [self remoViewCookies];
    

}

//清除WK缓存，否则H5界面跟新，这边不会更新
-(void)remoViewCookies{
    
    
    if ([UIDevice currentDevice].systemVersion.floatValue>=9.0) {
        //        - (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation 中就成功了 。
        //    然而我们等到了iOS9！！！没错！WKWebView的缓存清除API出来了！代码如下：这是删除所有缓存和cookie的
        NSSet *websiteDataTypes = [WKWebsiteDataStore allWebsiteDataTypes];
        //// Date from
        NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
        //// Execute
        [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes modifiedSince:dateFrom completionHandler:^{
        }];
    }else{
        //iOS8清除缓存
        NSString * libraryPath =  NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).firstObject;
        NSString * cookiesFolderPath = [libraryPath stringByAppendingString:@"/Cookies"];
        [[NSFileManager defaultManager] removeItemAtPath:cookiesFolderPath error:nil];
    }
    

}



- (void)handleLongPress:(UILongPressGestureRecognizer *)sender{
    if (sender.state != UIGestureRecognizerStateBegan) {
        return;
    }
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


#pragma mark - KVO监听进度条
// 第三部：完成监听方法
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    if ([object isEqual:self] && [keyPath isEqualToString:@"estimatedProgress"]) { // 进度条
        
        CGFloat newprogress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
//        NSLog(@"网页进度：%f", newprogress);
        
        if (newprogress == 1) { // 加载完成
            // 首先加载到头
            [self.progressView setProgress:newprogress animated:YES];
            // 之后0.3秒延迟隐藏
            __weak typeof(self) weakSelf = self;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                
                weakSelf.progressView.hidden = YES;
                [weakSelf.progressView setProgress:0 animated:NO];
            });
            
        } else { // 加载中
            self.progressView.hidden = NO;
            [self.progressView setProgress:newprogress animated:YES];
        }
    } else { // 其他
        
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

//暂时不用
//- (void)dealloc {
//    NSLog(@"移除了KVO");
//    // 最后一步：移除监听的KVO
//    [self.wkWebview removeObserver:self forKeyPath:@"estimatedProgress" context:nil];
//
//}

-(void)setRemoDeallocKvo:(NSString *)remoDeallocKvo{
    _remoDeallocKvo = remoDeallocKvo;
    NSLog(@"移除了KVO");
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


#pragma mark======================WKWebView - alert不弹出（这是WKWebView相对于UIWebView的一个坑）===========================================
//WKWebView默认不响应js的alert()事件,如何可以开启alert权限呢?
//设置wkwebview.delegate = self;
//实现下面三个方法：
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }])];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
    
}
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler{
    //    DLOG(@"msg = %@ frmae = %@",message,frame);
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(NO);
    }])];
    [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(YES);
    }])];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
}
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:prompt message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.text = defaultText;
    }];
    [alertController addAction:([UIAlertAction actionWithTitle:@"完成" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(alertController.textFields[0].text?:@"");
    }])];
    
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
}


//WKWebView打开新界面 需要打开新界面是,WKWebView的代理WKUIDelegate方法
- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures {
    //    会拦截到window.open()事件.只需要我们在在方法内进行处理
    if (!navigationAction.targetFrame.isMainFrame) {
        [webView loadRequest:navigationAction.request];
    }
    return nil;
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


@end
