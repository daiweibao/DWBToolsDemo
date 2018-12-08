//
//  UIViewController+CXHelp.m
//  AiHenDeChaoXi
//
//  Created by 戴维保 on 2018/7/19.
//  Copyright © 2018年 北京嗅美科技有限公司. All rights reserved.
//

#import "UIViewController+CXHelp.h"

@implementation UIViewController (CXHelp)


//获取Window当前显示的ViewController
+ (UIViewController*)getTopWindowController{
    //获得当前活动窗口的根视图
    UIViewController* vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (1)
    {
        //根据不同的页面切换方式，逐步取得最上层的viewController
        if ([vc isKindOfClass:[UITabBarController class]]) {
            vc = ((UITabBarController*)vc).selectedViewController;
        }
        if ([vc isKindOfClass:[UINavigationController class]]) {
            vc = ((UINavigationController*)vc).visibleViewController;
        }
        if (vc.presentedViewController) {
            vc = vc.presentedViewController;
        }else{
            break;
        }
    }
    return vc;
}


/**
 移除销毁导航中的指定控制器，在当前控制器controller--push后再调用
 
 @param controller 要销毁的控制器
 */
+(void)removeAnyController:(UIViewController *)controller{
    //    比如从A push 到 B 在从push到C ，然后从C pop直接回A，此时可以在B push到后把B销毁了
    //在当前控制器controller--push后再调用，不能再前面调用
    
    
    if (![[UIViewController getTopWindowController].navigationController.viewControllers containsObject:controller]){
        return;//控制器不在导航中,必须判断，否者会崩溃
    }
    
      //【题外话，这一条跟销毁控制器这个方法无关】注意控制器不走dealloc方法，在控制器里所有block都要用weak修饰，否则不走
    NSMutableArray *marr = [[NSMutableArray alloc]initWithArray:controller.navigationController.viewControllers];
    for (UIViewController *vc in marr) {
        if ([vc isKindOfClass:[controller class]]) {
            [marr removeObject:vc];
            break;
        }
    }
    controller.navigationController.viewControllers = marr;
    //    记得break；否则会出一些小问题
    //    之前也试着使用过self removeFromParentViewController];[这个方法，但是会出现小得问题就放弃使用了。
}

@end
