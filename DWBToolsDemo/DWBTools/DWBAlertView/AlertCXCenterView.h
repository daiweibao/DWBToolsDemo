//
//  AlertCXImageView.h
//  AiHenDeChaoXi
//
//  Created by 爱恨的潮汐 on 2023/8/30.
//  Copyright © 2023年 潮汐科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ActionBlockAtIndex)(NSInteger indexCenter);
@interface AlertCXCenterView : UIView
//回调经按钮tage
@property (nonatomic, copy) ActionBlockAtIndex actionBlockAtIndex;

/**
 自己封装的aleat中间弹窗
 
 @param controller 弹窗所在控制器,一般用不到
 @param title 标题
 @param message 内容
 @param array 按钮
 @param type 类型，-1代表默认，0代表成功；40代表内容文字左对齐
 @param block 回调 回调：0代表点击第一个按钮，1代表点击第二个按钮
 */
+ (void)AlertCXCenterAlertWithController:(UIViewController*)controller Title:(NSString*)title Message:(NSString *)message otherItemArrays:(NSArray *)array Type:(NSInteger)type handler:(ActionBlockAtIndex)block;


/// 【系统的】中间弹窗框架封装
/// @param title 标题
/// @param message 提示语
/// @param array 按钮数组
/// @param type 类型，-1代表默认，0代表成功；40代表内容文字左对齐
/// @param actionBlock 回调：0代表点击第一个按钮，1代表点击第二个按钮
+ (void)AlertSystemCXCenterAlertWithTitle:(NSString*)title Message:(NSString *)message otherItemArrays:(NSArray <NSString *>*)array Type:(NSInteger)type handler:(void(^)(NSInteger indexCenter))actionBlock;

@end
