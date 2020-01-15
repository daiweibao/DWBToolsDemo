//
//  UIColor+DWBHelp.h
//  DWBToolsDemo
//
//  Created by 戴维保 on 2018/9/6.
//  Copyright © 2018年 潮汐科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (DWBHelp)
/**
 *  带#号的十六进制颜色转换
 *
 *  @param color 带#号的颜色字符串
 *
 *  @return 颜色
 */
+ (UIColor *) colorWithHexString: (NSString *)color;


/**
 带#号的十六进制颜色转换,可以设置透明度，必须带#号
 
 @param color 带#号的颜色字符串
 @param alpha 透明度
 @return 结果
 */
+ (UIColor *) colorWithHexString: (NSString *)color AndAlpha:(CGFloat)alpha;

@end
