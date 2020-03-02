//
//  DWBDataSafeHelp.h
//  DWBDemo
//
//  Created by 戴维保 on 2018/4/3.
//  Copyright © 2018年 潮汐科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
//用户示例：
//NSDictionary *dataData = @{};//后台返回的数据
//NSDictionary *dict = DWBSafeDic(dataData[@"info"]);
#define DWBSafeDic(dict)   [DWBDataSafeHelp safeDictionary:dict];
#define DWBSafeArray(array)   [DWBDataSafeHelp safeArray:array];
//安全字符串示例:
//NSDictionary *dataData = @{};//后台返回的数据
//NSString * str = DWBSafeStr(dataData[@"name"])
#define DWBSafeStr(str)   [DWBDataSafeHelp safeString:str];

#define DWBSafeMutableArray(mutableArray)   [DWBDataSafeHelp safeMutableArray:mutableArray];

#define DWBSafeMutableDic(mutableDict)   [DWBDataSafeHelp safeMutableDictionary:mutableDict];


#define DWBSafeStr1(str, defaultString)   [DWBDataSafeHelp safeStr:str defaultStr:defaultString];

#define DWBSafeObj(obj)   [DWBDataSafeHelp safeObj:obj];


@interface DWBDataSafeHelp : NSObject
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
