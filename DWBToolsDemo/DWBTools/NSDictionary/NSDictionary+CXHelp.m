
//
//  NSDictionary+CXHelp.m
//  AiHenDeChaoXi
//
//  Created by 戴维保 on 2018/7/19.
//  Copyright © 2018年 潮汐科技有限公司. All rights reserved.
//
//字典类别（Category）
#import "NSDictionary+CXHelp.h"

@implementation NSDictionary (CXHelp)

/*!
 * @brief 把格式化的JSON格式的字符串转换成字典
 * @param jsonString JSON格式的字符串
 * @return 返回字典
 */
+ (NSDictionary *)jsonToDictionaryWithJsonString:(NSString *)jsonString {
    if ([NSString isNULL:jsonString]) {
        //判空拦截，否则会崩溃
        return nil;
    }
    //    json格式字符串转字典不能直接转化需要先转换成Data，在转化成字，
    //    同样字典也不能直接转换成json格式字符串。
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}


/**
 把字典转化成JSON字符串
 
 @param dic 字典
 @return json字符串
 */
+ (NSString*)dictionaryToJson:(NSDictionary *)dic

{
    //    NSJSONWritingPrettyPrinted 是有换位符的。
    //    如果NSJSONWritingPrettyPrinted 是nil 的话 返回的数据是没有 换位符的
    if (dic.count>0) {
        NSError *parseError = nil;
        
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
        
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }else{
        
        return @"";
    }
    
    
    
}

//NSArray、NSDictionary转换为json：
+(NSString *)objectToJson:(id)obj{
    if (obj == nil) {
        return nil;
    }
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:obj
                                                       options:0
                                                         error:&error];
    
    if ([jsonData length] && error == nil){
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }else{
        return nil;
    }
}

//json转NSArray、NSDictionary：
+(id)jsonToObject:(NSString *)json{
    //string转data
    NSData * jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
    //json解析
    id obj = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    return obj;
}



/**
 把多个json字符串转为一个json字符串【数组里存了json字符串】
 
 @param array json数组
 @return json字符串
 */
+(NSString *)moreArrayToJSON:(NSArray *)array {
    if (array.count<=0) {
        return @"";
    }
    NSString *jsonStr = @"[";
    for (NSInteger i = 0; i < array.count; ++i) {
        if (i != 0) {
            jsonStr = [jsonStr stringByAppendingString:@","];
        }
        jsonStr = [jsonStr stringByAppendingString:array[i]];
    }
    jsonStr = [jsonStr stringByAppendingString:@"]"];
    
    return jsonStr;
}


//自动生成属性代码
//开发中，从网络数据中解析出字典数组，将数组转为模型时，如果有几百个key需要用，要写很多@property成员属性，下面提供一个万能的方法，可直接将字典数组转为全部@property成员属性，打印出来，这样直接复制在模型中就好了
// 自动打印属性字符串
+ (void)NSLogDictModelPropertyWithDict:(NSDictionary *)dict{
    
    // 拼接属性字符串代码
    NSMutableString *strM = [NSMutableString string];
    
    // 1.遍历字典，把字典中的所有key取出来，生成对应的属性代码
    [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
        // 类型经常变，抽出来
        NSString *code = nil;
        
        //        NSLog(@"%@",[value class]);
        if ([obj isKindOfClass:[NSString class]]) {
            //NSString
            code = [NSString stringWithFormat:@"@property (nonatomic, copy) NSString *%@;",key];
            
        } else if ([obj isKindOfClass:NSClassFromString(@"__NSCFBoolean")]){
            //BOOL
            code = [NSString stringWithFormat:@"@property (nonatomic, assign) BOOL %@;",key];
            
        } else if ([obj isKindOfClass:[NSNumber class]]) {
            //NSNumber也用字符串接收, 不用NSInteger
            code = [NSString stringWithFormat:@"@property (nonatomic, strong) NSString *%@;",key];
            
        } else if ([obj isKindOfClass:[NSArray class]]) {
            //NSArray
            code = [NSString stringWithFormat:@"@property (nonatomic, strong) NSArray *%@;",key];
            
        } else if ([obj isKindOfClass:[NSDictionary class]]) {
            //NSDictionary
            code = [NSString stringWithFormat:@"@property (nonatomic, strong) NSDictionary *%@;",key];
        }else{
            //否则都用字符串来接收NSString
            code = [NSString stringWithFormat:@"@property (nonatomic, copy) NSString *%@;",key];
            
        }
        
        // 每生成属性字符串，就自动换行。
        [strM appendFormat:@"\n%@\n",code];
        
    }];
    
    // 把拼接好的字符串打印出来，复制到Model里就好了。
    NSLog(@"Model属性：\n%@",strM);
    
}

+(BOOL)isNullDict:(NSDictionary *)dict{
    BOOL isDict = YES;
    if ([dict isKindOfClass:[NSDictionary class]]) {
        isDict = YES;
    }else if([dict isKindOfClass:[NSMutableDictionary class]]){
        isDict = YES;
    }else{
        isDict = NO;
    }
    if (isDict==YES) {
        if ([dict isKindOfClass:[NSNull class]]) {
            return YES;
        }else if ([dict isEqual:[NSNull null]]){
            return YES;
        }else if (dict.count == 0){
            return YES;
        }else if (dict == nil){
            return YES;
        }else{
            return NO;
        }
    }else{
       return YES;
    }
}






@end

