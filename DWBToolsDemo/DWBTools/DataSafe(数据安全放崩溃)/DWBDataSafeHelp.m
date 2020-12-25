//
//  DWBDataSafeHelp.m
//  DWBDemo
//
//  Created by chaoxi on 2018/3/2.
//  Copyright © 2018年 chaoxi科技有限公司. All rights reserved.
//

#import "DWBDataSafeHelp.h"

@implementation DWBDataSafeHelp
//安全数组
+ (NSArray *)safeArray:(id)array {
    if ([array isKindOfClass:[NSArray class]]) {
        return array;
    }else if([array isKindOfClass:[NSMutableArray class]]){
        return array;
    }else{
        return nil;
    }
}
//安全字典
+ (NSDictionary *)safeDictionary:(id)dict {
    if ([dict isKindOfClass:[NSDictionary class]]) {
        return dict;
    }else if([dict isKindOfClass:[NSMutableDictionary class]]){
        return dict;
    }else{
        return nil;
    }
}

+ (NSMutableArray *)safeMutableArray:(id)mutableArray {
    if ([mutableArray isKindOfClass:[NSMutableArray class]]) {
        return mutableArray;
    }
    return nil;
}


+ (NSMutableDictionary *)safeMutableDictionary:(id)dict {
    if ([dict isKindOfClass:[NSMutableDictionary class]]) {
        return dict;
    }
    return nil;
}


+ (id)safeObj:(id)obj {
    if ([obj isKindOfClass:[NSObject class]] && ![obj isKindOfClass:[NSNull class]] ) {
        return obj;
    }
    return nil;
}



#pragma mark ====重点
/// 字符串或者NSNumber判空方法(可传入字符串类型和NSNumber类型)
/// @param stringOrNumber 传入任意字符串或者number
+ (NSString *)safeString:(id)stringOrNumber {
#pragma mark ======== 先判断是不是数组或者字典============
    if ([stringOrNumber isKindOfClass:[NSArray class]]) {
        return @"";
    }
    if([stringOrNumber isKindOfClass:[NSMutableArray class]]){
        return @"";
    }
    if ([stringOrNumber isKindOfClass:[NSDictionary class]]) {
        return @"";
    }
    if([stringOrNumber isKindOfClass:[NSMutableDictionary class]]){
        return @"";
    }
#pragma mark ======== 再开始判断============
    if ([stringOrNumber isKindOfClass:[NSNull class]]) {
        return @"";
    }
    
    if (stringOrNumber == nil || stringOrNumber == NULL) {
        return @"";
    }
    
    if ([stringOrNumber isEqual:[NSNull null]]) {
        return @"";
    }
    
    if ([stringOrNumber isEqual:@"(null)"]) {
       return @"";
    }
    
    if ([stringOrNumber isEqual:@"<null>"]) {
        return @"";
    }
    
    if ([stringOrNumber isEqual:@""]) {
        return @"";
    }
    
    if (!stringOrNumber) {
        
        return @"";
    }
    
    //字符串才能判长度
    if ([stringOrNumber isKindOfClass:[NSString class]]) {
        
        NSString * stringGet = stringOrNumber;
        if (stringGet.length==0) {
            return @"";
        }
        //字符串专有判法
        if ([[stringGet stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
            return @"";
        }
    }
    return [NSString stringWithFormat:@"%@",stringOrNumber];
}

@end
