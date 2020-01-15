//
//  LoadingCircleHUD.h
//  XiaoYuanSheQu
//
//  Created by 戴维保 on 16/9/4.
//  Copyright © 2016年 潮汐科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadingCircleHUD : UIView
//default is 1.0f
@property (nonatomic, assign) CGFloat lineWidth;

//default is [UIColor lightGrayColor]
@property (nonatomic, strong) UIColor *lineColor;

@property (nonatomic, readonly) BOOL isAnimating;

//新的转圈圈的小刷新加载控件控件

//初始化及坐标
- (id)initWithFrame:(CGRect)frame;
//开始
- (void)startAnimation;
//停止
- (void)stopAnimation;

//用法
//  HYCircleLoadingView * loadingView = [[HYCircleLoadingView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
// [self.view addSubview:loadingView];
//- (void)startButtonClick:(UIButton *)button
//{
//    [loadingView startAnimation];
//}
//
//- (void)stopButtonClick:(UIButton *)button
//{
//    [loadingView stopAnimation];
//}


@end
