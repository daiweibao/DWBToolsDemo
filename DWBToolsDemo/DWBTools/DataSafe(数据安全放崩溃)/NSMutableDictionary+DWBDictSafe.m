//
//  NSMutableDictionary+DWBDictSafe.m
//  DWBToolsDemo
//
//  Created by 戴维保 on 2018/10/24.
//  Copyright © 2018 潮汐科技有限公司. All rights reserved.
//

#import "NSMutableDictionary+DWBDictSafe.h"

@implementation NSMutableDictionary (DWBDictSafe)

//字典
+ (void)load{
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        id obj = [[self alloc]init];
        
        [obj swizzeMethod:@selector(setObject:forKey:) withMethod:@selector(safe_setObject:forKey:)];
        
        [obj swizzeMethod:@selector(removeObjectForKey:) withMethod:@selector(safe_removeObjectForKey:)];
                
    });
    
}

//交换方法
- (void)swizzeMethod:(SEL)origSelector withMethod:(SEL)newSelector

{
    
    Class class = [self class];
    
    Method originalMethod = class_getInstanceMethod(class, origSelector);//Method是运行时库的类
    
    Method swizzledMethod = class_getInstanceMethod(class, newSelector);
    
    BOOL didAddMethod = class_addMethod(class, origSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        
        class_replaceMethod(class, newSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        
    }else{
        
        method_exchangeImplementations(originalMethod, swizzledMethod);
        
    }
    
}


//可变字典添加属性
- (void)safe_setObject:(id)value forKey:(NSString* )key{
    
    if (value) {
        
        [self safe_setObject:value forKey:key];
        
    }else{
#pragma mark ==============字典元素判空赋值===================
        //字典元素判空，如果为nil
         id obj = [NSNull null];
         [self safe_setObject:obj forKey:key];
//        NSLog(@"[NSMutableDictionary setObject: forKey:%@]值不能为空;",key);
        
    }
    
}

//移除字典属性
- (void)safe_removeObjectForKey:(NSString *)key{
    
    if ([self objectForKey:key]) {
        
        [self safe_removeObjectForKey:key];
        
    }else{
        
//        NSLog(@"[NSMutableDictionary setObject: forKey:%@]值不能为空;",key);
        
    }
    
}





@end
