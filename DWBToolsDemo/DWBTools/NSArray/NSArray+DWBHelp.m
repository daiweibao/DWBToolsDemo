//
//  NSArray+DWBHelp.m
//  DWBToolsDemo
//
//  Created by 爱恨的潮汐 on 2018/11/2.
//  Copyright © 2018 潮汐科技有限公司. All rights reserved.
//

#import "NSArray+DWBHelp.h"

@implementation NSArray (DWBHelp)


/**
 数组去重，顺序不会变

 @param array 传入的数组
 @return 得到去重后的可变数组
 */
+(NSMutableArray *)arrayDataDeleteChongFuWithArray:(NSArray *)array{
    NSMutableArray *listAry = [[NSMutableArray alloc]init];
    for (NSString *str in array) {
        //        containsObject 判断数组是否包含某个元素
        if (![listAry containsObject:str]) {
            [listAry addObject:str];
        }
    }
    return listAry;
}

/**
 打乱数组顺序
 
 @param arr 数组
 @return 打乱顺序后的数组
 */
+(NSMutableArray*)arrayGetRandomArrFrome:(NSArray*)arr{
    NSMutableArray *newArr = [NSMutableArray new];
    while (newArr.count != arr.count) {
        //生成随机数
        int x =arc4random() % arr.count;
        id obj = arr[x];
        if (![newArr containsObject:obj]) {
            [newArr addObject:obj];
        }
    }
    return newArr;
}

@end
