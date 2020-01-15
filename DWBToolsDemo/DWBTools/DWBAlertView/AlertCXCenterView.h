//
//  AlertCXImageView.h
//  AiHenDeChaoXi
//
//  Created by 戴维保 on 2018/4/12.
//  Copyright © 2018年 潮汐科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ActionBlockAtIndex)(NSInteger indexCenter);
@interface AlertCXCenterView : UIView
//回调经按钮tage
@property (nonatomic, copy) ActionBlockAtIndex actionBlockAtIndex;

/**
 自己封装的aleat中间弹窗
 
 @param controller 弹窗所在控制器
 @param title 标题
 @param message 内容
 @param array 按钮
 @param type 类型，0代表成功（默认成功） 1代表失败 100代表允许重复弹窗 ,200代表允许移除老的弹窗，展示新的弹窗（推送用）
 @param block 回调
 */
+ (void)AlertCXCenterAlertWithController:(UIViewController*)controller Title:(NSString*)title Message:(NSString *)message otherItemArrays:(NSArray *)array Type:(NSInteger)type handler:(ActionBlockAtIndex)block;

@end
