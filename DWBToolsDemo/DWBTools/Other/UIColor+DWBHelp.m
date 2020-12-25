//
//  UIColor+DWBHelp.m
//  DWBToolsDemo
//
//  Created by chaoxi on 2018/9/6.
//  Copyright © 2018年 chaoxi科技有限公司. All rights reserved.
//

#import "UIColor+DWBHelp.h"

@implementation UIColor (DWBHelp)
#pragma mark - 颜色转换 IOS中十六进制的颜色转换为UIColor
/**
 *  带#号的十六进制颜色转换
 *
 *  @param color 带#号的颜色字符串
 *
 *  @return 颜色
 */
+ (UIColor *) colorWithHexString: (NSString *)color{
    
    return [UIColor colorWithHexString:color AndAlpha:1.0f];
    
}

#pragma mark - 颜色转换 IOS中十六进制的颜色转换为UIColor
/**
 带#号的十六进制颜色转换,可以设置透明度，必须带#号
 
 @param color 带#号的颜色字符串
 @param alpha 透明度
 @return 结果
 */
+ (UIColor *) colorWithHexString: (NSString *)color AndAlpha:(CGFloat)alpha
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    if (@available(iOS 10.0, *)) {
//        之前我们都是用RGB来设置颜色，反正用起来也不是特别多样化，这次新增的方法应该就是一个弥补吧。所以在iOS 10 苹果官方建议我们使用sRGB，因为它性能更好，色彩更丰富。
        return [UIColor colorWithDisplayP3Red:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:alpha];
        
    }else{
        
        return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:alpha];
        
    }
}


@end
