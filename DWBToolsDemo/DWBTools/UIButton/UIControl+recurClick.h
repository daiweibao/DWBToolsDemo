//
//  UIControl+recurClick.h
//
//
//  Created by King on 16/9/2.
//  Copyright © 2016年 King. All rights reserved.
//
//主要解决按钮的重复点击问题，设置间隔多久可以点击一次
#import <UIKit/UIKit.h>

@interface UIControl (recurClick)

@property (nonatomic, assign) NSTimeInterval mm_acceptEventInterval;
@property (nonatomic, assign) BOOL showFlash; ///< 点击动画

@end
/**
 用法：
 self.commitBtn.mm_acceptEventInterval = 1.f;
 
 */

