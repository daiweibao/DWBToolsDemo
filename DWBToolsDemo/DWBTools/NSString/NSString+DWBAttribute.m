//
//  NSString+DWBAttribute.m
//  DWBToolsDemo
//
//  Created by chaoxi on 2018/9/19.
//  Copyright © 2018年 chaoxi科技有限公司. All rights reserved.
//

#import "NSString+DWBAttribute.h"

@implementation NSString (DWBAttribute)

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
+(NSMutableAttributedString*)getLabelAttributedStrChange_One_WithChangeColor:(UIColor*_Nullable)changeColor AndChangeFont:(UIFont*_Nullable)changeFout AndString1:(NSString*_Nullable)string1 AndChangeString2:(NSString*_Nullable)changeString2 AndGetstring3:(NSString*_Nullable)string3{
    
    return [NSString getLabelAttributedStrChange_One_WithChangeColor:changeColor AndChangeFont:changeFout AndString1:string1 AndChangeString2:changeString2 AndGetstring3:string3 AndISetupSpacing:NO AndIShowBottonLine:NO];
}

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
+(NSMutableAttributedString*)getLabelAttributedStrChange_One_WithChangeColor:(UIColor*_Nullable)changeColor AndChangeFont:(UIFont*_Nullable)changeFout AndString1:(NSString*_Nullable)string1 AndChangeString2:(NSString*_Nullable)changeString2 AndGetstring3:(NSString*_Nullable)string3 AndISetupSpacing:(BOOL )isSetupSpacing AndIShowBottonLine:(BOOL )iShowBottonLine{
    //调用公共类
    return [NSString getLabelAttributedStrChange_Two_WithChangeColor1:changeColor AndChangeFont1:changeFout AndChangeColor2:nil AndChangeFont2:nil AndString1:string1 AndChangeString2:changeString2 AndGetstring3:string3 AndChangeString4:nil AndGetstring5:nil AndISetupSpacing:isSetupSpacing AndIShowBottonLine:iShowBottonLine];
}


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
+(NSMutableAttributedString*)getLabelAttributedStrChange_Two_WithChangeColor1:(UIColor*_Nullable)changeColor1 AndChangeFont1:(UIFont*_Nullable)changeFout1 AndChangeColor2:(UIColor*_Nullable)changeColor2 AndChangeFont2:(UIFont*_Nullable)changeFout2 AndString1:(NSString*_Nullable)string1 AndChangeString2:(NSString*_Nullable)changeString2 AndGetstring3:(NSString*_Nullable)string3 AndChangeString4:(NSString*_Nullable)changeString4 AndGetstring5:(NSString*_Nullable)string5{
    //调用公共类
    return [NSString getLabelAttributedStrChange_Two_WithChangeColor1:changeColor1 AndChangeFont1:changeFout1 AndChangeColor2:changeColor2 AndChangeFont2:changeFout2 AndString1:string1 AndChangeString2:changeString2 AndGetstring3:string3 AndChangeString4:changeString4 AndGetstring5:string5 AndISetupSpacing:NO AndIShowBottonLine:NO];
}


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
+(NSMutableAttributedString*)getLabelAttributedStrChange_Two_WithChangeColor1:(UIColor*_Nullable)changeColor1 AndChangeFont1:(UIFont*_Nullable)changeFout1 AndChangeColor2:(UIColor*_Nullable)changeColor2 AndChangeFont2:(UIFont*_Nullable)changeFout2 AndString1:(NSString*_Nullable)string1 AndChangeString2:(NSString*_Nullable)changeString2 AndGetstring3:(NSString*_Nullable)string3 AndChangeString4:(NSString*_Nullable)changeString4 AndGetstring5:(NSString*_Nullable)string5 AndISetupSpacing:(BOOL )isSetupSpacing AndIShowBottonLine:(BOOL )iShowBottonLine{
    
    //此方法，放在所有属性设置完成后再调用设置，否则无效
    //判空
    if ([NSString isNULL:string1]==YES) {
        string1 = @"";
    }
    if ([NSString isNULL:changeString2]==YES) {
        changeString2 = @"";
    }
    if ([NSString isNULL:string3]==YES) {
        string3 = @"";
    }
    if ([NSString isNULL:changeString4]==YES) {
        changeString4 = @"";
    }
    if ([NSString isNULL:string5]==YES) {
        string5 = @"";
    }
    if (changeColor1==nil) {
        changeColor1 = [UIColor blackColor];
    }
    if (changeFout1==nil) {
        changeFout1 = [UIFont systemFontOfSize:14];
    }
    if (changeColor2==nil) {
        changeColor2 = [UIColor blackColor];
    }
    if (changeFout2==nil) {
        changeFout2 = [UIFont systemFontOfSize:14];
    }
    
    NSString *inteStr = [NSString stringWithFormat:@"%@%@%@%@%@",string1,changeString2,string3,changeString4,string5];
    NSMutableAttributedString *inteMutStr = [[NSMutableAttributedString alloc] initWithString:inteStr];
    
    //判断是否有行间距
    if (isSetupSpacing == YES) {
        // 行间距
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
        [paragraphStyle setLineSpacing:6];
        [inteMutStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0,inteStr.length)];
    }
    
    //设置第1段要改变颜色的字符属性
    NSRange orangeRangeChange1 = NSMakeRange(string1.length, changeString2.length);
    //设置第1段字体颜色
    [inteMutStr addAttributes:@{NSFontAttributeName:changeFout1,NSForegroundColorAttributeName:changeColor1} range:orangeRangeChange1];
    
    //设置第2段要改变颜色的字符属性
    NSString * strChange2Sta = [NSString stringWithFormat:@"%@%@%@",string1,changeString2,string3];
    NSRange orangeRangeChange2 = NSMakeRange(strChange2Sta.length, changeString4.length);
    //设置第2段字体颜色
    [inteMutStr addAttributes:@{NSFontAttributeName:changeFout2,NSForegroundColorAttributeName:changeColor2} range:orangeRangeChange2];
    
    
    
    //判断是否展示下划线
    if (iShowBottonLine == YES) {
        //下划线1类型
        [inteMutStr addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:orangeRangeChange1];
        //下划线2颜色
        [inteMutStr addAttribute:NSUnderlineColorAttributeName value:changeColor1 range:orangeRangeChange1];
        
        
        //下划线2类型
        [inteMutStr addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:orangeRangeChange2];
        //下划线2颜色
        [inteMutStr addAttribute:NSUnderlineColorAttributeName value:changeColor2 range:orangeRangeChange2];
    }
    
    return inteMutStr;
}





/**
 【使用优先级2】同一属性字符串,可以设置每一段的属性，属性和字符串(注意字符串不能为空)，放在数组里传入【无行间距跟下划线】

 @param arrayAll 包含属性跟字符的数组
 @return NSMutableAttributedString 属性字符串
 */
+(NSMutableAttributedString*)getLabelAttributedStringWithALLArray:(NSArray <NSArray *>*)arrayAll{
    //调用基类
    return [NSString getLabelAttributedStringWithALLArray:arrayAll AndLineSpacing:-1 AndIShowBottonLine:NO];
}


/**
 【使用优先级2】同一属性字符串,可以设置每一段的属性，属性和字符串(注意字符串不能为空)，放在数组里传入【可设置行间距】
 
 @param arrayAll 包含属性跟字符的数组
 @param lineSpacing 行间距，-1代表不设置，一般设置也就设置为6
 @return NSMutableAttributedString 属性字符串
 */
+(NSMutableAttributedString*)getLabelAttributedStringWithALLArray:(NSArray <NSArray *>*)arrayAll AndLineSpacing:(CGFloat )lineSpacing{
    //调用基类
    return [NSString getLabelAttributedStringWithALLArray:arrayAll AndLineSpacing:lineSpacing AndIShowBottonLine:NO];
}


/**
 【使用优先级2】同一属性字符串,可以设置每一段的属性，属性和字符串(注意字符串不能为空)，放在数组里传入【基类】
 
 @param arrayAll 包含属性跟字符的数组
 @param lineSpacing 行间距，-1代表不设置，一般设置也就设置为6
 @param iShowBottonLine 是否展示变色部分的下划线
 @return NSMutableAttributedString 属性字符串
 */
+(NSMutableAttributedString*)getLabelAttributedStringWithALLArray:(NSArray <NSArray *>*)arrayAll AndLineSpacing:(CGFloat )lineSpacing AndIShowBottonLine:(BOOL )iShowBottonLine{
    //注意：此方法，放在label所有属性设置完成后再调用设置，否则无效
    //用法案例：
  /*
    NSString * string1 = @"雪儿";
    NSString * string2 = nil;
    NSString * string3 = @"爱恨的chaoxi";
    NSString * string4 = @"说到：";
    NSString * string5 = @"你在干么呢?";
    //必须判空
    if (string2==nil) {
        string2 = @"";
    }
    
    NSArray * array1 = @[string1,[UIColor redColor],[UIFont systemFontOfSize:12]];
    NSArray * array2 = @[string2,[UIFont boldSystemFontOfSize:20]];
    NSArray * array3 = @[string3];
    NSArray * array4 = @[string4,[UIFont systemFontOfSize:12]];
    NSArray * array5 = @[string5,[UIColor blueColor],[UIFont systemFontOfSize:19]];
    
    NSArray * arrayEnd = @[array1,array2,array3,array4,array5];
    label.attributedText = [NSString getLabelAttributedStringWithALLArray:arrayEnd AndLineSpacing:6 AndIShowBottonLine:YES];
    */
     //优先使用方法：getLabelAttributedStrChange_One_WithChangeColor
    
    //创建一个富文本对象
    NSMutableAttributedString *inteMutStr = [[NSMutableAttributedString alloc] init];
    for (int i =0; i < arrayAll.count; i++) {
        NSArray * getArrayOne = arrayAll[i];
        //(1)取出属性
        //（1）取出字符串
        NSString * string = @"";//默认字符串为空
        UIColor * color = nil;//默认不设置颜色
        UIFont * fount = nil;//默认不设置字号
        for (int j = 0; j < getArrayOne.count; j++) {
            if ([getArrayOne[j] isKindOfClass:[NSString class]]) {
                string = [NSString stringWithFormat:@"%@",getArrayOne[j]];//内容
            }else if ([getArrayOne[j] isKindOfClass:[UIColor class]]){
                color = getArrayOne[j];//颜色
            }else if ([getArrayOne[j] isKindOfClass:[UIFont class]]){
                fount = getArrayOne[j];//字号
            }
        }
        //（2）获取当前这一段字符串所在位置
        NSRange orangeRange = NSMakeRange(inteMutStr.string.length, string.length);
        //属性字符串对象
        NSAttributedString * attStr = [[NSAttributedString alloc]initWithString:string];
        [inteMutStr appendAttributedString:attStr];//属性字符串追加
        
        //（3）设置要变色的字符属性---必须判空，默认颜色在外面设置
        if (color != nil) {
            [inteMutStr addAttributes:@{NSForegroundColorAttributeName:color} range:orangeRange];
            //为这一段变色字符串设置下划线
            if (iShowBottonLine==YES) {
                //设置下划线--类型
                [inteMutStr addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:orangeRange];
                //设置下划线--颜色
                [inteMutStr addAttribute:NSUnderlineColorAttributeName value:color range:orangeRange];
            }
        }
        if (fount != nil) {
            [inteMutStr addAttributes:@{NSFontAttributeName:fount} range:orangeRange];
        }
        
    }
    
    //行间距
    if (lineSpacing <= 0) {
        //不设置行间距
    }else{
        //设置行间距--一般默认为6
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
        [paragraphStyle setLineSpacing:lineSpacing];
        [inteMutStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0,inteMutStr.string.length)];
    }
    
    
    
    return inteMutStr;
}


#pragma mark =======AttributedString属性字符串，中间几个字颜色大小变化，还能设置行间距，下划线 E========



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

#pragma mark =======传值要变色的字符数组，返回属性字符串 S=========

/**
 字符串中指定字符变色【位置未知】，传入变色的字符数组【无行间距】
 
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
 字符串中指定字符变色【位置未知】，传入变色的字符数组【有行间距】
 
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




/**
 字符首行缩进，传入内容+ 首行缩进的距离

 @param text 内容
 @param windth 首行缩进距离
 @return 属性字符串
 */
+(NSAttributedString *)getLabelAttributedStringWithText:(NSString *)text AndWindth:(CGFloat )windth{
    //设置首行缩进距离
    NSMutableParagraphStyle *paraStyle01 = [[NSMutableParagraphStyle alloc] init];
    paraStyle01.alignment = NSTextAlignmentLeft;  //对齐
    paraStyle01.headIndent = 0.0f;//行首缩进
    CGFloat emptylen = windth;
    paraStyle01.firstLineHeadIndent = emptylen;//首行缩进距离
    //    paraStyle01.tailIndent = 0.0f;//行尾缩进
    //    paraStyle01.lineSpacing = 2.0f;//行间距
    NSAttributedString *attrText = [[NSAttributedString alloc] initWithString:text attributes:@{NSParagraphStyleAttributeName:paraStyle01}];
    return attrText;
}


@end
