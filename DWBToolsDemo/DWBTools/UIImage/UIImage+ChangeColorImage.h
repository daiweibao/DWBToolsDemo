//
//  UIImage+ChangeColorImage.h
//  miniVideo
//
//  Created by 潮汐 on 2020/1/3.
//  Copyright © 2020 muhan. All rights reserved.
//
//根据颜色生成渐变色图片
#import <UIKit/UIKit.h>

///【红色渐变】渐变 #F93F20 #FF7B65
#define getChangeColor_Red_ImageSize(w,h) [UIImage gradientColorImageFromColors:@[UIColorFromRGB(0xFF7B65),UIColorFromRGB(0xF93F20)] gradientType:GradientTypeTopToBottom imgSize:CGSizeMake(w, h)]

//按钮未选中时的灰色图片
#define getGrayImageSize(w,h) [UIImage imageWithColor:UIColorFromRGB(0x999999) size:CGSizeMake(w, h)]

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (ChangeColorImage)

typedef NS_ENUM(NSUInteger, GradientType) {
    ///从上到下
    GradientTypeTopToBottom = 0,
    ///从左到右
    GradientTypeLeftToRight = 1,
    ///左上到右下
    GradientTypeUpleftToLowright = 2,
    ///右上到左下
    GradientTypeUprightToLowleft = 3,
};

/// 设置图片的渐变色,用在Button上是设置成setBackgroundImage最好，否则会挡住汉字(颜色->图片)
/// @param colors 渐变颜色数组
/// @param gradientType 渐变样式
/// @param imgSize 图片大小
+ (UIImage *)gradientColorImageFromColors:(NSArray*)colors gradientType:(GradientType)gradientType imgSize:(CGSize)imgSize;


/**
 根据颜色和坐标生成一张图片
 
 @param color 颜色
 @param size 尺寸
 @return 颜色图片
 */
+(UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

@end

NS_ASSUME_NONNULL_END
