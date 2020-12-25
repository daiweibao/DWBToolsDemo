//
//  NSArray+DWBSafe.m
//  DWBToolsDemo
//
//  Created by chaoxi on 2018/10/26.
//  Copyright © 2018 chaoxi科技有限公司. All rights reserved.
//

#import "NSArray+DWBSafe.h"
#import <objc/runtime.h>
@implementation NSArray (DWBSafe)
+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        //ioS11以下不能用
        if (ios11_0orLater) {
            //（1）不可变数组的处理
            Class clsI = NSClassFromString(@"__NSArrayI");
            
            Method method1 = class_getInstanceMethod(clsI, @selector(objectAtIndexedSubscript:));
            Method method2 = class_getInstanceMethod(clsI, @selector(yye_objectAtIndexedSubscript:));
            method_exchangeImplementations(method1, method2);
            
            Method method3 = class_getInstanceMethod(clsI, @selector(objectAtIndex:));
            Method method4 = class_getInstanceMethod(clsI, @selector(yye_objectAtIndex:));
            method_exchangeImplementations(method3, method4);
            
            //公共的
            Class clsSingleI = NSClassFromString(@"__NSSingleObjectArrayI");
            Method method5 = class_getInstanceMethod(clsSingleI, @selector(objectAtIndex:));
            Method method6 = class_getInstanceMethod(clsSingleI, @selector(yyeSingle_objectAtIndex:));
            method_exchangeImplementations(method5, method6);
            
        }
        
    
    });
}

- (id)yye_objectAtIndexedSubscript:(NSUInteger)index{
    if(index>=self.count) return self.lastObject;
    
    return [self yye_objectAtIndexedSubscript:index];
}

- (id)yye_objectAtIndex:(NSUInteger)index{
    if(index>=self.count) return self.lastObject;
    
    return [self yye_objectAtIndex:index];
}

- (id)yyeSingle_objectAtIndex:(NSUInteger)index{
    if(index>=self.count){
        return self.lastObject;
    }
    
    return [self yyeSingle_objectAtIndex:index];
}

/*
 
 由于NSArray和NSMutableArray类簇的特殊性，其真身并是__NSSingleObjectArrayI（不可变数组只有一个对象）， __NSArrayI（不可变数组多个对象），__NSArrayM（可变数组）。不同的调用方法锁最终地调用方法也不同，有objectAtIndex：和objectAtIndexedSubscript：
 
 NSArray *array = @[@1];
 [array objectAtIndex:4];
 array[4];
 
 可变数组地代码我就不贴出来了，只要把__NSArrayI更换为__NSArrayM就好。同时测试通过放在release下生效，避免给开发带来困难，如果想要排查问题可以把数组信息上传服务器，帮助定位问题。

 */
@end
