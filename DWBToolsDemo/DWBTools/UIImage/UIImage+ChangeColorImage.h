//
//  UIImage+ChangeColorImage.h
//  miniVideo
//
//  Created by 戴维保 on 2020/1/3.
//  Copyright © 2020 muhan. All rights reserved.
//
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface UIImage (ChangeColorImage)

typedef NS_ENUM(NSUInteger, GradientType) {
    GradientTypeTopToBottom = 0,//从上到下
    GradientTypeLeftToRight = 1,//从左到右
    GradientTypeUpleftToLowright = 2,//左上到右下
    GradientTypeUprightToLowleft = 3,//右上到左下
};

/// 设置图片的渐变色,用在Button上是设置成setBackgroundImage最好，否则会挡住汉字(颜色->图片)
/// @param colors 渐变颜色数组
/// @param gradientType 渐变样式
/// @param imgSize 图片大小
+ (UIImage *)gradientColorImageFromColors:(NSArray*)colors gradientType:(GradientType)gradientType imgSize:(CGSize)imgSize;

@end

NS_ASSUME_NONNULL_END
