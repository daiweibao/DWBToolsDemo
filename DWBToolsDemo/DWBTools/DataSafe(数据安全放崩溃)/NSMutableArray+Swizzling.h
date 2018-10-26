//
//  NSMutableArray+Swizzling.h
//  PaopaoRunning
//
//  Created by zwj on 2018/4/2.
//  Copyright © 2018年 HealthPao. All rights reserved.
//
//处理数组崩溃，和可变数组越界处理
#import <Foundation/Foundation.h>

@interface NSObject (Swizzling)

+ (void)swizzleSelector:(SEL)originalSelector withSwizzledSelector:(SEL)swizzledSelector;

@end

@interface NSMutableArray (Swizzling)

@end
