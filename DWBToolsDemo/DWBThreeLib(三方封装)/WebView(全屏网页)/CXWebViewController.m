//
//  CXWebViewController.m
//  AiHenDeChaoXi
//
//  Created by 爱恨的潮汐 on 2018/4/2.
//  Copyright © 2018年 潮汐科技有限公司. All rights reserved.
//

#import "CXWebViewController.h"

@interface CXWebViewController ()<UIWebViewDelegate>
//网页
@property (strong, nonatomic) UIWebView *webView;
//进度条
@property (strong, nonatomic) UIProgressView *progressView;

@end

@implementation CXWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //导航
//    if ([NSString isNULL:self.titleNavStr]) {
//        self.titleNavLabel.text = @"网页";
//    }else{
//        self.titleNavLabel.text = self.titleNavStr;
//    }
    
    //网页判空
    if (![[UIApplication sharedApplication] canOpenURL: [NSURL URLWithString: self.urlWebStr]]) {
        //网页不能打开
        [DWBAlertView AlertCXAlertCenterAllWithController:self Title:nil Message:@"该网页已失效~" otherItemArrays:@[@"知道啦"]  Type:-1 handler:^(NSInteger index) {
            if (index==0) {
                //返回
                [self.navigationController popViewControllerAnimated:YES];
            }
        }];
    }
    
    
    //初始化网页
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, MC_NavHeight, SCREEN_WIDTH, SCREEN_HEIGHT-MC_NavHeight-MC_TabbarSafeBottomMargin)];
    _webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _webView.delegate = self;
    //网页加载
    NSURL *url = [NSURL URLWithString:self.urlWebStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
    //关闭垂直滚动条
    // _webView.scrollView.showsVerticalScrollIndicator = NO;
    //水平滚动条
    _webView.scrollView.showsHorizontalScrollIndicator = NO;
    adjustsScrollViewInsets_NO(_webView.scrollView, self);//适配iOS11,必须
    [self.view addSubview:_webView];
    
    //进度条UIProgressView初始化
    self.progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleBar];
    self.progressView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 3);
    self.progressView.trackTintColor = [UIColor clearColor];
    self.progressView.progressTintColor = MAIN_COLOR;//设置进度条的色彩
    [_webView addSubview:self.progressView];
    // 设置初始的进度，防止用户进来就懵逼了（微信大概也是一开始设置的10%的默认值）
    [self.progressView setProgress: 0.1 animated:YES];
    
    //进度条模拟
    [self sowMyProgressView];
    
}

//返回
-(void)pressButtonLeft:(UIButton *)button{
    //网页一层一层的返回，通过自己创建的返回按钮来控制网页的返回--太好用了
    if (_webView.canGoBack == YES) {
        [_webView goBack];
    }else{
        //最后返回
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

//模拟进度条
-(void)sowMyProgressView{
    //延迟1.5秒走进度条--假的
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //防止进度条倒流
        if (self.progressView.progress<0.8) {
            [self.progressView setProgress: 0.8 animated:YES];
        }
        
    });
}

//网页开始加载，暂时不用重走进度条
- (void)webViewDidStartLoad:(UIWebView *)webView{
    //    //默认值
    //    self.progressView.hidden = NO;
    //    if (self.progressView.progress<0.1) {
    //        [self.progressView setProgress: 0.1 animated:YES];
    //    }
    //    //进度条模拟
    //    [self sowMyProgressView];
    
}

//网页加载完成
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    //进度条首先加载到头
    [self.progressView setProgress:1 animated:YES];
    // 之后0.3秒延迟隐藏
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        weakSelf.progressView.hidden = YES;
        [weakSelf.progressView setProgress:0 animated:NO];
    });
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType returnValue:(BOOL)returnValue{
    
    return YES;
}



-(void)dealloc{
    NSLog(@"项目共用UIWebView走了dealloc");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
