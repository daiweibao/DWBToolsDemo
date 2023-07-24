//
//  UIFont+FontNameBoldSize.m
//  AiHenDeChaoXi
//
//  Created by 戴维保 on 2018/6/9.
//  Copyright © 2018年 北京嗅美科技有限公司. All rights reserved.
//
//利用runtime交换方法，全局修改系统字体或者三方字体
#import "UIFont+FontNameBoldSize.h"

@implementation UIFont (FontNameBoldSize)
//只执行一次的方法，在这个地方 替换方法
+(void)load{
    
    //保证线程安全
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        //拿到系统方法
        Method orignalMethod = class_getClassMethod(class, @selector(boldSystemFontOfSize:));
        //拿到自己定义的方法
        Method myMethod = class_getClassMethod(class, @selector(test_BoldsystemFontOfSize:));
        //交换方法
        method_exchangeImplementations(orignalMethod, myMethod);
        
        //注意，只有调用了下面这个方法的控件才会执行字体修改，默认字号大小的控件不会修改。
        //[UIFont systemFontOfSize:12]
    });
}

//自己的方法
+ (UIFont *)test_BoldsystemFontOfSize:(CGFloat)fontSize{
    /*
    //设置加粗字体，不能再后面直接加上-Bold，三方字体找不到 粗宋体:CloudSongXiaoGBK
    UIFont *font = [UIFont fontWithName:@"CloudSongXiaoGBK" size:fontSize];
    if (!font){
        NSLog(@"字体不存在");
        //判空，如果字体不存在就返回系统默认字体，不然会崩溃
        return [self test_BoldsystemFontOfSize:fontSize];
    }
    return font;
     */
    
     return [self test_BoldsystemFontOfSize:fontSize];
}
@end
