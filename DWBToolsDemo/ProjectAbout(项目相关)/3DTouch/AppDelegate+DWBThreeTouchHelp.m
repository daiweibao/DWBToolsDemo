//
//  AppDelegate+DWBThreeTouchHelp.m
//  YueZhuan
//
//  Created by chaoxi on 2019/3/5.
//  Copyright © 2019 chaoxi科技有限公司. All rights reserved.
//

#import "AppDelegate+DWBThreeTouchHelp.h"

//#import "YZMyGetMoneyController.h"
//#import "YZMyIntegralController.h"
//#import "YZMyFriendsMainVC.h"
//#import "YZMyOrderViewController.h"

@implementation AppDelegate (DWBThreeTouchHelp)

//3D Touch
-(void)ThreeDTouch{
    
    //判断
    if (ios9_1orLater) {
        
        /**
         *  通过代码实现动态菜单
         *  一般情况下设置主标题、图标、type等，副标题是不设置的 - 简约原则
         *  iconWithTemplateImageName 自定义的icon
         *  iconWithType 系统的icon
         */
        
        NSArray * arrayTitle = @[@"我的收益",@"我的元宝",@"我的好友",@"我的订单"];
        
        //系统ShortcutIcon
        //        UIApplicationShortcutIcon * sendTopic = [UIApplicationShortcutIcon iconWithTemplateImageName:@"编辑"];
        UIApplicationShortcutIcon * sendTopic = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypePlay];
        UIApplicationShortcutItem *itemOne = [[UIApplicationShortcutItem alloc] initWithType:@"one" localizedTitle:arrayTitle[0] localizedSubtitle:nil icon:sendTopic userInfo:nil];
        
        
        //UIApplicationShortcutIcon * Sign = [UIApplicationShortcutIcon iconWithTemplateImageName:@"签到有礼"];
        UIApplicationShortcutIcon * Sign = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeLove];
        UIApplicationShortcutItem * itemTwo = [[UIApplicationShortcutItem alloc] initWithType:@"two" localizedTitle:arrayTitle[1] localizedSubtitle:nil icon:Sign userInfo:nil];
        
        
        //系统图标
        UIApplicationShortcutIcon * xiumeiHome = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeShare];
        //汉字
        UIApplicationShortcutItem * itemThree = [[UIApplicationShortcutItem alloc] initWithType:@"three" localizedTitle:arrayTitle[2] localizedSubtitle:nil icon:xiumeiHome userInfo:nil];
        
        
        //自定义ShortcutIcon
        //    UIApplicationShortcutIcon * LoveTopic = [UIApplicationShortcutIcon iconWithTemplateImageName:@"发布心情图标"];
        UIApplicationShortcutIcon * shopping = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeDate];
        UIApplicationShortcutItem * itemFoure = [[UIApplicationShortcutItem alloc] initWithType:@"four" localizedTitle:arrayTitle[3] localizedSubtitle:nil icon:shopping userInfo:nil];
        
        [UIApplication sharedApplication].shortcutItems = @[itemOne,itemTwo,itemThree,itemFoure];
        
    }
    
}

//3D Touch菜单点击事件
- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler{
    //3D touch跳转
    NSString * type = shortcutItem.type;
    //push控制器
    UINavigationController * nav = [(UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController selectedViewController];
//    if ([type isEqualToString:@"one"]) {
//        if ([YZLoginModel memberGetLoginStatus]==NO) {
//            //去登录
//            YZLoginVC *vc = [[YZLoginVC alloc] init];
//            vc.isPush = YES;
//            [YZNetworkManager pushViewController:vc];
//        }else{
//            
//            //我的收益
//            YZMyGetMoneyController * VC = [[YZMyGetMoneyController alloc]init];
//            [nav pushViewController:VC animated:YES];
//        }
//        
//    }else if ([type isEqualToString:@"two"]){
//        if ([YZLoginModel memberGetLoginStatus]==NO) {
//            //去登录
//            YZLoginVC *vc = [[YZLoginVC alloc] init];
//            vc.isPush = YES;
//            [YZNetworkManager pushViewController:vc];
//        }else{
//            //我的元宝
//            YZMyIntegralController * VC = [[YZMyIntegralController alloc]init];
//            [nav pushViewController:VC animated:YES];
//            
//        }
//    }else if ([type isEqualToString:@"three"]){
//        if ([YZLoginModel memberGetLoginStatus]==NO) {
//            //去登录
//            YZLoginVC *vc = [[YZLoginVC alloc] init];
//            vc.isPush = YES;
//            [YZNetworkManager pushViewController:vc];
//        }else{
//            //我的好友
//            YZMyFriendsMainVC *vc = [[YZMyFriendsMainVC alloc] init];
//            [nav pushViewController:vc animated:YES];
//            
//        }
//    }else if ([type isEqualToString:@"four"]){
//        if ([YZLoginModel memberGetLoginStatus]==NO) {
//            //去登录
//            YZLoginVC *vc = [[YZLoginVC alloc] init];
//            vc.isPush = YES;
//            [YZNetworkManager pushViewController:vc];
//        }else{
//            //我的订单
//            YZMyOrderViewController *vc = [[YZMyOrderViewController alloc] init];
//            [nav pushViewController:vc animated:YES];
//        }
//    }
}



@end
