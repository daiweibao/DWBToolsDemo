//
//  UIFont+FontNameSize.m
//  AiHenDeChaoXi
//
//  Created by 戴维保 on 2018/6/4.
//  Copyright © 2018年 潮汐科技有限公司. All rights reserved.
//

//利用runtime交换方法，全局修改系统字体或者三方字体
#import "UIFont+FontNameSize.h"

@implementation UIFont (FontNameSize)
//只执行一次的方法，在这个地方 替换方法
+(void)load{
    
    //保证线程安全
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        //拿到系统方法
        Method orignalMethod = class_getClassMethod(class, @selector(systemFontOfSize:));
        //拿到自己定义的方法
        Method myMethod = class_getClassMethod(class, @selector(test_systemFontOfSize:));
        //交换方法
        method_exchangeImplementations(orignalMethod, myMethod);
        
        //注意，只有调用了下面这个方法的控件才会执行字体修改，默认字号大小的控件不会修改。
        //[UIFont systemFontOfSize:12]
    });
}

//自己的方法
+ (UIFont *)test_systemFontOfSize:(CGFloat)fontSize{
    
// 苹果默认字体：SFUIText
//系统字体：GillSans-BoldItalic  AppleSDGothicNeo-Light  HiraMaruProN-W4  宋体：STSongti-SC-Bold
    
    //UI设计给的字体包，需要先导入字体包：simsun.ttf  宋体字体名字：MS-Song   迷你简小隶书名字：JXiaoLiSu(暂时不用)
    /*
    UIFont *font = [UIFont fontWithName:@"MS-Song" size:fontSize];
    if (!font){
        NSLog(@"字体不存在");
        //判空，如果字体不存在就返回系统默认字体，不然会崩溃
        return [self test_systemFontOfSize:fontSize];
    }
    return font;
     
     */
    
     return [self test_systemFontOfSize:fontSize];
    
}

@end
