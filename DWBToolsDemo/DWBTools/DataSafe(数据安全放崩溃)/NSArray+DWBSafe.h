//
//  NSArray+DWBSafe.h
//  DWBToolsDemo
//
//  Created by chaoxi on 2018/10/26.
//  Copyright © 2018 chaoxi科技有限公司. All rights reserved.
//
//不可变数组防止越界,可变数组在NSMutableArray+Swizzling里处理
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (DWBSafe)

@end

NS_ASSUME_NONNULL_END
