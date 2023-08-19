//
//  RCBDataSafeHelp.h
//  Demo
//
//  Created by 潮汐 on 2022/11/4.
//  Copyright © 2022年 北农商. All rights reserved.
//

#import "RCBDataSafeHelp.h"

@implementation RCBDataSafeHelp
//安全数组
+ (NSArray *)safeArray:(id)array {
    if ([array isKindOfClass:[NSArray class]]) {
        return array;
    }else if([array isKindOfClass:[NSMutableArray class]]){
        return array;
    }else{
        return @[];
    }
}
//安全字典
+ (NSDictionary *)safeDictionary:(id)dict {
    if ([dict isKindOfClass:[NSDictionary class]]) {
        return dict;
    }else if([dict isKindOfClass:[NSMutableDictionary class]]){
        return dict;
    }else{
        return @{};
    }
}
//安全可变数组
+ (NSMutableArray *)safeMutableArray:(id)mutableArray {
    if ([mutableArray isKindOfClass:[NSMutableArray class]]) {
        return mutableArray;
    }
    return nil;
}

//安全可变字典
+ (NSMutableDictionary *)safeMutableDictionary:(id)dict {
    if ([dict isKindOfClass:[NSMutableDictionary class]]) {
        return dict;
    }
    return nil;
}

//
+ (id)safeObj:(id)obj {
    if ([obj isKindOfClass:[NSObject class]] && ![obj isKindOfClass:[NSNull class]] ) {
        return obj;
    }
    return nil;
}



#pragma mark ====重点：安全字符串
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

