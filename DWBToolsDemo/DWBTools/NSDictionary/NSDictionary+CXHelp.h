//
//  NSDictionary+CXHelp.h
//  AiHenDeChaoXi
//
//  Created by 戴维保 on 2018/7/19.
//  Copyright © 2018年 北京嗅美科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (CXHelp)
/*!
 * @brief 把格式化的JSON格式的字符串转换成字典
 * @param jsonString JSON格式的字符串
 * @return 返回字典
 */
+ (NSDictionary *)jsonToDictionaryWithJsonString:(NSString *)jsonString;
/**
 把字典转化成JSON字符串
 
 @param dic 字典
 @return json字符串
 */
+ (NSString*)dictionaryToJson:(NSDictionary *)dic;



/**
 NSArray、NSDictionary转换为json：
 
 @param obj 字典或者数组
 @return json字符串
 */
+(NSString *)objectToJson:(id)obj;


/**
 json转NSArray、NSDictionary：
 
 @param json json字符串
 @return NSArray、NSDictionary
 */
+(id)jsonToObject:(NSString *)json;



/**
 把多个json字符串转为一个json字符串【数组里存了json字符串】
 
 @param array json数组
 @return json字符串
 */
+(NSString *)moreArrayToJSON:(NSArray *)array;


//自动生成属性代码
//开发中，从网络数据中解析出字典数组，将数组转为模型时，如果有几百个key需要用，要写很多@property成员属性，下面提供一个万能的方法，可直接将字典数组转为全部@property成员属性，打印出来，这样直接复制在模型中就好了
/**
 自动打印Model属性字符串
 
 @param dict 字典数据
 */
+ (void)NSLogDictModelPropertyWithDict:(NSDictionary *)dict;


/// 判断字典是否为空
/// @param dict YES为空，NO不为空
+(BOOL)isNullDict:(NSDictionary *)dict;


/// 读取本地json文件（如：menuQry.json）
/// @param jsonName json文件名，不包含.json后缀
/// @return 字典数据
+ (NSDictionary *)getJsonDictionaryFileWithJsonName:(NSString *)jsonName;

/**
 url网址转化成字典--在用
 
 @param urlStr 网址url
 @return 字典
 */
+(NSDictionary *)dictionaryWithUrlString:(NSString *)urlStr;

@end
