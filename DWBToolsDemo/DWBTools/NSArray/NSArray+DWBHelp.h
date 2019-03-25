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

@end

NS_ASSUME_NONNULL_END
