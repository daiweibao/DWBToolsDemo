//
//  NSArray+DWBHelp.m
//  DWBToolsDemo
//
//  Created by chaoxi on 2018/11/2.
//  Copyright © 2018 chaoxi科技有限公司. All rights reserved.
//

#import "NSArray+DWBHelp.h"

@implementation NSArray (DWBHelp)


/**
 数组去重，顺序不会变

 @param array 传入的数组
 @return 得到去重后的可变数组
 */
+(NSMutableArray *)arrayDataDeleteChongFuWithArray:(NSArray *)array{
    NSMutableArray *listAry = [[NSMutableArray alloc]init];//去重后的数组
//     NSMutableArray *listAryCF = [[NSMutableArray alloc]init];//检出重复的元素，放入数组
    for (NSString *str in array) {
        //        containsObject 判断数组是否包含某个元素
        if (![listAry containsObject:str]) {
            [listAry addObject:str];
            
        }else{
            //附加
            //重复元素加入新数组
//            [listAryCF addObject:str];
//            NSLog(@"重复的元素：%@",str);
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



/**
 OC版冒泡排序,必须传入可变数组，数组包含数字元素

 @param mArray 可变数组
 @return 排好序的数组
 */
+ (NSMutableArray *)maopaoSortWithMarray:(NSMutableArray *)mArray{
    //外层循环
    for (int i = 0; i < mArray.count; i ++) {
        //内层循环
        for (int j = 0; j < mArray.count - i; j++) {
            //比较大小
            //升序
//            if ([mArray[j] intValue] > [mArray[j +1] intValue]) {
//                //交换
//                [mArray exchangeObjectAtIndex:j withObjectAtIndex:j+1];
//            }
            
            //降序
            if ([mArray[j] intValue] < [mArray[j +1] intValue]) {
                //交换
                [mArray exchangeObjectAtIndex:j withObjectAtIndex:j+1];
            }
        }
    }
    return mArray;
    
    /*
     
     用法：
     
     //传入数组
     NSMutableArray * mArray = [NSMutableArray arrayWithArray:@[@6,@4,@9,@5,@8,@0,@30]];
     
     //得到数组：
     NSArray * resultsArray =  [NSArray maopaoSortWithMarray:mArray];
     NSLog(@"冒泡排序好的数组：%@",resultsArray);
     
     
     */
    
}
/// 获取无重复字典元素的数组（数组里根据字典某一个元素去重） filterKey为过滤关键字：去掉前面的重复数据，保留后面的数据，覆盖式去重
+(NSArray *)getNoDuplicatesArrayByOriginArray:(NSArray *)originArray
                                    filterKey:(NSString *)filterKey{
    if ([NSString isNULL:filterKey]) {
        return originArray;
    }
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    for (NSInteger i = 0; i < originArray.count; i++) {
        NSDictionary *dic = originArray[i];
        if (dictionary) {
           [dictionary setValue:dic forKey:dic[filterKey]];
        }
    }
    NSLog(@"%@",[dictionary allValues]);
    return [dictionary allValues];
}

@end
