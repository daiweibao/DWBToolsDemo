//
//  NSMutableDictionary+DWBDictSafe.h
//  DWBToolsDemo
//
//  Created by 爱恨的潮汐 on 2018/10/24.
//  Copyright © 2018 潮汐科技有限公司. All rights reserved.
//
//此方法主要是解决【可变字典】传空值、setObject:forKey 和removeObjectForKey的崩溃，利用运行时替换原来的方法，避免程序出现崩溃。
//与AvoidCrash冲突，有AvoidCrash时拦截无效
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableDictionary (DWBDictSafe)

@end

NS_ASSUME_NONNULL_END
