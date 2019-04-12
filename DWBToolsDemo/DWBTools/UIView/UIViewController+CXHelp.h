//
//  UIViewController+CXHelp.h
//  AiHenDeChaoXi
//
//  Created by 戴维保 on 2018/7/19.
//  Copyright © 2018年 北京嗅美科技有限公司. All rights reserved.
//-

#import <UIKit/UIKit.h>

@interface UIViewController (CXHelp)

//在Category中定义属性：controllerId
@property (nonatomic,copy) NSString * controllerId;

/**
 获取Window当前显示的ViewController

 @return 结果
 */
+ (UIViewController*)getTopWindowController;

/**
 移除销毁导航中的指定控制器，在当前控制器controller--push后再调用
 
 @param controller 要销毁的控制器
 */
+(void)removeAnyController:(UIViewController *)controller;

/**
 导航栏push模拟模态动画
 
 @param pushVC 跳转的控制器
 */
+(void)navPushToPresentWithPushController:(UIViewController *)pushVC;
/**
 导航栏pop模拟模态动画,前提条件是push模拟模态动画进来的
 */
+(void)navPopToPresent;

@end
