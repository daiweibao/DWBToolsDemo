//
//  TBTabBar.h
//  TabbarBeyondClick
//
//  Created by 卢家浩 on 2017/4/17.
//  Copyright © 2017年 lujh. All rights reserved.
//
//自定义中间不占用一个TabBar，tabbar往后移动
#import <UIKit/UIKit.h>

@interface TBTabBar : UITabBar

@property (nonatomic,copy) void(^didClickPublishBtn)(CGFloat min_Y);

@end
