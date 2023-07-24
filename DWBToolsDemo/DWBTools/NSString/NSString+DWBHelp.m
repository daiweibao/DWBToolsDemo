//
//  NSString+DWBHelp.m
//  DWBToolsDemo
//
//  Created by 戴维保 on 2018/9/5.
//  Copyright © 2018年 北京嗅美科技有限公司. All rights reserved.
//

#import "NSString+DWBHelp.h"
//调用系统震动和声音
#import <AudioToolbox/AudioToolbox.h>

@implementation NSString (DWBHelp)

//密码验证（6-20位字母和数字组合） yes表示是格式正确的密码
+(BOOL)passWordText:(NSString*)string{
    
    // 判断长度大于6位后再接着判断是否同时包含数字和字符
    NSString * regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,20}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return  [pred evaluateWithObject:string];
    
}



//手机号码验证 yes表示是手机号码
+(BOOL)phoneText:(NSString*)string{
    //    /**
    //     * 移动号段正则表达式
    //     */
    //    NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
    //    /**
    //     * 联通号段正则表达式
    //     */
    //    NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
    //    /**
    //     * 电信号段正则表达式
    //     */
    //    NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
    //
    //    NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
    //    BOOL isMatch1 = [pred1 evaluateWithObject:string];
    //    NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
    //    BOOL isMatch2 = [pred2 evaluateWithObject:string];
    //    NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
    //    BOOL isMatch3 = [pred3 evaluateWithObject:string];
    //
    //    if (isMatch1 || isMatch2 || isMatch3) {
    //
    //        return YES;
    //    }else{
    //
    //        return NO;
    //    }
    
    //2018最全手机号正则
    //     NSString * CM_NUM_2018  = @"^(((13[0-9])|(14[579])|(15([0-3]|[5-9]))|(16[6])|(17[0135678])|(18[0,5-9])|(19[89]))\\d{8})$";
    //    NSPredicate *pred_2018 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM_2018];
    //    BOOL isMatch_2018 = [pred_2018 evaluateWithObject:string];
    
    
    
    //暂时不限制手机号了市场上手机号越来越多了，什么199，166开头的太多了
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    BOOL isPureInt = [scan scanInt:&val] && [scan isAtEnd];//是否整数
    if (string.length == 11 || string.length == 8) {
        
        if (isPureInt == YES) {
            return YES;
        }else{
            
            return NO;
        }
        
    }else{
        return NO;
    }
    
}




//标签限制+只能是汉字并且是1到10个字
- (BOOL) LabelonlyChinese{
    
    NSString * nicknameRegex =@"^[\u4e00-\u9fa5]{0,10}$";
    
    NSPredicate * passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
    
    return [passWordPredicate evaluateWithObject:self];
    
}



//汉字转拼音
+ (NSString *)transform:(NSString *)chinese
{
    NSMutableString *pinyin = [chinese mutableCopy];
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformStripCombiningMarks, NO);
    //去掉空格
    NSString * contentping = [[pinyin lowercaseString] stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    return contentping;
}


/**
 时间计算 刚刚－几分钟前－几小时前
 
 @param dateStr 日期的毫秒
 @return 返回结果
 */
+(NSString *)dateCompareCurrentNowTime:(NSString*)dateStr{
    
    //毫秒转日期
    NSString * str = [NSString dateChangeStr:dateStr andFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    if (ios8orLater) {
        
    }else{
        
        return @"版本过低";
    }
    //创建时间对象
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    //系统时间的字符串
    NSDate * dateXT  = [NSDate date];
    NSCalendar * calendarXT = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *compXT = [calendarXT components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond|NSCalendarUnitWeekOfMonth|NSCalendarUnitWeekday fromDate:dateXT];
    NSString * stringXT = [NSString stringWithFormat:@"%ld-%ld-%ld %ld:%ld:%ld",(long)compXT.year, (long)compXT.month, (long)compXT.day, (long)compXT.hour, (long)compXT.minute, (long)compXT.second];
    //系统时间
    NSDate *dateTimeXT = [formatter dateFromString:stringXT];
    //发帖日期
    NSDate *date0 = [formatter dateFromString:str];
    //初始化日历
    NSCalendar * calendar;
    if (ios8orLater) {
        calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    }else{
        
        calendar = [NSCalendar autoupdatingCurrentCalendar];
    }
    
    //拿到时间差（系统时间减去发帖时间）
    NSDateComponents *com = [calendar components:NSCalendarUnitDay |NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond  fromDate:date0 toDate:dateTimeXT options:0];
    //转化成秒
    NSTimeInterval timeInterval =(long)com.day *86400 + (long)com.hour *3600+(long)com.minute * 60+(long)com.second;
    
    
    
    long temp = 0;
    NSString *result;
    //小于60 秒显示刚刚
    if (timeInterval < 60) {
        
        result = [NSString stringWithFormat:@"刚刚"];
    }
    //小于60分钟直接显示几分钟前
    else if((temp = timeInterval/60) <60){
        
        result = [NSString stringWithFormat:@"%ld分钟前",temp];
    }
    //小于24小时直接显示几小时前
    else if((temp = timeInterval/(60*60)) <24){
        
        result = [NSString stringWithFormat:@"%ld小时前",temp];
    }
    //小于7天显示几天前
    else if((temp = timeInterval/(86400)) <7){
        
        result = [NSString stringWithFormat:@"%ld天前",temp];
    }
    //大于7天小于14天显示1周前
    else if((temp = timeInterval/(86400*7)) <2){
        
        result = [NSString stringWithFormat:@"%ld周前",temp];
    }
    else{
        //直接显示发帖日期
        NSArray * arrayNew = [str  componentsSeparatedByString:@"-"];
        //切日
        NSArray * arrayday = [[arrayNew lastObject]  componentsSeparatedByString:@" "];
        
        NSArray * arrayMM = [[arrayday lastObject] componentsSeparatedByString:@":"];
        
        result =[NSString stringWithFormat:@"%@-%@-%@ %@:%@",arrayNew[0],arrayNew[1],[arrayday firstObject],arrayMM[0],arrayMM[1]];
    }
    
    return result;
}

//根据日期判断星座
+(NSString *)getAstroWithMonth:(int)m day:(int)d{
    
    NSString *astroString = @"魔羯水瓶双鱼白羊金牛双子巨蟹狮子处女天秤天蝎射手魔羯";
    NSString *astroFormat = @"102123444543";
    NSString *result;
    
    if (m<1||m>12||d<1||d>31){
        return @"错误日期格式!";
    }
    
    if(m==2 && d>29)
    {
        return @"错误日期格式!!";
    }else if(m==4 || m==6 || m==9 || m==11) {
        
        if (d>30) {
            return @"错误日期格式!!!";
        }
    }
    
    result=[NSString stringWithFormat:@"%@",[astroString substringWithRange:NSMakeRange(m*2-(d < [[astroFormat substringWithRange:NSMakeRange((m-1), 1)] intValue] - (-19))*2,2)]];
    
    
    return result;
}


#pragma mark ============== 根据生日获取年龄 =====================
//根据生日获取年龄
-(NSString *)dateBirthday:(NSString *)birthday Formatter:(NSString*)formatter{
    //formatter为：@"yyyy-MM-dd"
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:formatter];
    NSDate *birthDay = [dateFormatter dateFromString:birthday];
    //获得当前系统时间
    NSDate *currentDate = [NSDate date];
    //获得当前系统时间与出生日期之间的时间间隔
    NSTimeInterval time = [currentDate timeIntervalSinceDate:birthDay];
    //时间间隔以秒作为单位,求年的话除以60*60*24*356
    int age = ((int)time)/(3600*24*365);
    return [NSString stringWithFormat:@"%d",age];
}




#pragma mark ============== 秒杀时间 =====================
+(NSString*)timeCha:(NSNumber*)start Endtime:(NSNumber*)endtime{
    NSString * string;
    
    //开始时间
    NSNumber * startDate  = start;
    double sta = [startDate doubleValue];
    
    //结束日期
    NSNumber * endDate  = endtime;
    double end = [endDate doubleValue];
    
    //系统时间的毫秒
    NSTimeInterval time=[[NSDate date] timeIntervalSince1970]*1000;
    double now = time;      //NSTimeInterval返回的是double类型
    
    //活动未开始
    if (now < sta) {
        
        //得到还有多久开始的时间差时间差(秒)
        int cha = (now - sta)/1000;
        string = [NSString stringWithFormat:@"%d",cha];
        
    }
    
    //活动进行中
    if (now > sta && now < end) {
        //得到时间差(秒)
        int cha = (end - now)/1000;
        string = [NSString stringWithFormat:@"%d",cha];
    }
    
    //活动已结束
    if (now > end) {
        
        string = @"已结束";
        
    }
    
    
    return string;
    
}


#pragma mark ============== 已知开始时间和结束时间的毫秒，计算开始、进行中、结束状态 =====================
+(NSString*)timeStateStart:(double)sta Endtime:(double)end{
    NSString * string;
    //系统时间的毫秒
    NSTimeInterval time=[[NSDate date] timeIntervalSince1970]*1000;
    double now = time;    //NSTimeInterval返回的是double类型
    //活动未开始
    if (now < sta) {
        
        string = @"未开始";
        
    }
    
    //活动进行中
    if (now > sta && now < end) {
        
        string = @"进行中";
    }
    
    //活动已结束
    if (now > end) {
        
        string = @"已结束";
        
    }
    
    return string;
    
}



//通用正则匹配，可以匹配任意东西，只需要传入正则表达式跟字符串即可
+ (NSString *)processWithString:(NSString *)string regularExpression:(NSString *)regularExpression {
    
    // 创建一个可变字符串,用来拼接符合条件的字符
    NSMutableString *mString = [[NSMutableString alloc] init];
    // 创建一个错误对象
    NSError *error;
    // 正则
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regularExpression options:0 error:&error];
    // 如果正则没有错误进行内部的代码
    if (!error) {
        // 将符合条件的字符位置记录到数组中
        NSArray *array = [regex matchesInString:string options:0 range:NSMakeRange(0, string.length)];
        // 利用数组中的位置将所有符合条件的字符拼接起来
        for (NSTextCheckingResult *result in array) {
            NSRange range = [result range];
            NSString *mStr = [string substringWithRange:range];
            [mString appendString:mStr];
        }
        return mString;
    } else {
        NSLog(@"error is %@", error);
    }
    return nil;
}


//传入文本内容、字体大小、控件宽度返回计算的文本占用位置的大小（含宽，高）
+(CGSize)sizeMyStrWith:(NSString*)text andMyFont:(UIFont *)myFont andMineWidth:(CGFloat)Width

{
    //ios7
    CGSize size = CGSizeZero;
    
    if ([text isKindOfClass:[NSString class]] && text) {
        
        size = [text boundingRectWithSize:CGSizeMake(Width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:myFont} context:nil].size;
    }
    return size;
    
}



/**
 计算有行间距的label高度
 
 @param maxWidth 限制最大宽度
 @param text 文字
 @param font 字体号
 @param space 行间距
 @return 尺寸
 */
+ (CGSize)sizeMyHaveSpaceLabelWithMaxWidth:(CGFloat)maxWidth WithContentStr:(NSString*)text andFont:(UIFont *)font andLinespace:(CGFloat)space{
    
    if (space==0) {
        space = 6;//行间距默认为6
    }
    
    //ios7
    CGSize retSize = CGSizeZero;
    
    if ([text isKindOfClass:[NSString class]] && text) {
        
        //设置size
        CGSize size = CGSizeMake(maxWidth,MAXFLOAT);
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc]init];
        [style setLineSpacing:space];
        NSDictionary *attribute = @{NSFontAttributeName:font,NSParagraphStyleAttributeName:style};
        
        retSize = [text boundingRectWithSize:size
                                     options:\
                   NSStringDrawingTruncatesLastVisibleLine |
                   NSStringDrawingUsesLineFragmentOrigin |
                   NSStringDrawingUsesFontLeading
                                  attributes:attribute
                                     context:nil].size;
        
        
    }
    
    
    return retSize;
    
}


//毫秒转日期(传入字符串)
+(NSString * )dateChangeStr:(NSString * )dateString andFormat:(NSString*)formatStr{
    //格式为 yyyy-MM-dd HH:mm:ss
    //毫秒转日期
    double time= [dateString doubleValue];
    NSDate * d = [[NSDate alloc]initWithTimeIntervalSince1970:time/1000.0];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //日期样式
    dateFormatter.dateFormat = formatStr;
    [dateFormatter stringFromDate:d];
    //日期
    NSString * newTime=[NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:d]];
    return newTime;
}

//日期转毫秒
+(NSString* )dateHMChange:(NSString*)dateString andFormat:(NSString*)format{
    //日期转毫秒（已经没有8个小时的时差了）
    //    格式：yyyy-MM-dd HH:mm:ss
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = format;
    NSDate * Minedate = [formatter dateFromString:dateString];
    NSTimeInterval timeStamp= [Minedate timeIntervalSince1970]*1000;
    //NSTimeInterval返回的是double类型
    double dateMs = timeStamp;
    //    NSLog(@"日期转换的毫秒数为：%.f", dateMs);
    return [NSString stringWithFormat:@"%.f",dateMs];
}


//获取当前系统时间的日期（已经没有8个小时的时差了）
+(NSString*)getNowDateFormat:(NSString*)formatStr{
    //formatStr格式为 yyyy-MM-dd HH:mm:ss
    NSDate *currentDate = [NSDate date];
    //必须加上时间格式，否则会有8个小时的时差
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatStr];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    //    NSLog(@"当前系统时间日期:%@",dateString);
    return dateString;
}

//获取当前系统时间的毫秒数（已经没有8个小时的时差了）
+(double)getNowTime_Ms{
    //formatStr格式为 yyyy-MM-dd HH:mm:ss
    NSDate * dateXT = [NSDate date];
    NSTimeInterval timeStampXT= [dateXT timeIntervalSince1970]*1000;
    //NSTimeInterval返回的是double类型
    double nowMs = timeStampXT;
    //    NSLog(@"当前系统时间的毫秒数为：%.f",nowMs);
    return nowMs;
}


//字符串或者NSNumber判空方法(可传入字符串类型和NSNumber类型)
+(BOOL)isNULL:(id)stringOrNumber {
    
    if ([stringOrNumber isKindOfClass:[NSNull class]]) {
        return YES;
    }
    
    if (stringOrNumber == nil || stringOrNumber == NULL) {
        return YES;
    }
    
    if ([stringOrNumber isEqual:[NSNull null]]) {
        return YES;
    }
    
    if ([stringOrNumber isEqual:@"(null)"]) {
        return YES;
    }
    
    if ([stringOrNumber isEqual:@"<null>"]) {
        return YES;
    }
    
    if ([stringOrNumber isEqual:@""]) {
        return YES;
    }
    
    
    if (!stringOrNumber) {
        
        return YES;
    }
    
    //字符串才能判长度
    if ([stringOrNumber isKindOfClass:[NSString class]]) {
        
        NSString * stringGet = stringOrNumber;
        if (stringGet.length==0) {
            return YES;
        }
        //字符串专有判法
        if ([[stringGet stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
            return YES;
        }
    }
    
    return NO;
}

//汉字转为百分比
-(NSString*)codeString{
    //汉字转为百分比
    NSString * encodeString = [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
    return encodeString;
    
    
    //   汉字转为百分比转化成汉字
    //    encodeString = [encodeString stringByRemovingPercentEncoding];
    //    NSLog(@"%@", encodeString);
    
}

//判断一个字符串是否是纯数字
- (BOOL)validateNumber:(NSString *) textString
{
    NSString* number=@"^[0-9]+$";
    NSPredicate *numberPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",number];
    return [numberPre evaluateWithObject:textString];
}

//传入数字得到大写字母（0=，1=B）
+(NSString*)numberChangeABC:(NSNumber*)number{
    NSString * stringABC;
    NSArray * arrayABC = @[@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z"];
    for (int i = 0; i< arrayABC.count; i++) {
        if ([number intValue] ==i) {
            stringABC = arrayABC[i];
        }
    }
    return stringABC;
}

//删除字符串首尾空格和回车
+(NSString*)removeStringTwoSpace:(NSString*)string{
    //     str = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString * testStr;
    if ([NSString isNULL:string]==YES) {
        
        testStr = @"";
        
    }else{
        
        testStr = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    }
    return testStr;
}


/**
 用属性字符串计算HTML的高度
 
 @param Info HTML代码
 @param maxWidth 控件最大宽度
 @return 高度
 */
+(CGFloat)getHTML5MaxHeight:(NSString*)Info MaxWidth:(CGFloat)maxWidth{
    
    //设置样式（必须设置）
    NSString * htmlString = [NSString stringWithFormat:@"<head><body width=%fpx style=\"word-wrap:break-word;\"><style>img{max-width:%fpx !important;}</style></head>%@",SCREEN_WIDTH,maxWidth, Info];
    
    NSMutableAttributedString * attrStr = [[NSMutableAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    //字体大小颜色(默认暂时不设置)
    //    [attrStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#000000"]} range:NSMakeRange(0, attrStr.length)];
    
    // 行间距（默认暂时不设置）
    //    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    //    [paragraphStyle setLineSpacing:12.0*px];
    //    [attrStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0,attrStr.length)];
    //大小
    CGRect rect = [attrStr boundingRectWithSize:CGSizeMake(maxWidth, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
    CGFloat heightHtmlCell = CGRectGetHeight(rect);
    //返回高度
    return heightHtmlCell;
}


//系统拨打电话带提示框
+(void)phonecall:(NSString *)phoneNumber{
    //调取系统拨打电话（拨打玩回到界面）
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",phoneNumber]]];
}

#pragma mark ==============打开qq进行指定用户聊天==========
+(void)openQQChat:(NSString*)QQNumber Controller:(UIViewController*)controller{
    //去掉空格，否则打不开qq
    QQNumber = [QQNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"确定在手机QQ里发起聊天？" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        //需要在info.plist中增加LSApplicationQueriesSchemes数组，然后添加item0，item0对应的值为mqqapi；增加item1，item1的值为mqq。
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqq://"]]) {
            UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectZero];
            
            NSURL * url=[NSURL URLWithString:[NSString stringWithFormat:@"mqq://im/chat?chat_type=wpa&uin=%@&version=1&src_type=web", QQNumber]];
            NSURLRequest *request = [NSURLRequest requestWithURL:url];
            
            [webView loadRequest:request];
            
            [controller.view addSubview:webView];
            
            
        }else{
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"对不起，您还没安装QQ" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                
                return ;
                
            }];
            
            [alertController addAction:cancelAction];
            
            [controller presentViewController:alertController animated:YES completion:nil];
            
        }
        
        
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        return ;
        
    }];
    [alertController addAction:okAction];
    [alertController addAction:cancelAction];
    [controller presentViewController:alertController animated:YES completion:nil];
    
    
}

/**
 *  打开微信 , 没有配置
 */
+ (void)openWeixin
{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"确定要打开微信？" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]]) {
            //    @"weixin://"
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"weixin://"]];
            
//            UIApplication对象中openUrl被废弃
//            在iOS 10.0以前的年代，我们要想使用应用程序去打开一个网页或者进行跳转，直接使用[[UIApplication sharedApplication] openURL 方法就可以了，但是在iOS 10 已经被废弃了，因为使用这种方式，处理的结果我们不能拦截到也不能获取到，对于开发是非常不利的，在iOS 10全新的退出了
            
//            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"weixin://"] options:@{} completionHandler:^(BOOL success) {
//
//            }];
            
            
        }else{
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"对不起，您还没安装微信" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                
                return ;
                
            }];
            
            [alertController addAction:cancelAction];
            
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
            
        }
        
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        return ;
        
    }];
    [alertController addAction:okAction];
    [alertController addAction:cancelAction];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
    
    
}


+(NSString *)seeNumShow:(NSNumber*)seeNum{
    
#pragma mark ============== 3.1.0版本浏览数最新展示方式===========================
    NSString * strSee;
    if ([seeNum doubleValue]<10000000) {
        
        strSee = [NSString stringWithFormat:@"%@",seeNum];
        
    }else{
        
        strSee = @"9999999+";
        
    }
    return strSee;
}


//打开外部链接
/**
 在浏览器中打开外部连接
 
 @param outUrl 网址
 */
+(void)openOutUrl:(NSString *)outUrl{
    NSLog(@"打开的外链：%@",outUrl);
    
    if ([NSString isNULL:outUrl]) {
        //连接为NUll
        NSLog(@"链接为空,暂无详情");
        return;
    }
    
#pragma mark =====在浏览器里打开连接，如果连接能打开(项目中公用方法)===============
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:outUrl]]) {
        //打开外连接
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:outUrl]];
        
    }else{
        //打不开
        [DWBToast showCenterWithText:@"该链接无法打开"];
        
    }
    //    警告：不要再淘宝中打开外链了，否则bug多到你吐血！！！！！！！！！
    
}

/**
 获取首字母大写的拼音(传入汉字字符串, 返回首字母大写的拼音)
 
 @param pString 传入汉字
 @return 拼音
 */
+(NSString *)FirstCharactor:(NSString *)pString
{
    if (pString.length>0) {
        
        //转成了可变字符串
        NSMutableString *pStr = [NSMutableString stringWithString:pString];
        //先转换为带声调的拼音
        CFStringTransform((CFMutableStringRef)pStr,NULL, kCFStringTransformMandarinLatin,NO);
        //再转换为不带声调的拼音
        CFStringTransform((CFMutableStringRef)pStr,NULL, kCFStringTransformStripDiacritics,NO);
        //转化为大写拼音
        NSString *pPinYin = [pStr capitalizedString];
        
        //去掉空格
        pPinYin = [pPinYin stringByReplacingOccurrencesOfString:@" " withString:@""];
        //获取并返回首字母
        //    return [pPinYin substringToIndex:1];
        //返回全部拼音首字母大写
        return pPinYin;
    }else{
        
        return @"";
    }
    
}


+(NSAttributedString *)makeTheAmountNumber:(NSString *)amountStr {
    
    NSString * lastStr = [NSString stringWithFormat:@"%@ 元",amountStr];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:lastStr];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:NSMakeRange(0, amountStr.length)];
    return attributedString.copy;
}



/**
 保留两位小数点
 
 @param string s字符串
 @return 格式化后的字符串
 */
-(NSString*)twoPointString:(NSString*)string{
    NSString * str;
    if (string) {
        str = [NSString stringWithFormat:@"%.2f",[string doubleValue]];
    }else{
        str = @"0.00";
    }
    return str;
}

/**
 判断当前ViewController是push还是present的方式显示的返回方法
 
 @param controller 控制器
 */
+(void)popIsPushOrPresent:(UIViewController*)controller{
    
    //     ios开发 判断当前ViewController是push还是present的方式显示的
    NSArray *viewcontrollers = controller.navigationController.viewControllers;
    
    if (viewcontrollers.count > 1)
    {
        if ([viewcontrollers objectAtIndex:viewcontrollers.count - 1] == self)
        {
            //push方式
            [controller.navigationController popViewControllerAnimated:YES];
        }
    }
    else
    {
        //present方式
        [controller dismissViewControllerAnimated:YES completion:nil];
    }
    
}


//秒转成时分秒：00:00:00
+ (NSString*)getTimeMyString:(NSInteger)m_countNum{
    
    if (m_countNum <= 0) {
        
        return @"00:00:00";
        
    } else {
        
        return [NSString stringWithFormat:@"%02ld:%02ld:%02ld",(long)m_countNum/3600,(long)m_countNum%3600/60,(long)m_countNum%60];
    }
}

//秒转成分秒：00:00
+ (NSString*)getTimeMyStringTwo:(NSInteger)m_countNum{
    
    if (m_countNum <= 0) {
        
        return @"00:00";
        
    } else {
        
        return [NSString stringWithFormat:@"%02ld:%02ld",(long)m_countNum/60,m_countNum%60];
    }
}
///根据用户输入的时间(dateString)确定当天是星期几,输入的时间格式 yyyy-MM-dd ,如 2015-12-18
+(NSString *)getTheDayOfTheWeekByDateString:(NSString *)dateString{
    
    NSDateFormatter *inputFormatter=[[NSDateFormatter alloc]init];
    
    [inputFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *formatterDate=[inputFormatter dateFromString:dateString];
    
    NSDateFormatter *outputFormatter=[[NSDateFormatter alloc]init];
    
    [outputFormatter setDateFormat:@"EEEE-MMMM-d"];
    
    NSString *outputDateStr=[outputFormatter stringFromDate:formatterDate];
    
    NSArray *weekArray=[outputDateStr componentsSeparatedByString:@"-"];
    
    return [weekArray objectAtIndex:0];
}


/**
 字符串，移除最后一个字符
 
 @param origin 字符串
 @return 结果
 */
+(NSString*) removeLastOneChar:(NSString*)origin
{
    NSString* cutted;
    if([origin length] > 0){
        cutted = [origin substringToIndex:([origin length]-1)];// 去掉最后一个","
    }else{
        cutted = origin;
    }
    return cutted;
}

/**
 毫秒转时代，如90后00后等
 
 @param dateString 毫秒
 @return 时代
 */
+(NSString * )dateGetShiDai:(NSString * )dateString{
    if ([NSString isNULL:dateString]) {
        //判空，默认90后
        return @"90";
    }
    NSString * dateafter = [NSString stringWithFormat:@"%@",dateString];
    if ([dateString containsString:@"后"]) {
        dateafter  = [NSString dateHMChange:[dateString stringByReplacingOccurrencesOfString:@"后" withString:@""] andFormat:@"yyyy-MM-dd"];
    }else{
        //毫秒
    }
    NSString * date1 = [NSString dateChangeStr:dateafter andFormat:@"yyyy"];//毫秒转日期，获取年份
    NSString * dataeShidai = [date1 substringFromIndex:2];//截取年份后两位
    
    //处理年份，每隔5年一次
    NSInteger timeNum = [dataeShidai integerValue];
    NSInteger timeNum2 = timeNum % 5;
    NSInteger timeNumEnd = timeNum - timeNum2;
    return [NSString stringWithFormat:@"%ld",(long)timeNumEnd];
}


/**
 登陆、注册、修改资料、程序每次启动 后用户资料存入本地
 
 @param userId 用户Id
 @param userName 用户名字
 @param userImage 用户头像
 @param userType 用户类型
 */
+(void)userInfoCacheMyuserId:(NSString * )userId AndUserName:(NSString *)userName AndUserImage:(NSString*)userImage AndUserType:(NSString*)userType{
    
    NSUserDefaults * defuaults = [NSUserDefaults standardUserDefaults];
    //必须判空，防止覆盖
    if ([NSString isNULL:userId]==NO) {
        //把用户ID存进去
        [defuaults setObject:[NSString stringWithFormat:@"%@",userId] forKey:@"userId"];
    }
    if ([NSString isNULL:userName]==NO) {
        //把用户名存进去
        [defuaults setObject:userName forKey:@"userName"];
    }
    if ([NSString isNULL:userImage]==NO) {
        //把用户头像连接存进去
        [defuaults setObject:userImage forKey:@"userPhoneImage"];
    }
    if ([NSString isNULL:userType]==NO) {
        //把用户类型存进去，用户类型 1 普通用户 2 业主用户
        [defuaults setObject:userType forKey:@"userType"];
    }
    //保证数据存储成功
    [defuaults synchronize];
}


/**
 得到系统震动和声音
 */
+(void)getXTSoundAndVibration{
    //必须导入这个框架，否则真机上无效：AudioToolBox.framework
    //系统震动
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    //系统声音
    SystemSoundID sound = 1007;
    AudioServicesPlaySystemSound(sound);
}


/**
 随机字符串 - 生成指定长度的字符串包含数字
 
 @param len 长度
 @return 随机字符串
 */
+(NSString *)randomStringWithLength:(NSInteger)len {
    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    for (NSInteger i = 0; i < len; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform([letters length])]];
    }
    return randomString;
}



/**
 毫秒转化成天、时、分
 
 @param time 毫秒
 @return 格式
 */
+ (NSString*)getTimeMyD_H_M:(double)time{
    NSInteger timeSecond = time/1000;//得到秒
    if (time <= 0) {
        return @"0天0时0分";
    } else {
        NSInteger day = timeSecond/(60*60*24);//天
        NSInteger house = timeSecond%(60*60*24)/3600;//时
        NSInteger mintime = timeSecond%(60*60*24)%3600/60;
        return [NSString stringWithFormat:@"%ld天%02ld时%02ld分",day,house,mintime];
    }
}

/**
 iOS小数点格式化：如果有两位小数不为0则保留两位小数，如果有一位小数不为0则保留一位小数，否则显示整数--商品价格显示用的多
 
 @param strNum 传入数据
 @return 返回格式化后的值
 */
+(NSString *)formatNumPointFloat:(NSString *)strNum{
    if ([NSString isNULL:strNum]) {
        //判空
        return @"0";
    }
    float f = [strNum floatValue];
    if (fmodf(f, 1)==0) {//如果有一位小数点
        return [NSString stringWithFormat:@"%.0f",f];
    } else if (fmodf(f*10, 1)==0) {//如果有两位小数点
        return [NSString stringWithFormat:@"%.1f",f];
    } else {
        return [NSString stringWithFormat:@"%.2f",f];
    }
}


/**
 url网址转化成字典--在用
 
 @param urlStr 网址url
 @return 字典
 */
+(NSDictionary *)dictionaryWithUrlString:(NSString *)urlStr
{
    if ([NSString isNULL:urlStr]) {
        return nil;
    }
    if (urlStr && urlStr.length && [urlStr rangeOfString:@"?"].length == 1) {
        NSArray *array = [urlStr componentsSeparatedByString:@"?"];
        if (array && array.count == 2) {
            NSString *paramsStr = array[1];
            if (paramsStr.length) {
                NSMutableDictionary *paramsDict = [NSMutableDictionary dictionary];
                NSArray *paramArray = [paramsStr componentsSeparatedByString:@"&"];
                for (NSString *param in paramArray) {
                    if (param && param.length) {
                        NSArray *parArr = [param componentsSeparatedByString:@"="];
                        if (parArr.count == 2) {
                            [paramsDict setObject:parArr[1] forKey:parArr[0]];
                        }
                    }
                }
                return paramsDict;
            }else{
                return nil;
            }
        }else{
            return nil;
        }
    }else{
        return nil;
    }
}


/**
 判断字符串是否是纯数字，c语言方法
 
 @param string 字符串
 @return YES代表是纯数字
 */
+(BOOL)isAllNum:(NSString *)string{
    unichar c;
    for (int i=0; i<string.length; i++) {
        c=[string characterAtIndex:i];
        if (!isdigit(c)) {
            return NO;
        }
    }
    return YES;
}


/**
 复制字符串
 
 @param string 结果
 */
+(void)copyCXString:(NSString *)string{
    //复制
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = string;
}


/**
 格式化金额，每隔三位一个逗号显示，保留两位小数，必须传入double类型，不能传入字符串类型
 
 @param doubleMoney 传入的金额,double类型
 @return 返回格式化后的金额
 */
+(NSString *)getMoneyAddDouHaoWithDouble:(double)doubleMoney{
    
    NSString * numberStr = [NSString stringWithFormat:@"%f",doubleMoney];
    // 判断是否null 若是赋值为0 防止崩溃
    if (([numberStr isEqual:[NSNull null]] || numberStr == nil)) {
        numberStr = @"0.00";
    }
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc]init];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    // 注意传入参数的数据长度，可用double
    NSString *money = [formatter stringFromNumber:[NSNumber numberWithDouble:[numberStr doubleValue]]];
    //注意上面如果及过时100.70，只会得到100.7
    
    
    //下面处理让任何一种情况下，都能保留两位小数
    
    //拿到数据后根据逗号切割
    NSArray * arrayMoney;
    
    if ([money containsString:@"."]) {
        //包含小数点
        arrayMoney = [money componentsSeparatedByString:@"."];
        
    }else{
        //不包含小数点
        arrayMoney = @[money,@"00"];
    }
    
    NSString * lastMoney = arrayMoney.lastObject;
    if (lastMoney.length<2) {
        //末尾拼接0
        lastMoney = [NSString stringWithFormat:@"%@0",lastMoney];
    }
    NSString * moneyend = [NSString stringWithFormat:@"%@.%@",arrayMoney.firstObject,lastMoney];
    
    //返回值带两位小数点
    return moneyend;
    
    return money;
}


/**
 格式化数字，每隔三位一个逗号显示，如果后面没小数就不会显示小数
 
 @param doubleMoney 传入的金额,double类型
 @return 返回格式化后的金额
 */
+(NSString *)getMoneyAddDouHaoNOPointWithDouble:(double)doubleMoney{
    
    NSString * numberStr = [NSString stringWithFormat:@"%f",doubleMoney];
    // 判断是否null 若是赋值为0 防止崩溃
    if (([numberStr isEqual:[NSNull null]] || numberStr == nil)) {
        numberStr = @"0";
    }
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc]init];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    // 注意传入参数的数据长度，可用double
    NSString *money = [formatter stringFromNumber:[NSNumber numberWithDouble:[numberStr doubleValue]]];
    //注意上面如果及过时100.70，只会得到100.7
    return money;
}




/**
 判断是否为有效网址,YES代表是
 
 @param infor 字符串
 @return 结果
 */
+ (BOOL)isHttpStringWithWeb:(NSString *)infor{
    NSString *emailRegex = @"[a-zA-z]+://.*";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:infor];
}


@end
