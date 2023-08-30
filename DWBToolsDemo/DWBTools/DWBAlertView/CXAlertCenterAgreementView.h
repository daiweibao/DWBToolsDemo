//
//  CXAlertCenterAgreementView.h
//  aaa
//
//  Created by 季文斌 on 2023/8/10.
//  Copyright © 2023 Alibaba. All rights reserved.
//
//隐私协议或者公告中间弹窗-内容较多时候，开始上下滚动
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^ActionBlockAtIndex)(NSInteger indexCenter);

@interface CXAlertCenterAgreementView : UIView

//回调经按钮tage
@property (nonatomic, copy) ActionBlockAtIndex actionBlockAtIndex;

/**
 自己封装的aleat中间弹窗
 
 @param controller 弹窗所在控制器
 @param title 标题
 @param message 内容
 @param array 按钮
 @param type 类型，-1代表默认，0代表成功；40代表内容文字左对齐
 @param block 回调 回调：0代表点击第一个按钮，1代表点击第二个按钮
 */
+ (void)AlertCXCenterAlertWithController:(UIViewController*)controller Title:(NSString*)title Message:(NSString *)message otherItemArrays:(NSArray *)array Type:(NSInteger)type handler:(ActionBlockAtIndex)block;

@end

NS_ASSUME_NONNULL_END
