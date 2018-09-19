//
//  NSString+DWBAttribute.m
//  DWBToolsDemo
//
//  Created by 戴维保 on 2018/9/19.
//  Copyright © 2018年 潮汐科技有限公司. All rights reserved.
//

#import "NSString+DWBAttribute.h"

@implementation NSString (DWBAttribute)

#pragma mark ====(1）同一个label中间几个字 变颜色、大小都能改变、可设置下划线、行间距=========

/**
 同一个label中间几个字 变颜色、大小都能改变。
 
 @param color 中间变化的文字--颜色
 @param fout 中间变化的文字--大小
 @param string1 第一段内容
 @param string2 第一段内容
 @param string3 第二段内容
 @return 结果
 */
+(NSMutableAttributedString*)getLabelChangeColor:(UIColor*)color andFont:(UIFont*)fout andString1:(NSString*)string1 andChangeString:(NSString*)string2 andGetstring3:(NSString*)string3{
    //调用公共类
   return [NSString getLabelChangeColor:color andFont:fout andString1:string1 andChangeString:string2 andGetstring3:string3 andISetupSpacing:NO andIShowBottonLine:NO];
}



/**
 同一个label中间几个字 变颜色、大小都能改变、还能添加下划线，整个label还能设置是否有行间距
 
 @param color 中间变化的文字--颜色
 @param fout 中间变化的文字--大小
 @param string1 第一段内容
 @param string2 第一段内容
 @param string3 第二段内容
 @param isSetupSpacing 是否设置行间距
 @param iShowBottonLine 中间变化的文字--是否设置下划线
 @return 结果
 */
+(NSMutableAttributedString*)getLabelChangeColor:(UIColor*)color andFont:(UIFont*)fout andString1:(NSString*)string1 andChangeString:(NSString*)string2 andGetstring3:(NSString*)string3 andISetupSpacing:(BOOL )isSetupSpacing andIShowBottonLine:(BOOL )iShowBottonLine{
    
    //     label.attributedText = [NSString getLabelChangeColor:[UIColor redColor] andFont:[UIFont systemFontOfSize:25] andString1:@"测试" andChangeString:@"中间变大" andGetstring3:@"最后一段" andISetupSpacing:NO andIShowBottonLine:NO];
    
    //    //点击指定汉子【dwb_addAttributeTapActionWithStrings】--配合这个类可以点击
    //    [label dwb_addAttributeTapActionWithStrings:@[string2] tapClicked:^(NSString *string, NSRange range, NSInteger index) {
    //
    //        NSLog(@"点击了变大的内容");
    //    }];
    
    //string2 是变色的部分 注意放在所有属性==>>最后面<<<===设置，否则无效
    //判空
    if ([NSString isNULL:string1]==YES) {
        string1 = @"";
    }
    if ([NSString isNULL:string2]==YES) {
        string2 = @"";
    }
    if ([NSString isNULL:string3]==YES) {
        string3 = @"";
    }
    if (color==nil) {
        color = [UIColor blackColor];
    }
    if (fout==nil) {
        fout = [UIFont systemFontOfSize:14];
    }
    
    NSString *inteStr = [NSString stringWithFormat:@"%@%@%@",string1,string2,string3];
    NSMutableAttributedString *inteMutStr = [[NSMutableAttributedString alloc] initWithString:inteStr];
    
    //判断是否有行间距
    if (isSetupSpacing == YES) {
        // 行间距
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
        [paragraphStyle setLineSpacing:6];
        [inteMutStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0,inteStr.length)];
    }
    
    
    //设置中间变红的字体大小颜色
    NSRange orangeRange = NSMakeRange([[inteMutStr string] rangeOfString:string2].location, [[inteMutStr string] rangeOfString:string2].length);
    
    //    NSRange orangeRange = NSMakeRange(string1.length, string2.length);
    
    //判断是否展示下划线
    if (iShowBottonLine == YES) {
        //下划线类型
        [inteMutStr addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:orangeRange];
        //下划线颜色
        [inteMutStr addAttribute:NSUnderlineColorAttributeName value:color range:orangeRange];
    }
    
    //设置字体颜色
    [inteMutStr addAttributes:@{NSFontAttributeName:fout,NSForegroundColorAttributeName:color} range:orangeRange];
    return inteMutStr;
    
}


#pragma mark ====(2）设置label行间距=========
/**
 设置Label的行间距+默认6
 
 @param string 字符串
 @return 属性字符串
 @LineSpacing 行间距
 */
+(NSMutableAttributedString*)getLabelLineSpace:(NSString*)string LineSpacing:(CGFloat )lineSpacing{
    // 注意放在所有属性最后面设置，否则无效
    //判空
    if ([NSString isNULL:string]==YES) {
        string = @"";
    }
    NSMutableAttributedString *inteMutStr = [[NSMutableAttributedString alloc] initWithString:string];
    // 行间距
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    if (lineSpacing <= 0) {
        [paragraphStyle setLineSpacing:6];
    }else{
        [paragraphStyle setLineSpacing:lineSpacing];
    }
    
    [inteMutStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0,string.length)];
    return inteMutStr;
}


#pragma mark ====(3）图片跟文字混排=========
+(NSMutableAttributedString *)getLabelTextAndImageWithImageName:(NSString *)imageName andString1:(NSString*)string1 andString2:(NSString*)string2 AndBounds:(CGRect )imageBounds{
    //判空
    if ([NSString isNULL:string1]==YES) {
        string1 = @"";
    }
    if ([NSString isNULL:string2]==YES) {
        string2 = @"";
    }
    //拼接字符串
    NSString *inteStr = [NSString stringWithFormat:@"%@%@",string1,string2];
    //富文本
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:inteStr];
    //图片
    NSTextAttachment *attch = [[NSTextAttachment alloc] init];
    //本地图片名字
    attch.image = [UIImage imageNamed:imageName];
    //设置图片大小
    attch.bounds = imageBounds;
    //创建带有图片的富文本
    NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
    //把图片插入到指定位置
    [attri insertAttributedString:string atIndex:string1.length];
    
    return attri;
}


@end
