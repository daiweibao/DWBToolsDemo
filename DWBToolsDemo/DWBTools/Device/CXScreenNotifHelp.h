//
//  CXScreenNotifHelp.h
//  aaa
//
//  Created by 季文斌 on 2023/11/7.
//  Copyright © 2023 Alibaba. All rights reserved.
//
///监听屏幕录制与截屏工具类
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CXScreenNotifHelp : NSObject

+ (CXScreenNotifHelp *)sharedManager;

///是否展示录屏截屏通知提示弹窗。默认不展示
@property (nonatomic, assign) BOOL isShowAleat;

/// 全局添加录屏和截屏监听，app启动后添加
- (void)addAllScreenNotif;


@end

NS_ASSUME_NONNULL_END

/**
 用法：
 //添加录屏截屏通知监听，全局只添加一个地方，App启动后
 [[CXScreenNotifHelp sharedManager] addAllScreenNotif];
 
 //单个页面开启
 //将要出现
 -(void)viewWillAppear:(BOOL)animated{
     [super viewWillAppear:animated];
     //添加截屏录屏通知
     [CXScreenNotifHelp sharedManager].isShowAleat =YES;
 }

 //将要消失
 -(void)viewWillDisappear:(BOOL)animated{
     [super viewWillDisappear:animated];
     //移除截屏录屏通知
     [CXScreenNotifHelp sharedManager].isShowAleat =NO;
 }
 
 
 */
