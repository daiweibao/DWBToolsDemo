//
//  CXTabBarController.h
//  AiHenDeChaoXi
//
//  Created by 戴维保 on 2023/8/19.
//  Copyright © 2023年 北京嗅美科技有限公司. All rights reserved.
//
//自定义tabbar
#import <UIKit/UIKit.h>

@interface CXTabBarController : UITabBarController<UITabBarControllerDelegate>
///单利
+ (CXTabBarController *)shareTabBarController;
///创建tabbar
- (void)createTabbar;

///手动调用隐藏tabbar
- (void)hideTheTabbar;
///手动调用显示tabbar
- (void)showTheTabbar;

///选中一个指定tabbar：如登录成功后后选中首页等
- (void)selectMyTabbarWithIndex:(NSInteger )index;

@end
