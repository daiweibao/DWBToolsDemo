//
//  UIView+GradientColors.m
//  aaa
//
//  Created by 季文斌 on 2023/9/21.
//  Copyright © 2023 Alibaba. All rights reserved.
//

#import "UIView+GradientColors.h"

@implementation UIView (GradientColors)
/// 设置渐变颜色
/// @param colors 颜色数组 [UIColor redColor]
/// @param position 渐变方向
-(void)setGradientColors:(NSArray *)colors andGradientPosition:(GradientPosition)position
{
    //颜色转化
    NSMutableArray *marrayColors = [NSMutableArray array];
    for(int i = 0; i< colors.count;i++){
        UIColor *coloMy =colors[i];
        [marrayColors addObject:(__bridge id)coloMy.CGColor];
    }
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = marrayColors;
    switch (position) {
        case PositonHorizontal:
            gradientLayer.startPoint = CGPointMake(0, 0);
            gradientLayer.endPoint = CGPointMake(1.0, 0);
            break;
        case PositonVertical:
            gradientLayer.startPoint = CGPointMake(0, 0);
            gradientLayer.endPoint = CGPointMake(0, 1.0);
            break;
        case PositionUpLeft:
            gradientLayer.startPoint = CGPointMake(0, 0);
            gradientLayer.endPoint = CGPointMake(1.0, 1.0);
            break;
        case PositionUpRight:
            gradientLayer.startPoint = CGPointMake(1.0, 0);
            gradientLayer.endPoint = CGPointMake(0, 1.0);
            break;
        default:
            break;
    }

    gradientLayer.frame = self.bounds;
    [self.layer addSublayer:gradientLayer];
    
}

@end
