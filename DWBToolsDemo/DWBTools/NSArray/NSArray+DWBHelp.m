//
//  NSArray+DWBHelp.m
//  DWBToolsDemo
//
//  Created by 戴维保 on 2018/11/2.
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

@end
