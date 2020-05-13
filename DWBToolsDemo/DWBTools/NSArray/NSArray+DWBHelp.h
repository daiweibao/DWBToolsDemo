//
//  NSArray+DWBHelp.h
//  DWBToolsDemo
//
//  Created by 戴维保 on 2018/11/2.
//  Copyright © 2018 潮汐科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (DWBHelp)
/**
 数组去重，顺序不会变
 
 @param array 传入的数组
 @return 得到去重后的可变数组
 */
+(NSMutableArray *)arrayDataDeleteChongFuWithArray:(NSArray *)array;

/**
 打乱数组顺序
 
 @param arr 数组
 @return 打乱顺序后的数组
 */
+(NSMutableArray*)arrayGetRandomArrFrome:(NSArray*)arr;


/**
 OC版冒泡排序,必须传入可变数组，数组包含数字元素
 
 @param mArray 可变数组
 @return 排好序的数组
 */
+ (NSMutableArray *)maopaoSortWithMarray:(NSMutableArray *)mArray;


/// 获取无重复字典元素的数组（数组里根据字典某一个元素去重） filterKey为过滤关键字：去掉前面的重复数据，保留后面的数据，覆盖式去重
/// @param originArray 要去重的数组
/// @param filterKey 根据数据里存放的字典的某一个键去重，如userId
+(NSArray *)getNoDuplicatesArrayByOriginArray:(NSArray *)originArray
                                    filterKey:(NSString *)filterKey;

@end

NS_ASSUME_NONNULL_END
