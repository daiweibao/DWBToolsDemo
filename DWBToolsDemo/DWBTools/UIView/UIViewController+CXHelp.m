//
//  UIViewController+CXHelp.m
//  AiHenDeChaoXi
//
//  Created by 戴维保 on 2018/7/19.
//  Copyright © 2018年 潮汐科技有限公司. All rights reserved.
//

#import "UIViewController+CXHelp.h"
//导入头文件
#import <objc/runtime.h>

//在setControllerId:方法中使用了一个objc_setAssociatedObject的方法，这个方法有四个参数，分别是：源对象，关联时的用来标记是哪一个属性的key（因为你可能要添加很多属性），关联的对象和一个关联策略。用来标记是哪一个属性的key常见有三种写法，但代码效果是一样的，如下：
static void *controllerIdKey = &controllerIdKey; //Id的key

@implementation UIViewController (CXHelp)
#pragma mark ==================用runtime添加属性==========================
- (NSObject *)controllerId {//get方法
    return objc_getAssociatedObject(self, &controllerIdKey);
}
-(void)setControllerId:(NSString *)controllerId{//set方法
    objc_setAssociatedObject(self, &controllerIdKey, controllerId, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
//typedef OBJC_ENUM(uintptr_t, objc_AssociationPolicy) {
//    OBJC_ASSOCIATION_ASSIGN = 0,             //关联对象的属性是弱引用
//    OBJC_ASSOCIATION_RETAIN_NONATOMIC = 1,   //关联对象的属性是强引用并且关联对象不使用原子性
//    OBJC_ASSOCIATION_COPY_NONATOMIC = 3,     //关联对象的属性是copy并且关联对象不使用原子性
//    OBJC_ASSOCIATION_RETAIN = 01401,         //关联对象的属性是copy并且关联对象使用原子性
//    OBJC_ASSOCIATION_COPY = 01403            //关联对象的属性是copy并且关联对象使用原子性
//};



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



/**
 导航栏push模拟模态动画

 @param pushVC 跳转的控制器
 */
+(void)navPushToPresentWithPushController:(UIViewController *)pushVC{
    
    //当前显示控制器
    UIViewController * controller = [UIViewController getTopWindowController];
    //动画
    CATransition *transition = [CATransition animation];
    transition.duration = 0.4f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    transition.type = kCATransitionMoveIn;
    transition.subtype = kCATransitionFromTop;
    [pushVC.view.layer addAnimation:transition forKey:nil];
    [controller.navigationController pushViewController:pushVC animated:NO];
//    注意：animated一定要设置为：NO
}



/**
 导航栏pop模拟模态动画,前提条件是push模拟模态动画进来的
 */
+(void)navPopToPresent{
    
    //当前显示控制器
    UIViewController * controller = [UIViewController getTopWindowController];
    //动画
    CATransition *transition = [CATransition animation];
    transition.duration = 0.3f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    transition.type = kCATransitionReveal;
    transition.subtype = kCATransitionFromBottom;
    [controller.view.layer addAnimation:transition forKey:nil];
    [controller.navigationController popViewControllerAnimated:NO];
}

+ (NSString *)findPushEntWithController:(UIViewController *)controller {
    NSArray *marr = controller.navigationController.viewControllers;
    UIViewController * findVC = nil;
    NSString *vcStr;
    if (marr.count>1) {//控制器必须大于等于2个，才是push进来的
        findVC = marr[marr.count-2];//拿到倒数第二个控制器
        vcStr = NSStringFromClass([findVC class]);
    }else{
        findVC = nil;//未找到控制器
        vcStr = @"";
    }
    return vcStr;//返回上一级控制器名称
}

@end
