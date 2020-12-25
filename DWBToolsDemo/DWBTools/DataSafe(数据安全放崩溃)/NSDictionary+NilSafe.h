//
//  NSDictionary+NilSafe.h
//  NSDictionary-NilSafe
//
//  Created by  chaoxi on 6/22/16.
//  Copyright © 2016 Glow Inc. All rights reserved.
//
//字典防止崩溃（可变字典+不可变字典）与AvoidCrash冲突，有AvoidCrash时拦截无效
#import <Foundation/Foundation.h>

@interface NSDictionary (NilSafe)

@end

@interface NSMutableDictionary (NilSafe)

@end
