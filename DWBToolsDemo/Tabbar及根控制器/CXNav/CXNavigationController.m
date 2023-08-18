//
//  CXNavigationController.m
//  Divination
//
//  Created by 戴维保 on 2023/8/19.
//  Copyright © 2023年 北京嗅美科技有限公司. All rights reserved.
//

#import "CXNavigationController.h"
#import "CXTabBarController.h"
#import "CXBaseViewController.h"

#import "ToolsEntController.h"//测试

#import "HopmeViewController.h"//首页


@interface CXNavigationController ()<UINavigationControllerDelegate,UIGestureRecognizerDelegate>

@end

@implementation CXNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //（方法一）开启系统边缘侧滑返回
//    self.interactivePopGestureRecognizer.delegate = (id)self;
    
    //三方库：全屏侧滑返回：在UINavigationController+SXFullScreen里gestureRecognizerShouldBegin设置
    
    //设置导航栏属性
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:19],NSForegroundColorAttributeName:[UIColor blackColor]}];
    
//    //是否透明设置：YES是透明
    self.navigationController.navigationBar.translucent = NO;
    
    //info里添加：View controller-based status bar appearance 设置为NO
    //设置状态栏的字体颜色
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    
}

////状态栏默认状态栏颜色-暂未启用，需要View controller-based status bar appearance 设置为YES
//- (UIStatusBarStyle)preferredStatusBarStyle
//{
//    return UIStatusBarStyleLightContent;
//}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        //返回键
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"nav_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
        backItem.imageInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        viewController.navigationItem.leftBarButtonItem = backItem;
        
        //隐藏tabbar
        viewController.hidesBottomBarWhenPushed = YES;
        //隐藏tabbar
        [[CXTabBarController shareTabBarController] hideTheTabbar];
    } else {
        viewController.hidesBottomBarWhenPushed = NO;
    }
    [super pushViewController:viewController animated:animated];
}

//返回键点击事件
- (void)back {
    [self popViewControllerAnimated:YES];
}


- (NSArray<__kindof UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated {
    if (self.viewControllers.count > 1) {
//        self.topViewController.hidesBottomBarWhenPushed = NO;
    }
    return [super popToRootViewControllerAnimated:animated];
}


#pragma mark - UINavigationControllerDelegate
//控制器如果继承DTViewController，则此方法失效
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
//【导航栏隐藏】判断如果是需要隐藏导航控制器的类，则隐藏（如果你要影藏某个类的导航，请把控制器添加到如下）
//    [viewController isKindOfClass:NSClassFromString(@"HomeViewController")
    BOOL isHideNav = ([viewController isKindOfClass:[ToolsEntController class]]||
                      [viewController isKindOfClass:[CXBaseViewController class]]||
                      [viewController isKindOfClass:[HopmeViewController class]]
                     

                      );
    [self setNavigationBarHidden:isHideNav animated:YES];

    //【注意】：presentViewController模态跳转的控制器导航影藏无效（模态后再push的控制影藏器也无效，需要用如下方式影藏），需要手动在控制器生命周期里自己影藏

//  如果项目中带导航模态一定要用:HSBaseNavigationController导航跳转
//    [self presentViewController:[[HSBaseNavigationController alloc] initWithRootViewController:loginVC] animated:YES completion:NULL];
    /*
    //将要出现
    -(void)viewWillAppear:(BOOL)animated{
        [super viewWillAppear:animated];
        //影藏导航栏，一定要用动画方式
        [self.navigationController setNavigationBarHidden:YES animated:animated];
    }

    //将要消失
    -(void)viewWillDisappear:(BOOL)animated{
        [super viewWillDisappear:animated];
        //打开导航栏，一定要用动画方式
        [self.navigationController setNavigationBarHidden:NO animated:animated];
    }
    */
}





@end
