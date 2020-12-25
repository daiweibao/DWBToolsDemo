//
//  UIViewController+CXHelp.h
//  AiHenDeChaoXi
//
//  Created by chaoxi on 2018/7/19.
//  Copyright © 2018年 chaoxi科技有限公司. All rights reserved.
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


/// 判断当前控制器是从那个控制器push进来的,返回控制器名称字符串
/// @param controller 当前控制器
+ (NSString *)findPushEntWithController:(UIViewController *)controller;

@end
