//
//  UIView+GradientColors.h
//  aaa
//
//  Created by 季文斌 on 2023/9/21.
//  Copyright © 2023 Alibaba. All rights reserved.
//
//设置渐变色背景
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, GradientPosition){
    PositonHorizontal,//横向：从左到右
    PositonVertical,//竖向：从上到下
    PositionUpLeft,//左上->右下
    PositionUpRight,//右上->左下
};


@interface UIView (GradientColors)

/// 设置渐变颜色
/// @param colors 颜色数组 [UIColor redColor]
/// @param position 渐变方向
-(void)setGradientColors:(NSArray *)colors andGradientPosition:(GradientPosition)position;

@end

/**
 
 
 */

NS_ASSUME_NONNULL_END
