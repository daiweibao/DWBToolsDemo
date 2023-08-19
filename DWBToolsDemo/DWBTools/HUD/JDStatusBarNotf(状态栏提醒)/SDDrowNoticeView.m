//
//  SDDrowNoticeView.m
//  XiaoYuanSheQu
//
//  Created by 爱恨的潮汐 on 2017/9/28.
//  Copyright © 2017年 潮汐科技有限公司. All rights reserved.
//

#import "SDDrowNoticeView.h"

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

//#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
//#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

// 判断是否为iPhone4
//#define iPhone4 (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
//// 判断是否为iPhone5
//#define iPhone5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
//// 判断是否为iPhone6
//#define iPhone6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
// 判断是否为iPhone6 plus
#define iPhone6plus (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)

#define selfWith [UIScreen mainScreen].bounds.size.width
#define selfHeight (iPhoneX ? 54.f : 20.f)
#define spaceToParentView 10


@interface SDDrowNoticeView()<UIGestureRecognizerDelegate,UIActionSheetDelegate>{
    
    UIWindow *wd;
}
@end

@implementation SDDrowNoticeView

/**
 状态栏提醒，背景黑色，传入标题就可以
 
 @param title 标题
 */
+(void)showJDStatusBarMySelfIPhoneX:(NSString*)title{
    //判空
    if ([NSString isNULL:title]) {
        return;
    }
    NSArray * array = @[title];
    SDDrowNoticeView * drowView = [[SDDrowNoticeView alloc] init:array];
    drowView.frame = CGRectMake(0, - selfHeight, selfWith, selfHeight);
    [[UIApplication sharedApplication].keyWindow addSubview:drowView];
    [drowView animationDrown];
}

- (instancetype)init:(NSArray*)arr{
    
    if ([super init]) {
        
        UIView *backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, selfWith, selfHeight)];
        backGroundView.backgroundColor = [UIColor blackColor];
        [self addSubview:backGroundView];
        [self buildUI:arr inView:backGroundView];
        
        //遮盖状态栏方法
        wd = [self mainWindow];
        [wd addSubview:self];
        wd.windowLevel = UIWindowLevelAlert;
        
        //添加向上的轻扫手势
        UISwipeGestureRecognizer *swipGR = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipaction:)];
        swipGR.direction = UISwipeGestureRecognizerDirectionUp;
        [self addGestureRecognizer:swipGR];
        
        
    }return self;
    
}

/**
 获取window
 */
- (UIWindow*)mainWindow{
    
    UIApplication *app = [UIApplication sharedApplication];
    if ([app.delegate respondsToSelector:@selector(window)])
    {
        return [app.delegate window];
    }
    else
    {
        return [app keyWindow];
    }
}

/**
 轻扫手势(向上)
 */
- (void)swipaction:(UISwipeGestureRecognizer*)sender{
    if (sender.state == UIGestureRecognizerStateEnded) {
        [self animationUP:0.15f delay:0.f];
    }
    
}

/**
 向下弹出动画
 */
- (void)animationDrown{
    
    [UIView animateWithDuration:0.25f delay:0.f options:UIViewAnimationOptionCurveEaseOut animations:^{
        CGPoint center = self.center;
        center.y += selfHeight;
        self.center = center;
    } completion:^(BOOL finished) {
        //延迟执行,避免过早删除
        [self performSelector:@selector(overs) withObject:nil afterDelay:1.5f];
        
    }];
    
}
- (void)overs{
    //第二个参数是消失时间，默认2.0秒
    [self animationUP:0.3f delay:2.0f];
}

/**
 向上收回动画
 
 @param duration 动画时间
 @param durationDelay 延迟时间
 */
- (void)animationUP:(CGFloat)duration delay:(CGFloat)durationDelay{
    
    [UIView animateWithDuration:duration delay:durationDelay options:UIViewAnimationOptionCurveEaseIn animations:^{
        CGPoint center = self.center;
        center.y -= selfHeight;
        self.center = center;
    } completion:^(BOOL finished) {
        wd.windowLevel = UIWindowLevelNormal;
        [self removeFromSuperview];
    }];
}

/**
 构建UI
 
 @param arr 信息数据
 @param view 实例
 */
- (void)buildUI:(NSArray*)arr inView:(UIView*)view{
    //显示消息
    UILabel *detailText = [[UILabel alloc] init];
    detailText.frame = CGRectMake(15.f, view.bottomY-20.f, SCREEN_WIDTH-30.f, 20.f);
    detailText.text = [arr firstObject];
    detailText.font = [UIFont systemFontOfSize:12.f];
    detailText.textColor = [UIColor whiteColor];
    detailText.textAlignment = NSTextAlignmentCenter;
    [view addSubview:detailText];
}

@end
