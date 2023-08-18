//
//  DWBURLWKWebView.m
//  DouZhuan
//
//  Created by 戴维保 on 2018/9/26.
//  Copyright © 2018 品创时代互联网科技（北京）有限公司. All rights reserved.
//

#import "DWBURLWKWebView.h"

#import "JZAlbumViewController.h"//图片浏览器
//#import "HZPhotoBrowser.h"
@interface DWBURLWKWebView()<WKNavigationDelegate,UIGestureRecognizerDelegate>
//URL
@property(nonatomic,copy)NSString * urlString;

//类型
@property(nonatomic,strong)NSString * typeString;

//图片链接数组
@property (strong, nonatomic)NSMutableArray * mArrayUrl;

@end


@implementation DWBURLWKWebView

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
    
//    //添加长按手势
//    UILongPressGestureRecognizer *longPressRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
//    longPressRecognizer.allowableMovement = 20;
//    longPressRecognizer.minimumPressDuration = 1.0f;
//    [self addGestureRecognizer:longPressRecognizer];
//
//    //添加点击手势（点击查看大图）
//    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapPress:)];
//    tap.delegate = self;
//    [self addGestureRecognizer:tap];
    
    
    //KVO获取网页高度
    [self.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
    
}

//加载数据
-(void)WebViewload{
  //加载url
  [self loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]]];
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
//            //销毁通知KVO
//            [self.scrollView removeObserver:self forKeyPath:@"contentSize" context:nil];
            
            
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
    
    
    //通过js获取htlm中图片url
    [self getImageUrlByJSImgUrl:webView];
   
    
}

// 类似 UIWebView 的 -webView: shouldStartLoadWithRequest: navigationType:
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
   //浏览图片
    [self showBigImage:navigationAction.request];
    
    decisionHandler(WKNavigationActionPolicyAllow);
}
#pragma mark ========= 点击获取所有图片，并查看大图 ========================
//通过js获取htlm中图片url
-(NSArray *)getImageUrlByJSImgUrl:(WKWebView *)wkWebView{
    
    //js方法遍历图片添加点击事件返回图片个数
    //这里是js，主要目的实现对url的获取
    static  NSString * const jsGetImages =
    @"function getImages(){\
    var objs = document.getElementsByTagName(\"img\");\
    var imgScr = '';\
    for(var i=0;i<objs.length;i++){\
    imgScr = imgScr + objs[i].src + '+';\
    objs[i].onclick=function(){\
    document.location=\"myweb:imageClick:\"+this.src;\
    };\
    };\
    return imgScr;\
    };";
    
    //用js获取全部图片,传质给js
    [wkWebView evaluateJavaScript:jsGetImages completionHandler:nil];
    
    //得到所有图片
    NSString *jsString = @"getImages()";
    __block NSArray *array=[NSArray array];
    
    [wkWebView evaluateJavaScript:jsString completionHandler:^(id Result, NSError * error) {
        
        NSString *resurlt=[NSString stringWithFormat:@"%@",Result];
        
        if([resurlt hasPrefix:@"+"]){
            
            resurlt=[resurlt substringFromIndex:1];
            
        }
        resurlt = [NSString removeLastOneChar:resurlt];
        NSArray * array=[resurlt componentsSeparatedByString:@"+"];
        
        [self setMethod:array];
        
    }];
    return array;
}
#pragma mark - 点击图片
static char imgUrlArrayKey;
- (void)setMethod:(NSArray *)imgUrlArray
{
    objc_setAssociatedObject(self, &imgUrlArrayKey, imgUrlArray, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSArray *)getImgUrlArray
{
    return objc_getAssociatedObject(self, &imgUrlArrayKey);
}
//显示大图
-(BOOL)showBigImage:(NSURLRequest *)request
{
    //将url转换为string
    NSString *requestString = [[request URL] absoluteString];
    
    //hasPrefix 判断创建的字符串内容是否以pic:字符开始
    if ([requestString hasPrefix:@"myweb:imageClick:"])
    {
        NSString *imageUrl = [requestString substringFromIndex:@"myweb:imageClick:".length];
        NSLog(@"image url------%@", imageUrl);
        
        NSArray *imgUrlArr=[self getImgUrlArray];
        NSInteger index=0;
        for (NSInteger i=0; i<[imgUrlArr count]; i++) {
            if([imageUrl isEqualToString:imgUrlArr[i]])
            {
                index=i;
                break;
            }
        }
        
//        HZPhotoBrowser *browser = [[HZPhotoBrowser alloc] init];
//        browser.isFullWidthForLandScape = YES;
//        browser.isNeedLandscape = YES;
//        browser.currentImageIndex = index;
//        browser.imageArray = imgUrlArr;
//        
//        [browser show];
        return NO;
    }
    return YES;
}


//block回调，控制器里调用
-(void)htmlWebViewURL:(NSString*)urlString Type:(NSString* _Nullable)typeString htmlHeightKVO:(void (^)(CGFloat webHeight))htmlHeight FinishLoadeEnd:(void (^)(CGFloat endHeight))FinishLoadeEnd{
    //类型放在最上面
    self.typeString = typeString;
    //内容
    self.urlString = urlString;
    
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
    [self.scrollView removeObserver:self forKeyPath:@"contentSize" context:nil];
    
}

/*
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


*/



@end
