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

#pragma mark ====(4）加载富文本=========

/**
 加载带标签的富文本HTML
 
 @param htmlString 带标签的富文本
 @param normal_ColorHex 默认背景色
 @return 结果
 */
+(NSAttributedString *)getLabelAttributedHTMLlString:(NSString *)htmlString AndNormal_ColorHex:(NSString *)normal_ColorHex{
    
    //设置默认背景色
    //        NSString * stringHtml = [NSString stringWithFormat:@"<font color='#ffffff'>%@</font>",self.model.shareExplain[k]];
    //设置默认背景色
    NSString * StrHtml = [NSString stringWithFormat:@"<font color='%@'>%@</font>",normal_ColorHex,htmlString];
    
    //     NSHTMLTextDocumentType设置为HTML类型（必须）
    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[StrHtml dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
    return attrStr;
}


/**
 同一字符串，指定部分文字颜色大小变化f【HTML】--【暂时不用，珍藏起来，用这个方法：getLabelChangColoerWithText】
 
 @param text 完整字符串
 @param arrayChange 变色的字符数组
 @param normal_ColerHex 默认颜色：Hex值
 @param normal_FontSize 默认字号
 @param normal_isBold 默认字是否加粗
 @param change_ColerHex 改变的字符颜色
 @param change_FontSize 改变的字符字号
 @param change_isBold 改变的字符是否加粗
 @return 返回属性字符串：NSAttributedString
 */
+(NSAttributedString *)getLabelAttributedStringHTMLChangeWithText:(NSString *)text AndChangeTextArr:(NSArray *)arrayChange AndNormalText_ColeerHex:(NSString *)normal_ColerHex AndNormalText_FontSize:(CGFloat )normal_FontSize AndNormalText_isBold:(BOOL )normal_isBold AndChangeText_ColeerHex:(NSString *)change_ColerHex AndChangeText_FontSize:(CGFloat )change_FontSize AndChangeText_isBold:(BOOL )change_isBold{
    
    
    //（0）数组去重（NSSet去重后顺序会被打乱，不过在这里无所谓）,否则暗号会显示出来【重要】
    NSSet *set = [NSSet setWithArray:arrayChange.copy];
    arrayChange = [set allObjects];
    
    //(1)【这一步处理非常重要，加入暗号：daiweibao】给需要改变的字符串加上特殊标识，防止替换的时候把颜色里的字符串替换了
    NSString * tageStr = @"$-dai-%@-weibao-$";//特殊标识，里面包含%@字符串占位符
    NSString * markStrALL = text.copy;
    for (int i = 0; i < arrayChange.count; i++) {
        NSString * markStr = [NSString stringWithFormat:tageStr,arrayChange[i]];
        markStrALL = [markStrALL stringByReplacingOccurrencesOfString:arrayChange[i] withString:markStr];
    }
    
    
    
    //HTML设置文字部分变色加粗等等
    //span标签，不会自动换行，style样式
    //设置字号：font-size:20px ，设置颜色：color:#eb4c97 设置加粗：font-weight:bold  设置不加粗：font-weight:normal
    //案列：@"<p style='font-size:20px; color:#eb4c97;font-weight:bold'>大家好，我是默认汉子<span style='font-size:40px; color:#999999'>第三段</span> <span style='font-size:20px; color:#F00'>第二段</span> <span style='font-size:20px; color:#313131;font-weight:normal'>第三段</span> 默认文字后部分</p>"
    
    //    NSString * stringHtml = @"<p style='font-size:20px; color:#eb4c97;font-weight:bold'>大家好，我是默认汉子<span style='font-size:40px; color:#999999'>第三段</span> <span style='font-size:20px; color:#F00'>第二段</span> <span style='font-size:20px; color:#313131;font-weight:normal'>第三段</span> 默认文字后部分</p>";
    
    
    
    //(2.1)转化成H5 <span> 标签嵌套 <span>标签,不能用p标签，不然尾部会多出空白
    NSString * markHTMLStrALL = markStrALL.copy;
    for (int j = 0; j < arrayChange.count; j++) {
        NSString * redText = [NSString stringWithFormat:tageStr,arrayChange[j]];
        if ([markStrALL containsString:redText]) {
            NSString * change_boldOrNormal = change_isBold==YES? @"bold":@"normal";//判断加粗
            NSString * redTextHtml = [NSString stringWithFormat:@"<span style='font-size:%fpx;color:%@;font-weight:%@'>%@</span>",change_FontSize,change_ColerHex,change_boldOrNormal,arrayChange[j]];
            //替换
            markHTMLStrALL = [markHTMLStrALL stringByReplacingOccurrencesOfString:redText withString:redTextHtml];
        }
    }
    
    //(2.2)设置默认属性
    NSString * normal_boldOrNormal = normal_isBold==YES? @"bold":@"normal";//判断加粗
    NSString * stringHtml = [NSString stringWithFormat:@"<span style='font-size:%fpx; color:%@;font-weight:%@'>%@</span>",normal_FontSize,normal_ColerHex,normal_boldOrNormal,markHTMLStrALL];
    
    //NSHTMLTextDocumentType设置为HTML类型（必须）
    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[stringHtml dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
    return attrStr;
}




#pragma mark =======传值要变色的字符数组，返回属性字符串 S=========

/**
 字符串中指定字符变色，传入变色的字符数组【无行间距】
 
 @param text 完整字符串
 @param arrayChange 需要变色的字符数组
 @param changeFout 变色部分字号
 @param changeColor 变色部分颜色
 @return 返回属性字符串
 */
+(NSMutableAttributedString*)getLabelChangColoerArrayWithText:(NSString *)text AndChangeArray:(NSArray *)arrayChange andChangeFont:(UIFont*)changeFout AndChangeColor:(UIColor*)changeColor{
    
    //调用公共方法
   return [NSString getLabelChangColoerArrayWithText:text AndChangeArray:arrayChange andChangeFont:changeFout AndChangeColor:changeColor AndLineSpacing:-1];
}


/**
 字符串中指定字符变色，传入变色的字符数组【有行间距】
 
 @param text 完整字符串
 @param arrayChange 需要变色的字符数组
 @param changeFout 变色部分字号
 @param changeColor 变色部分颜色
 @param lineSpacing 行间距，传入-1代表无行间距
 @return 返回属性字符串
 */
+(NSMutableAttributedString*)getLabelChangColoerArrayWithText:(NSString *)text AndChangeArray:(NSArray *)arrayChange andChangeFont:(UIFont*)changeFout AndChangeColor:(UIColor*)changeColor AndLineSpacing:(CGFloat )lineSpacing{
    //默认部分颜色等属性，必须在调用此方法前面设置。
    if ([NSString isNULL:text]==YES) {
        text = @"";//判空
    }
    //创建富文本对象
    NSMutableAttributedString *inteMutStr = [[NSMutableAttributedString alloc] initWithString:text];
    //遍历找出需要改变颜色的位置
    for (int i = 0; i < arrayChange.count; i++) {
        NSString * strChange = arrayChange[i];
        NSArray * arrayIndex = [NSString getRangeStr:text findText:strChange];//获取Range所在位置
        for (int j = 0; j < arrayIndex.count; j++) {
            //要变色的字符位置
            NSRange orangeRange = NSMakeRange([arrayIndex[j] integerValue], strChange.length);
            //设置要变色的字符属性
            [inteMutStr addAttributes:@{NSFontAttributeName:changeFout,NSForegroundColorAttributeName:changeColor} range:orangeRange];
        }
    }
    
    //行间距
    if (lineSpacing <= 0) {
        //不设置行间距
    }else{
        //设置行间距
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
        [paragraphStyle setLineSpacing:lineSpacing];
        [inteMutStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0,text.length)];
    }
    
    return inteMutStr;
}



#pragma mark - 获取字符串中多个相同字符的位置index（如：所有xxx在该字符串中的所在的index）
+ (NSMutableArray *)getRangeStr:(NSString *)text findText:(NSString *)findText
{
    
    NSMutableArray *arrayRanges = [NSMutableArray arrayWithCapacity:3];
    
    if (findText == nil && [findText isEqualToString:@""])
    {
        
        return nil;
        
    }
    
    NSRange rang = [text rangeOfString:findText]; //获取第一次出现的range
    
    if (rang.location != NSNotFound && rang.length != 0)
    {
        
        [arrayRanges addObject:[NSNumber numberWithInteger:rang.location]];//将第一次的加入到数组中
        
        NSRange rang1 = {0,0};
        
        NSInteger location = 0;
        
        NSInteger length = 0;
        
        for (int i = 0;; i++)
        {
            
            if (0 == i)
            {//去掉这个xxx
                
                location = rang.location + rang.length;
                
                length = text.length - rang.location - rang.length;
                
                rang1 = NSMakeRange(location, length);
                
            }
            else
            {
                
                location = rang1.location + rang1.length;
                
                length = text.length - rang1.location - rang1.length;
                
                rang1 = NSMakeRange(location, length);
                
            }
            
            //在一个range范围内查找另一个字符串的range
            
            rang1 = [text rangeOfString:findText options:NSCaseInsensitiveSearch range:rang1];
            
            if (rang1.location == NSNotFound && rang1.length == 0)
            {
                
                break;
                
            }
            else//添加符合条件的location进数组
                
                [arrayRanges addObject:[NSNumber numberWithInteger:rang1.location]];
            
        }
        
        return arrayRanges;
        
    }
    
    return nil;
}

#pragma mark =======传值要变色的字符数组，返回属性字符串 E=========

@end
