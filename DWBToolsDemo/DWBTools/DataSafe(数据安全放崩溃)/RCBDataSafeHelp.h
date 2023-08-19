//
//  RCBDataSafeHelp.h
//  Demo
//
//  Created by 潮汐 on 2022/11/4.
//  Copyright © 2022年 北农商. All rights reserved.
//安全数据处理：防止后台返回数据类型错误时候导致崩溃。比如字典返回来的是数组，不处理就会导致奔溃

#import <Foundation/Foundation.h>
//用户示例：
//NSDictionary *dataData = @{};//后台返回的数据
//NSDictionary *dict = RCBSafeDic(dataData[@"info"]);
#define RCBSafeDic(dict)   [RCBDataSafeHelp safeDictionary:dict]
#define RCBSafeArray(array)   [RCBDataSafeHelp safeArray:array]
//安全字符串示例:
//NSDictionary *dataData = @{};//后台返回的数据
//NSString * str = RCBSafeStr(dataData[@"name"])
#define RCBSafeStr(str)   [RCBDataSafeHelp safeString:str]

//
#define RCBSafeMutableArray(mutableArray)   [RCBDataSafeHelp safeMutableArray:mutableArray]
#define RCBSafeMutableDic(mutableDict)   [RCBDataSafeHelp safeMutableDictionary:mutableDict]
#define RCBSafeObj(obj)   [RCBDataSafeHelp safeObj:obj]


@interface RCBDataSafeHelp : NSObject
/**
 judge the paramter is a kind of class NSArray , if yes return the array,if not return nil
 
 @param array the array need to judge
 @return the safeData
 */
+ (NSArray *)safeArray:(id)array;

/**
 return a mutableArray ,if the params is not a kind of NSMutableArray return nil
 
 @param mutableArray the parameter need to judge
 @return the safeData
 */
+ (NSMutableArray *)safeMutableArray:(id)mutableArray;


/**
 return a NSDictionary ,if the params is not a kind of NSDictionary return nil
 
 @param dict the parameter need to judge
 @return the safeData
 */
+ (NSDictionary *)safeDictionary:(id)dict;

/**
 return a NSMutableDictionary ,if the params is not a kind of NSMutableDictionary return nil
 
 @param dict the parameter need to judge
 @return the safeData
 */
+ (NSMutableDictionary *)safeMutableDictionary:(id)dict;

/**
 return a NSObject ,if the params is not a kind of NSObject return nil
 
 @param obj the parameter need to judge
 @return the safeData
 */
+ (id)safeObj:(id)obj;

/// 字符串或者NSNumber判空方法(可传入字符串类型和NSNumber类型)
/// @param stringOrNumber 传入任意字符串或者number
+ (NSString *)safeString:(id)stringOrNumber;


@end

