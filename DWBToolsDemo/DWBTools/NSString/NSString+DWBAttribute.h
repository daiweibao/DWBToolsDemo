//
//  NSString+DWBAttribute.h
//  DWBToolsDemo
//
//  Created by 戴维保 on 2018/9/19.
//  Copyright © 2018年 潮汐科技有限公司. All rights reserved.
//
//富文本帮助类
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (DWBAttribute)

#pragma mark =======AttributedString属性字符串，中间几个字颜色大小变化，还能设置行间距，下划线 S========

/**
 【1】同一属性字符串，可以设置1段变色，另外2段不变色【默认无行间距，无下划线】
 
 @param changeColor 改变的颜色
 @param changeFout 改变的字号
 @param string1 第1段字符串--默认
 @param changeString2 第2段字符串--变色
 @param string3 第3段字符串--默认
 @return NSMutableAttributedString属性字符串
 */
+(NSMutableAttributedString*)getLabelAttributedStrChange_One_WithChangeColor:(UIColor*_Nullable)changeColor AndChangeFont:(UIFont*_Nullable)changeFout AndString1:(NSString*_Nullable)string1 AndChangeString2:(NSString*_Nullable)changeString2 AndGetstring3:(NSString*_Nullable)string3;

/**
 【2】同一属性字符串，可以设置1段变色，另外2段不变色【可选择设置行间距，下划线】
 
 @param changeColor 改变的颜色
 @param changeFout 改变的字号
 @param string1 第1段字符串--默认
 @param changeString2 第2段字符串--变色
 @param string3 第3段字符串--默认
 @param isSetupSpacing 是否设置行间距，默认6
 @param iShowBottonLine 是否设置下划线
 @return NSMutableAttributedString属性字符串
 */
+(NSMutableAttributedString*)getLabelAttributedStrChange_One_WithChangeColor:(UIColor*_Nullable)changeColor AndChangeFont:(UIFont*_Nullable)changeFout AndString1:(NSString*_Nullable)string1 AndChangeString2:(NSString*_Nullable)changeString2 AndGetstring3:(NSString*_Nullable)string3 AndISetupSpacing:(BOOL )isSetupSpacing AndIShowBottonLine:(BOOL )iShowBottonLine;

/**
 【3】同一属性字符串，可以设置1段变色，另外2段不变色【默认无行间距，无下划线】
 
 @param changeColor1 第1段变色的颜色
 @param changeFout1 第1段变色的字号
 @param changeColor2 第2段变色的颜色
 @param changeFout2 第2段变色的字号
 @param string1 字符串第1段--默认
 @param changeString2 字符串第2段--变色
 @param string3 字符串第3段--默认
 @param changeString4 字符串第4段--变色
 @param string5 字符串第5段--默认
 @return NSMutableAttributedString属性字符串
 */
+(NSMutableAttributedString*)getLabelAttributedStrChange_Two_WithChangeColor1:(UIColor*_Nullable)changeColor1 AndChangeFont1:(UIFont*_Nullable)changeFout1 AndChangeColor2:(UIColor*_Nullable)changeColor2 AndChangeFont2:(UIFont*_Nullable)changeFout2 AndString1:(NSString*_Nullable)string1 AndChangeString2:(NSString*_Nullable)changeString2 AndGetstring3:(NSString*_Nullable)string3 AndChangeString4:(NSString*_Nullable)changeString4 AndGetstring5:(NSString*_Nullable)string5;

/**
 【4】同一属性字符串，可以设置两段变色，另外三段不变色【公共基类】
 
 @param changeColor1 第1段变色的颜色
 @param changeFout1 第1段变色的字号
 @param changeColor2 第2段变色的颜色
 @param changeFout2 第2段变色的字号
 @param string1 字符串第1段--默认
 @param changeString2 字符串第2段--变色
 @param string3 字符串第3段--默认
 @param changeString4 字符串第4段--变色
 @param string5 字符串第5段--默认
 @param isSetupSpacing 是否设置行间距，默认6
 @param iShowBottonLine 是否设置下划线
 @return NSMutableAttributedString属性字符串
 */
+(NSMutableAttributedString*)getLabelAttributedStrChange_Two_WithChangeColor1:(UIColor*_Nullable)changeColor1 AndChangeFont1:(UIFont*_Nullable)changeFout1 AndChangeColor2:(UIColor*_Nullable)changeColor2 AndChangeFont2:(UIFont*_Nullable)changeFout2 AndString1:(NSString*_Nullable)string1 AndChangeString2:(NSString*_Nullable)changeString2 AndGetstring3:(NSString*_Nullable)string3 AndChangeString4:(NSString*_Nullable)changeString4 AndGetstring5:(NSString*_Nullable)string5 AndISetupSpacing:(BOOL )isSetupSpacing AndIShowBottonLine:(BOOL )iShowBottonLine;




/**
 【使用优先级2】同一属性字符串,可以设置每一段的属性，属性和字符串(注意字符串不能为空，否则添加到数组时就会崩溃)，放在数组里传入【无行间距跟下划线】
 
 @param arrayAll 包含属性跟字符的数组
 @return NSMutableAttributedString 属性字符串
 */
+(NSMutableAttributedString*)getLabelAttributedStringWithALLArray:(NSArray <NSArray *>*)arrayAll;

/**
 【使用优先级2】同一属性字符串,可以设置每一段的属性，属性和字符串(注意字符串不能为空)，放在数组里传入【可设置行间距】
 
 @param arrayAll 包含属性跟字符的数组
 @param lineSpacing 行间距，-1代表不设置，一般设置也就设置为6
 @return NSMutableAttributedString 属性字符串
 */
+(NSMutableAttributedString*)getLabelAttributedStringWithALLArray:(NSArray <NSArray *>*)arrayAll AndLineSpacing:(CGFloat )lineSpacing;


/**
 【使用优先级2】同一属性字符串,可以设置每一段的属性，属性和字符串(注意字符串不能为空，否则添加到数组时就会崩溃)，放在数组里传入【基类】
 
 @param arrayAll 包含属性跟字符的数组
 @param lineSpacing 行间距，-1代表不设置，一般设置也就设置为6
 @param iShowBottonLine 是否展示变色部分的下划线
 @return NSMutableAttributedString 属性字符串
 */
+(NSMutableAttributedString*)getLabelAttributedStringWithALLArray:(NSArray <NSArray *>*)arrayAll AndLineSpacing:(CGFloat )lineSpacing AndIShowBottonLine:(BOOL )iShowBottonLine;


#pragma mark =======AttributedString属性字符串，中间几个字颜色大小变化，还能设置行间距，下划线 E========

/**
 设置Label的行间距+默认6
 
 @param string 内容
 @param lineSpacing 行间距
 @return 富文本
 */
+(NSMutableAttributedString*)getLabelLineSpace:(NSString*)string LineSpacing:(CGFloat )lineSpacing;


/**
 富文本：图片+文字混排

 @param imageName 本地图片名字
 @param string1 第一段文字
 @param string2 第二段文字
 @param imageBounds 图片bounds
 @return 富文本
 */
+(NSMutableAttributedString *)getLabelTextAndImageWithImageName:(NSString *)imageName andString1:(NSString*)string1 andString2:(NSString*)string2 AndBounds:(CGRect )imageBounds;

/**
 加载带标签的富文本HTML
 
 @param htmlString 带标签的富文本
 @param normal_ColorHex 默认背景色
 @return 结果
 */
+(NSAttributedString *)getLabelAttributedHTMLlString:(NSString *)htmlString AndNormal_ColorHex:(NSString *)normal_ColorHex;

/**
 字符串中指定字符变色【位置未知】，传入变色的字符数组【无行间距】
 
 @param text 完整字符串
 @param arrayChange 需要变色的字符数组
 @param changeFout 变色部分字号
 @param changeColor 变色部分颜色
 @return 返回属性字符串
 */
+(NSMutableAttributedString*)getLabelChangColoerArrayWithText:(NSString *)text AndChangeArray:(NSArray *)arrayChange andChangeFont:(UIFont*)changeFout AndChangeColor:(UIColor*)changeColor;

/**
 字符串中指定字符变色【位置未知】，传入变色的字符数组【有行间距】
 
 @param text 完整字符串
 @param arrayChange 需要变色的字符数组
 @param changeFout 变色部分字号
 @param changeColor 变色部分颜色
 @param lineSpacing 行间距，传入-1代表无行间距
 @return 返回属性字符串
 */
+(NSMutableAttributedString*)getLabelChangColoerArrayWithText:(NSString *)text AndChangeArray:(NSArray *)arrayChange andChangeFont:(UIFont*)changeFout AndChangeColor:(UIColor*)changeColor AndLineSpacing:(CGFloat )lineSpacing;

@end

NS_ASSUME_NONNULL_END
