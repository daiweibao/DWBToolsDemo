//
//  NSString+DWBHelp.h
//  DWBToolsDemo
//
//  Created by 戴维保 on 2018/9/5.
//  Copyright © 2018年 潮汐科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (DWBHelp)

/**
 *  手机号码验证 + YES表示是手机号，NO表示不是
 *
 *  @param string 手机号
 *
 *  @return YES 表示是手机号，NO表示不是
 */
+(BOOL)phoneText:(NSString*)string;


/**
 *密码格式验证
 */
+(BOOL)passWordText:(NSString*)string;

/**
 *  标签限制+只能是汉字并且是1到10个字 + YES 表示是汉字
 *
 *  @return YES 表示是汉字
 */
- (BOOL)LabelonlyChinese;

/**
 *  汉字转拼音
 *
 *  @param chinese 汉字
 *
 *  @return 拼音
 */

+ (NSString *)transform:(NSString *)chinese;

/**
 时间计算 刚刚－几分钟前－几小时前
 
 @param dateStr 日期的毫秒
 @return 返回结果
 */
+(NSString *)dateCompareCurrentNowTime:(NSString*)dateStr;

/**
 *  根据日期判断星座 月+日
 *
 *  @param m 月
 *  @param d 日
 *
 *  @return 星座名字
 */
+(NSString *)getAstroWithMonth:(int)m day:(int)d;
/**
 *  根据生日获取年龄 + 格式：yyyy-MM-dd
 *
 *  @param birthday  生日
 *  @param formatter 格式
 *
 *  @return 结果
 */
-(NSString *)dateBirthday:(NSString *)birthday Formatter:(NSString*)formatter;
/**
 *  秒杀时间 + 传入毫秒
 *
 *  @param start   开始时间
 *  @param endtime 结束时间
 *
 *  @return 状态
 */
+(NSString*)timeCha:(NSNumber*)start Endtime:(NSNumber*)endtime;


/**
 *  通用正则匹配，可以匹配任意东西，只需要传入正则表达式跟字符串即可
 *
 *  @param string            字符串
 *  @param regularExpression 格式
 *
 *  @return 结果
 */
+ (NSString *)processWithString:(NSString *)string regularExpression:(NSString *)regularExpression;

/**
 *  传入文本内容、字体大小、控件宽度返回计算的文本占用位置的大小（含宽，高）
 *
 *  @param text     字符串
 *  @param myFont   字体大小
 *  @param Width    控件最大宽度
 *
 *  @return size，包括宽高
 */
+(CGSize)sizeMyStrWith:(NSString*)text andMyFont:(UIFont *)myFont andMineWidth:(CGFloat)Width;

/**
 计算有行间距的label高度
 
 @param maxWidth 限制最大宽度
 @param text 文字
 @param font 字体号
 @param space 行间距
 @return 尺寸
 */
+ (CGSize)sizeMyHaveSpaceLabelWithMaxWidth:(CGFloat)maxWidth WithContentStr:(NSString*)text andFont:(UIFont *)font andLinespace:(CGFloat)space;

/**
 *  毫秒转日期 + 格式为：yyyy-MM-dd HH:mm:ss
 *
 *  @param dateString  毫秒(传入NSString)
 *  @param formatStr yyyy-MM-dd HH:mm:ss
 *
 *  @return 日期
 */
+(NSString * )dateChangeStr:(NSString * )dateString andFormat:(NSString*)formatStr;


/**
 *  日期转毫秒 + 格式：yyyy-MM-dd HH:mm:ss
 *
 *  @param dateString 日期
 *  @param format     格式：yyyy-MM-dd HH:mm:ss
 *
 *  @return 字符串
 */
+(NSString* )dateHMChange:(NSString*)dateString andFormat:(NSString*)format;

/**
 *  获取当前系统时间的日期（已经没有8个小时的时差了） + 格式：yyyy-MM-dd HH:mm:ss
 *
 *  @param formatStr 格式：yyyy-MM-dd HH:mm:ss
 *
 *  @return 时间
 */
+(NSString*)getNowDateFormat:(NSString*)formatStr;

/**
 *  获取当前系统时间的毫秒数（已经没有8个小时的时差了）
 *
 *  @return 毫秒
 */
+(double)getNowTime_Ms;

/// 任意两个日期的天数差
/// @param beginDate 开始日期
/// @param endDate 结束日志
+ (NSInteger)getTheCountOfTwoDaysWithBeginDate:(NSString *)beginDate endDate:(NSString *)endDate;
/**
 *  已知开始时间和结束时间的毫秒，计算开始、进行中、结束状态
 *
 *  @param sta 开始时间的毫秒
 *  @param end 结束时间的毫秒
 *
 *  @return 状态
 */
+(NSString*)timeStateStart:(double)sta Endtime:(double)end;

/**
 *  字符串+NSNumber判空方法 YES表示为空，NO表示不为空
 *
 *  @param stringOrNumber 字符串或者Number
 *
 *  @return 结果
 */
+(BOOL)isNULL:(id)stringOrNumber;

/**
 *  汉字转码，转化成百分比 + 拼接在接口里发起网络请求用
 *
 *  @return 结果
 */
-(NSString*)codeString;


/**
 正则判断一个字符串是否是纯数字
 
 @param textString 字符串
 @return 结果
 */
- (BOOL)validateNumber:(NSString *) textString;

/**
 传入数字得到大写字母（0=，1=B）
 
 @param number 数字26以内
 @return 大写字母
 */
+(NSString*)numberChangeABC:(NSNumber*)number;


/**
 删除字符串首尾空格和回车
 
 @param string 字符串
 @return 字符串
 */
+(NSString*)removeStringTwoSpace:(NSString*)string;

/**
 用属性字符串计算HTML的高度
 
 @param Info HTML代码
 @param maxWidth 控件最大宽度
 @return 高度
 */
+(CGFloat)getHTML5MaxHeight:(NSString*)Info MaxWidth:(CGFloat)maxWidth;


/**
 系统拨打电话带提示框
 
 @param phoneNumber 电话号码
 */
+(void)phonecall:(NSString *)phoneNumber;
#pragma mark ==============打开qq进行指定用户聊天==========

/**
 打开qq进行指定用户聊天
 
 @param QQNumber qq号码
 @param controller 控制器
 */
+(void)openQQChat:(NSString*)QQNumber Controller:(UIViewController*)controller;
/**
 *  打开微信 , 没有配置
 */
+ (void)openWeixin;

/**
 返回格式化后的浏览数，用K展示
 
 @param seeNum 浏览数
 @return 数
 */
+(NSString *)seeNumShow:(NSNumber*)seeNum;


/**
 在浏览器中打开外部连接
 
 @param outUrl 网址
 */
+(void)openOutUrl:(NSString *)outUrl;

/**
 获取首字母大写的拼音(传入汉字字符串, 返回首字母大写的拼音)
 
 @param pString 传入汉字
 @return 拼音
 */
+(NSString *)FirstCharactor:(NSString *)pString;


+(NSAttributedString *)makeTheAmountNumber:(NSString *)amountStr ;

/**
 保留两位小数点
 
 @param string s字符串
 @return 格式化后的字符串
 */
-(NSString*)twoPointString:(NSString*)string;

#pragma mark 清除上传视频产生的缓存（独家使用）

/**
 判断当前ViewController是push还是present的方式显示的返回方法
 
 @param controller 控制器
 */
+(void)popIsPushOrPresent:(UIViewController*)controller;

/**
 根据用户输入的时间(dateString)确定当天是星期几,输入的时间格式 yyyy-MM-dd ,如 2015-12-18
 
 @param dateString 日期格式固定：yyyy-MM-dd
 @return 星期
 */
+(NSString *)getTheDayOfTheWeekByDateString:(NSString *)dateString;
/**
 字符串，移除最后一个字符
 
 @param origin 字符串
 @return 结果
 */
+(NSString*) removeLastOneChar:(NSString*)origin;
/**
 返回时\分\秒：00:00:00
 
 @param m_countNum 秒
 @return 结果
 */
+ (NSString*)getTimeMyString:(NSInteger )m_countNum;

/**
 返回分\秒：00:00
 
 @param m_countNum 秒
 @return 结果
 */
+ (NSString*)getTimeMyStringTwo:(NSInteger)m_countNum;

/**
 毫秒转时代，如90后00后等
 
 @param dateString 毫秒
 @return 时代
 */
+(NSString * )dateGetShiDai:(NSString * )dateString;

/**
 登陆、注册、修改资料后用户资料存入本地
 
 @param userId 用户Id
 @param userName 用户名字
 @param userImage 用户头像
 @param userType 用户类型
 */
+(void)userInfoCacheMyuserId:(NSString * )userId AndUserName:(NSString *)userName AndUserImage:(NSString*)userImage AndUserType:(NSString*)userType;
/**
 得到系统震动和声音
 */
+(void)getXTSoundAndVibration;
/**
 随机字符串 - 生成指定长度的字符串包含数字
 
 @param len 长度
 @return 随机字符串
 */
+(NSString *)randomStringWithLength:(NSInteger)len;
/**
 获取一个随机整数，范围在[from,to），包括from，不包括to
 
 @param from 最小值，包含自己
 @param to 最大值，不包含自己
 @return 结果
 */
+(int)getRandomNumber:(int)from to:(int)to;

/**
 毫秒转化成天、时、分
 
 @param time 毫秒
 @return 格式
 */
+ (NSString*)getTimeMyD_H_M:(double)time;
/**
 iOS小数点格式化：如果有两位小数不为0则保留两位小数，如果有一位小数不为0则保留一位小数，否则显示整数--商品价格显示用的多
 
 @param strNum 传入数据
 @return 返回格式化后的值
 */
+(NSString *)formatNumPointFloat:(NSString *)strNum;

/**
 url网址转化成字典--在用
 
 @param urlStr 网址url
 @return 字典
 */
+(NSDictionary *)dictionaryWithUrlString:(NSString *)urlStr;

/**
 判断字符串是否是纯数字，c语言方法
 
 @param string 字符串
 @return YES代表是纯数字
 */
+(BOOL)isAllNum:(NSString *)string;

/**
 复制字符串
 
 @param string 结果
 */
+(void)copyCXString:(NSString *)string;

/**
 格式化金额，每隔三位一个逗号显示，保留两位小数，必须传入string类型
 
 @param stringMoney 传入的金额,String类型
 @return 返回格式化后的金额
 */
+(NSString *)getMoneyAddDouHaoWithMoneyStr:(NSString *)stringMoney;

/**
 格式化数字，每隔三位一个逗号显示，如果后面没小数就不会显示小数
 
 @param stringMoney 传入的金额
 @return 返回格式化后的金额
 */
+(NSString *)getMoneyAddDouHaoNOPointWithMoneyStr:(NSString *)stringMoney;

/**
 判断是否为有效网址,YES代表是
 
 @param infor 字符串
 @return 结果
 */
+ (BOOL)isHttpStringWithWeb:(NSString *)infor;

/**
 清除WKWeb缓存，否则H5界面跟新，这边不会更新
 */
+(void)remoWKWebViewCookies;

/**
 判断是否是今天第一次。一天一次
 
 @param eventId 事件ID
 @return 返回YES,代表是今天第一次，NO不是
 */
+(BOOL)isToadyFirstWithEventId:(NSString *)eventId;

/**
 传入数据，返回带万单位的字符串
 
 @param strNum 纯数据
 */
+(NSString *)getNumToWanStringWithStr:(NSString *)strNum;

@end
