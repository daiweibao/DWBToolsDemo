//
//  UIImage+PlayGif.h
//  ZuiMeiXinNiang
//
//  Created by 戴维保 on 2017/3/17.
//  Copyright © 2017年 zmxn. All rights reserved.
//
// 播放本地gif图片（复制SDWebImage的方法，更新SDWebImage也不影响）
#import <UIKit/UIKit.h>
#import <ImageIO/ImageIO.h>
#import "FLAnimatedImage.h"//播放本地动画
@interface UIImage (PlayGif)

//+ (UIImage *)sd_animatedGIFNamed:(NSString *)name;
//
//+ (UIImage *)sd_animatedGIFWithData:(NSData *)data;
//
//- (UIImage *)sd_animatedImageByScalingAndCroppingToSize:(CGSize)size;



/**
 播放本地gif图片（复制SDWebImage的方法，更新SDWebImage也不影响）
 
 @param imageName gif图片名字
 @return 返回图片
 */
+(UIImage *)gifImagePlay:(NSString * )imageName;


/**
 FLAnimatedImageView控件播放本地动画，如果网络的只需确保使用FLAnimatedImageView而不是UIImageView就可以播放。
 
 @param gifName 图片名字，不能包含.gif
 @return FLAnimatedImage结果
 */
+(FLAnimatedImage *)playGifImageFLAnimated:(NSString *)gifName;



/**
 播放数组图片动画案例

 @param imageview 图片控件
 */
+(void)PlayAnimationImages:(UIImageView *)imageview;

@end
