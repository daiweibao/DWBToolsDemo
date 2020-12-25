//
//  AppDelegate.m
//  DWBToolsDemo
//
//  Created by 戴维保 on 2018/9/5.
//  Copyright © 2018年 潮汐科技有限公司. All rights reserved.
//

#import "AppDelegate.h"
//tabbar
#import "CXTabBarController.h"
#import "CXDinDinEventMessageHelp.h"
#import "AppCerashOpenHelp.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //创建app窗口
    [self createWindow];
    
//    AvoidCrash拦截崩溃三方库
    
    //AppDelegate里钉钉操作消息统计-初始化,AppDelegate里必须实现相应的代理方法(applicationDidBecomeActive、applicationDidEnterBackground)，否则会崩溃
    [[CXDinDinEventMessageHelp sharedInstance] startTimer];
    
    ///AppDelegate里初始化崩溃类
    [AppCerashOpenHelp sharedManager];
    
    return YES;
}

//创建appc窗口
-(void)createWindow{
    
    self.window = [[UIWindow alloc]initWithFrame:UIScreen.mainScreen.bounds];
    //设置窗口颜色
    self.window.backgroundColor = [UIColor whiteColor];

    //添加窗口
    [self.window makeKeyAndVisible ];
    
    //创建tabbar界面
    self.window.rootViewController = [[CXTabBarController alloc]init];
}



#pragma mark =============设置某个界面只支持视频横屏 S======================
//此方法会在设备横竖屏变化的时候调用
- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    
    //   NSLog(@"方向  =============   %ld", _allowRotate);
    if (_allowRotate == 1) {
        return UIInterfaceOrientationMaskAll;
    }else{
        return (UIInterfaceOrientationMaskPortrait);
    }
}


// 返回是否支持设备自动旋转
- (BOOL)shouldAutorotate
{
    if (_allowRotate == 1) {
        return YES;
    }
    return NO;
}
#pragma mark =============设置某个界面只支持视频横屏 E======================



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
