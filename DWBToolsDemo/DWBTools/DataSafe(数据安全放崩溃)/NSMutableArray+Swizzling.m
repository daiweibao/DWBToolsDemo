//
//  NSMutableArray+Swizzling.m
//  PaopaoRunning
//
//  Created by zwj on 2018/4/2.
//  Copyright © 2018年 HealthPao. All rights reserved.
//

#import "NSMutableArray+Swizzling.h"
#import <objc/runtime.h>

@implementation NSObject (Swizzling)

+ (void)swizzleSelector:(SEL)originalSelector withSwizzledSelector:(SEL)swizzledSelector
{
    Class class = [self class];
    
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    // 若已经存在，则添加会失败
    BOOL didAddMethod = class_addMethod(class,originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    // 若原来的方法并不存在，则添加即可
    if (didAddMethod) {
        class_replaceMethod(class,swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

@end


@implementation NSMutableArray (Swizzling)
//__NSArrayM代表可变数组
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleSelector:@selector(removeObject:)withSwizzledSelector:@selector(safeRemoveObject:)];
        [objc_getClass("__NSArrayM") swizzleSelector:@selector(addObject:) withSwizzledSelector:@selector(safeAddObject:)];
        [objc_getClass("__NSArrayM") swizzleSelector:@selector(removeObjectAtIndex:) withSwizzledSelector:@selector(safeRemoveObjectAtIndex:)];
        [objc_getClass("__NSArrayM") swizzleSelector:@selector(insertObject:atIndex:) withSwizzledSelector:@selector(safeInsertObject:atIndex:)];
        [objc_getClass("__NSPlaceholderArray") swizzleSelector:@selector(initWithObjects:count:) withSwizzledSelector:@selector(safeInitWithObjects:count:)];
        [objc_getClass("__NSArrayM") swizzleSelector:@selector(objectAtIndex:) withSwizzledSelector:@selector(safeObjectAtIndex:)];
        
        
        //拦截可变数组越界崩溃（非可变数组在另一个类里处理），如
//          NSMutableArray * Marray = [NSMutableArray arrayWithObject:@"1"];
//          NSString * str = Marray[100];
        Class clsM = NSClassFromString(@"__NSArrayM");
        Method method1_M = class_getInstanceMethod(clsM, @selector(objectAtIndexedSubscript:));
        Method method2_M = class_getInstanceMethod(clsM, @selector(yye_objectAtIndexedSubscript:));
        method_exchangeImplementations(method1_M, method2_M);
       
});
}

- (instancetype)safeInitWithObjects:(const id _Nonnull __unsafe_unretained *)objects count:(NSUInteger)cnt {
    BOOL hasNilObject = NO;
    for (NSUInteger i = 0; i < cnt; i++) {
        if ([objects[i] isKindOfClass:[NSArray class]]) {
            NSLog(@"%@", objects[i]);
            
        } if (objects[i] == nil) {
            hasNilObject = YES;
//            NSLog(@"%s object at index %lu is nil, it will be filtered", __FUNCTION__, i);
            //#if DEBUG
            // // 如果可以对数组中为nil的元素信息打印出来，增加更容 易读懂的日志信息，这对于我们改bug就好定位多了
            // NSString *errorMsg = [NSString stringWithFormat:@"数组元素不能为nil，其index为: %lu", i];
            // NSAssert(objects[i] != nil, errorMsg);
            //#endif
    }
}
// 因为有值为nil的元素，那么我们可以过滤掉值为nil的元素
if (hasNilObject) {
        id __unsafe_unretained newObjects[cnt];
        NSUInteger index = 0;
        for (NSUInteger i = 0; i < cnt; ++i) {
            if (objects[i] != nil) {
                newObjects[index++] = objects[i];
                
            }else{
#pragma mark ==============数组元素判空赋值===================
                //数组元素判空，如果为nil
                 id obj = [NSNull null];
                newObjects[index++] = obj;
            }
        }
        return [self safeInitWithObjects:newObjects count:index];
    }
    return [self safeInitWithObjects:objects count:cnt];
}
    
    
  
    
- (void)safeAddObject:(id)obj {
    if (obj == nil) {
        NSLog(@"%s can add nil object into NSMutableArray", __FUNCTION__);
    } else {
        [self safeAddObject:obj];
    }
}
        
- (void)safeRemoveObject:(id)obj {
    if (obj == nil) {
        NSLog(@"%s call -removeObject:, but argument obj is nil", __FUNCTION__);
        return;
    }
    [self safeRemoveObject:obj];
}
        
        
- (void)safeInsertObject:(id)anObject atIndex:(NSUInteger)index {
    
    if (anObject == nil) {
        NSLog(@"%s can't insert nil into NSMutableArray", __FUNCTION__);
        
    } else if (index > self.count) {
        NSLog(@"%s index is invalid", __FUNCTION__);
        
    } else {
        [self safeInsertObject:anObject atIndex:index];
        
    }
    
}

- (id)safeObjectAtIndex:(NSUInteger)index {
    if (self.count == 0) {
        NSLog(@"%s can't get any object from an empty array", __FUNCTION__);
        return nil;
        
    } if (index >= self.count) {
        NSLog(@"%s index out of bounds in array", __FUNCTION__);
        return nil;
        
    }
    return [self safeObjectAtIndex:index];
    
}

- (void)safeRemoveObjectAtIndex:(NSUInteger)index {
    if (self.count <= 0) {
        NSLog(@"%s can't get any object from an empty array", __FUNCTION__);
        return;
        
    } if (index >= self.count) {
        NSLog(@"%s index out of bound", __FUNCTION__);
        return;
        
    }
    [self safeRemoveObjectAtIndex:index];
    
}


//拦截可变数组越界崩溃
- (id)yye_objectAtIndexedSubscript:(NSUInteger)index{
    if(index>=self.count) return self.lastObject;
    
    return [self yye_objectAtIndexedSubscript:index];
}


      

@end
