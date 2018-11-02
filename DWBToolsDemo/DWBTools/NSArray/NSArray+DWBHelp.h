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

@end

NS_ASSUME_NONNULL_END
