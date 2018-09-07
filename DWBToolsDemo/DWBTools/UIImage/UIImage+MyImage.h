//
//  UIImage+MyImage.h
//  ZuiMeiXinNiang
//
//  Created by 戴维保 on 16/8/15.
//  Copyright © 2016年 zmxn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (MyImage)
/** 设置圆形图片(放到分类中使用) */
- (UIImage *)cutCircleImage;
/**
 *  返回原型图片（根据名字）
 */
//+ (instancetype)cutCircleImage:(NSString *)image;
//用法
//[self.iconButton setImage:[image circleImage] forState:UIControlStateNormal];


/*
 用颜色创建一个虚线边框的图片
 
 @param size        需要虚线边框视图的大小
 @param color       边框颜色
 @param borderWidth 边框粗细
 
 @return 返回一张带边框的图片
 */
+ (UIImage *)imageWithSize:(CGSize)size borderColor:(UIColor *)color borderWidth:(CGFloat)borderWidth;

/**
 截屏并保存到本地相册
 
 @param orgView 截取指定view上的图片
 @return 图片
 */
+(UIImage *)captureImageFromViewLow:(UIView *)orgView;


/**
 截屏不保、存不提示
 
 @param orgView 截取指定view上的图片
 @return 图片
 */
+(UIImage *)captureImageFromViewLowNoSaveAndInfo:(UIView *)orgView;

/**
 截取滚动视图的长图片（如tableview等）
 
 @param scroller 滚动视图
 @return 截取的长图
 */
+ (UIImage *)captureImageLonge:(UIScrollView*)scroller;

/**
 ** lineView:       需要绘制成虚线的view
 ** lineLength:     虚线的宽度
 ** lineSpacing:    虚线的间距
 ** lineColor:      虚线的颜色
 **/
+ (void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor;



/** 根据颜色生成纯色图片 */
+ (UIImage *)imageWithColor:(UIColor *)color;
/**
 根据颜色和坐标生成一张图片
 
 @param color 颜色
 @param size 尺寸
 @return 颜色图片
 */
+(UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;


/** 取图片某一像素的颜色 */
- (UIColor *)colorAtPixel:(CGPoint)point;

/** 获得灰度图 */
- (UIImage *)convertToGrayImage;


/** 截取当前image对象rect区域内的图像 */
- (UIImage *)subImageWithRect:(CGRect)rect;

/** 压缩图片至指定尺寸 */
- (UIImage *)rescaleImageToSize:(CGSize)size;

/** 压缩图片至指定像素 */
- (UIImage *)rescaleImageToPX:(CGFloat )toPX;

/** 在指定的size里面生成一个平铺的图片 */
- (UIImage *)getTiledImageWithSize:(CGSize)size;

/** UIView转化为UIImage */
+ (UIImage *)imageFromView:(UIView *)view;

/** 将两个图片生成一张图片 */
+ (UIImage*)mergeImage:(UIImage*)firstImage withImage:(UIImage*)secondImage;

/**
 根据图片上的坐标截取图片上指定坐标的图片，如截取人脸之类的
 
 @param cutFrame 截取范围的坐标
 @param image 截取的图片
 */
+(UIImage*)cutImageSmallImageImage:(UIImage*)image Frame:(CGRect)cutFrame;
/**
 绘制椭圆图形
 
 @param srcImg 图片
 @return 返回椭圆
 */
+(UIImage*)drawTheEllipse:(UIImage*)srcImg;

#pragma marl ========= 按比例限制宽度不要超过最大宽度，同时高度按比例缩放（图片宽度填满） ===================

/**
 按比例限制图片宽度不要超过最大宽度，同时高度按比例缩放(图片宽度固定，高度动态缩放)
 
 @param myImageWidth 图片实际宽度
 @param myImageHeight 图片实际高度
 @param maxWidth 固定的宽度
 @return 计算好的高度
 */
+(CGFloat )getImageHeightWith:(NSString *)myImageWidth AndHeight:(NSString*)myImageHeight AndMaxWindth:(CGFloat)maxWidth;

/**
 tableviewCell上的封面图处理动态宽高，不会剪裁图片
 
 @param myImageWidth 图片原始宽度
 @param myImageHeight 图片原始高度
 @param maxWidth 图片限制的最大宽高（相等）
 @return 返回宽高
 */
+(NSArray* )getImageHeightMyCellWith:(NSString *)myImageWidth AndHeight:(NSString*)myImageHeight AndMaxWindth:(CGFloat)maxWidth;



/**
 图片保存到本地
 
 @param image 图谱按
 */
+(void)saveImageLocal:(UIImage*)image;



/**
  压缩图片方法(先压缩质量再压缩尺寸,压缩到指定尺寸以下单位如：1 * 1024 Kb)-最佳方法,只能用对象方法，否则无效.

 @param maxLength 压缩到指定质量以下，单位KB
 @return 压缩后的
 */
-(NSData *)compressWithLengthLimit:(NSUInteger)maxLength;

/**
 图片转成Base64字符串,并压缩到指定内存大小

 @param image 图片
 @param maxLength 压缩到指定大小，单位kb
 @return 字符串
 */
-(NSString *)imageToBase64Str:(UIImage *) image  MaxLength:(NSInteger)maxLength;

/**
 Base64字符串转图片

 @param encodedImageStr Base64字符串转
 @return 图片
 */
+(UIImage *)Base64StrToUIImage:(NSString *)encodedImageStr;

/**
 沙盒路径视频保存到相册,只能用对象方法，不能用类方法
 
 @param videoPath 视频的沙盒路径，注意路径不能含有中文
 */
-(void)saveVideoToPhone:(NSString *)videoPath;


/**
 必须处理照片方向(一般手机拍出来的照片方向反着的)

 @param image 拍摄的照片
 @return 返回处理好的照片
 */
+(UIImage *)normalizedImage:(UIImage *)image;

@end
