//
//  CXHUDLoading.m
//  aaa
//
//  Created by 季文斌 on 2023/10/26.
//  Copyright © 2023 Alibaba. All rights reserved.
//

#import "CXHUDLoading.h"

@interface CXHUDLoading ()
//加载中背景
@property (nonatomic, strong) UIView *loadingView;

@end

@implementation CXHUDLoading

+ (CXHUDLoading *)sharedManager {
    static CXHUDLoading * manager;//类
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[CXHUDLoading alloc] init];
        
    });
    return manager;
}

/// loding加载中
/// - Parameters:
///   - title: 标题
///   - view: 添加到那一块view上
+ (void)showLoadingWithTitle:(NSString *)title toView:(UIView *)view{
    
    [[CXHUDLoading sharedManager].loadingView removeFromSuperview];//先移除，防止重复创建
   
    //全屏背景
    [CXHUDLoading sharedManager].loadingView = [[UIView alloc]init];
    //把导航栏位置留出来，不要挡住
    [CXHUDLoading sharedManager].loadingView.frame = CGRectMake(0, 0, view.width, view.height);
    [CXHUDLoading sharedManager].loadingView.backgroundColor = [UIColor clearColor];
    [view addSubview:[CXHUDLoading sharedManager].loadingView];
    //添加点击手势（拦截点击事件）
    [CXHUDLoading sharedManager].loadingView.userInteractionEnabled = YES;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:[CXHUDLoading sharedManager] action:@selector(ActionView)];
    [[CXHUDLoading sharedManager].loadingView addGestureRecognizer:tap];
    
    //内容背景
    UIView *loadingContentView = [[UIView alloc]init];
    loadingContentView.frame = CGRectMake((view.width-140)/2, (view.height-140)/2, 140, 140);
    loadingContentView.backgroundColor = [UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0.7];
    loadingContentView.layer.cornerRadius =6;
    [[CXHUDLoading sharedManager].loadingView addSubview:loadingContentView];

    
    //菊花： UIActivityIndicatorViewStyleWhiteLarge 白色圆圈，但是要大些，尺寸是（37，37）
    UIActivityIndicatorView * activeView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    //只能设置中心位置，不能设置frame；放大1.5倍后，大概是56*56
    activeView.center = CGPointMake(loadingContentView.width/2, 53);
    activeView.color = [UIColor whiteColor];
    [loadingContentView addSubview:activeView];
    //调整指示器大小
    CGAffineTransform transform = CGAffineTransformMakeScale(1.5f, 1.5f);//56*56
    activeView.transform = transform;
    //开始动画
    [activeView startAnimating];
    
    
    //提示文字
    UILabel * labelTitle = [[UILabel alloc]init];
    labelTitle.frame = CGRectMake(0, activeView.bottomY+10, loadingContentView.width, 20);
    labelTitle.text = title;
    labelTitle.textColor = [UIColor whiteColor];
    labelTitle.font = [UIFont systemFontOfSize:16];
    labelTitle.textAlignment = NSTextAlignmentCenter;
    [loadingContentView addSubview:labelTitle];
}

-(void)ActionView{
    //什么也不干，拦截点击事件
}

//移除loading
+ (void)hideHUDLoading{
    [[CXHUDLoading sharedManager].loadingView removeFromSuperview];
    [CXHUDLoading sharedManager].loadingView = nil;
}


@end
