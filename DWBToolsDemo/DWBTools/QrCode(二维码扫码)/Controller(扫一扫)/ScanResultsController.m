//
//  ScanResultsController.m
//  AiHenDeChaoXi
//
//  Created by chaoxi on 2018/4/2.
//  Copyright © 2018年 chaoxi科技有限公司. All rights reserved.
//

#import "ScanResultsController.h"

@interface ScanResultsController ()<UIWebViewDelegate>
//网页
@property (strong, nonatomic) UIWebView *webView;
//进度条
@property (strong, nonatomic) UIProgressView *progressView;
@end

@implementation ScanResultsController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.titleNavLabel.text = @"扫描结果";
    
     //用网页展示，可以复制
    //初始化网页
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, MC_NavHeight, SCREEN_WIDTH, SCREEN_HEIGHT-MC_NavHeight)];
    _webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _webView.delegate = self;
    //网页加载
    [_webView loadHTMLString:self.scanResultsStr baseURL:nil];
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

@end
