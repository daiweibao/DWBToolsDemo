//
//  NSObject+DWBKVOCrash.m
//  DouZhuan
//
//  Created by 戴维保 on 2018/11/3.
//  Copyright © 2018 潮汐科技有限公司. All rights reserved.
//

#import "NSObject+DWBKVOCrash.h"
#import <objc/runtime.h>

@implementation NSObject (DWBKVOCrash)

+ (void)load
{
    [self switchMethod];
}

+ (void)switchMethod
{
    SEL removeSel = @selector(removeObserver:forKeyPath:);
    SEL myRemoveSel = @selector(removeDasen:forKeyPath:);
    SEL addSel = @selector(addObserver:forKeyPath:options:context:);
    SEL myaddSel = @selector(addDasen:forKeyPath:options:context:);
    
    Method systemRemoveMethod = class_getClassMethod([self class],removeSel);
    Method DasenRemoveMethod = class_getClassMethod([self class], myRemoveSel);
    Method systemAddMethod = class_getClassMethod([self class],addSel);
    Method DasenAddMethod = class_getClassMethod([self class], myaddSel);
    
    method_exchangeImplementations(systemRemoveMethod, DasenRemoveMethod);
    method_exchangeImplementations(systemAddMethod, DasenAddMethod);
}


#pragma mark - 最佳方案，利用@try @catch
// 交换后的方法--移除KVO
- (void)removeDasen:(NSObject *)observer forKeyPath:(NSString *)keyPath
{
    @try {
        [self removeDasen:observer forKeyPath:keyPath];
    } @catch (NSException *exception) {
        NSLog(@"拦截到KVO多次添加或者移除");
    }
    
}

// 交换后的方法
- (void)addDasen:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context
{
    [self addDasen:observer forKeyPath:keyPath options:options context:context];
    
}

@end
