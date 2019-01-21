//
//  CXTabbar.h
//  AiHenDeChaoXi
//
//  Created by 戴维保 on 2018/7/7.
//  Copyright © 2018年 北京嗅美科技有限公司. All rights reserved.
//
//自定义中间占用一个TabBar
#import <UIKit/UIKit.h>

@interface CXTabbar : UITabBar

//点击或者按下
@property (nonatomic,copy) void(^didClickPublishBtn)(void);

//抬起或者其他取消操作
@property (nonatomic,copy) void(^didClickPublishBtnRemo)(void);


/*
 //这种方式需要设置一个空的跟控制器
 
 //语音
 CXVoiceMainController *voiceVC = [[CXVoiceMainController alloc] init];
 [self setChildVC:voiceVC title:@"" image:@""  selectedImage:@""];//什么都不设置
 
 */

@end
