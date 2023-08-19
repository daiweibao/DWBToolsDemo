//
//  UIViewController+CXHelp.h
//  AiHenDeChaoXi
//
//  Created by 爱恨的潮汐 on 2018/7/19.
//  Copyright © 2018年 潮汐科技有限公司. All rights reserved.
//-

#import <UIKit/UIKit.h>

@interface UIViewController (CXHelp)

/// 获取当前显示的控制器
+(UIViewController *)getCurrentVC;

/**
 移除销毁导航中的指定控制器，在当前控制器controller--push后再调用
 
 @param controller 要销毁的控制器
 */
+(void)removeAnyController:(UIViewController *)controller;

@end
