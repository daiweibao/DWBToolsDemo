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


/// 获取当前显示的控制器
+(UIViewController *)getCurrentVC{
    UIViewController *result = nil;

    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for (UIWindow *temp in windows) {
            if (temp.windowLevel == UIWindowLevelNormal) {
                window = temp;
                break;
            }
        }
    }
    //取当前展示的控制器
    result = window.rootViewController;
    while (result.presentedViewController) {
        result = result.presentedViewController;
    }
    //如果为UITabBarController：取选中控制器
    if ([result isKindOfClass:[UITabBarController class]]) {
        result = [(UITabBarController *)result selectedViewController];
    }
    //如果为UINavigationController：取可视控制器
    if ([result isKindOfClass:[UINavigationController class]]) {
        result = [(UINavigationController *)result visibleViewController];
    }
    return result;
}


/// 获取当前显示的控制器
+(UIViewController *)getCurrentVCTWO
{
    UIViewController *result =nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal){
        NSArray *windows = [[UIApplication sharedApplication]windows];
        for(UIWindow *tmpWin in windows){
            if (tmpWin.windowLevel == UIWindowLevelNormal){
                window = tmpWin;
                break;
            }
        }
    }
    //从根控制器开始查找
    UIViewController *rootVC = window.rootViewController;
    id nextResponder = [rootVC.view nextResponder];
    if([nextResponder isKindOfClass:[UINavigationController class]]) {
        result = ((UINavigationController*)nextResponder).topViewController;
        if([result isKindOfClass:[UITabBarController class]]){
            result = ((UITabBarController*)result).selectedViewController;
        }
    }else if([nextResponder isKindOfClass:[UITabBarController class]]) {
        result = ((UITabBarController*)nextResponder).selectedViewController;
        if([result isKindOfClass:[UINavigationController class]]){
            result = ((UINavigationController*)result).topViewController;
        }
    }else if([nextResponder isKindOfClass:[UIViewController class]]){
        result = nextResponder;
    }else{
        result = window.rootViewController;
        if([result isKindOfClass:[UINavigationController class]]){
            result = ((UINavigationController*)result).topViewController;
            if([result isKindOfClass:[UITabBarController class]]){
                result = ((UITabBarController*)result).selectedViewController;
            }
        }else if([result isKindOfClass:[UIViewController class]]) {
            result = nextResponder;
        }
    }
    return result;
}




/**
 移除销毁导航中的指定控制器，在当前控制器controller--push后再调用
 
 @param controller 要销毁的控制器
 */
+(void)removeAnyController:(UIViewController *)controller{
    //    比如从A push 到 B 在从push到C ，然后从C pop直接回A，此时可以在B push到后把B销毁了
    //在当前控制器controller--push后再调用，不能再前面调用
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
