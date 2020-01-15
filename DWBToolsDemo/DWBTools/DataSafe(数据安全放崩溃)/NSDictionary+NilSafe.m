//
//  NSDictionary+NilSafe.m
//  NSDictionary-NilSafe
//
//  Created by 戴维保 on 6/22/16.
//  Copyright © 2016 Glow Inc. All rights reserved.
//

#import <objc/runtime.h>
#import "NSDictionary+NilSafe.h"

@implementation NSObject (Swizzling)

+ (BOOL)gl_swizzleMethod:(SEL)origSel withMethod:(SEL)altSel {
    Method origMethod = class_getInstanceMethod(self, origSel);
    Method altMethod = class_getInstanceMethod(self, altSel);
    if (!origMethod || !altMethod) {
        return NO;
    }
    class_addMethod(self,
                    origSel,
                    class_getMethodImplementation(self, origSel),
                    method_getTypeEncoding(origMethod));
    class_addMethod(self,
                    altSel,
                    class_getMethodImplementation(self, altSel),
                    method_getTypeEncoding(altMethod));
    method_exchangeImplementations(class_getInstanceMethod(self, origSel),
                                   class_getInstanceMethod(self, altSel));
    return YES;
}

+ (BOOL)gl_swizzleClassMethod:(SEL)origSel withMethod:(SEL)altSel {
    return [object_getClass((id)self) gl_swizzleMethod:origSel withMethod:altSel];
}

@end

@implementation NSDictionary (NilSafe)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self gl_swizzleMethod:@selector(initWithObjects:forKeys:count:) withMethod:@selector(gl_initWithObjects:forKeys:count:)];
        [self gl_swizzleClassMethod:@selector(dictionaryWithObjects:forKeys:count:) withMethod:@selector(gl_dictionaryWithObjects:forKeys:count:)];
    });
}

+ (instancetype)gl_dictionaryWithObjects:(const id [])objects forKeys:(const id<NSCopying> [])keys count:(NSUInteger)cnt {
    id safeObjects[cnt];
    id safeKeys[cnt];
    NSUInteger j = 0;
    for (NSUInteger i = 0; i < cnt; i++) {
        id key = keys[i];
        id obj = objects[i];
//        if (!key || !obj) {
//            continue;
//        }
        
        
        if (!key) {
            continue;
        }
        if (!obj) {
            //            obj = [NSNull null];
            obj = @"";//如果为空就返回@"";
            //            NSLog(@"字典value为空 %s",__FUNCTION__);
        }
        
        safeKeys[j] = key;
        safeObjects[j] = obj;
        j++;
    }
    return [self gl_dictionaryWithObjects:safeObjects forKeys:safeKeys count:j];
}

- (instancetype)gl_initWithObjects:(const id [])objects forKeys:(const id<NSCopying> [])keys count:(NSUInteger)cnt {
    id safeObjects[cnt];
    id safeKeys[cnt];
    NSUInteger j = 0;
    for (NSUInteger i = 0; i < cnt; i++) {
        id key = keys[i];
        id obj = objects[i];
//        if (!key || !obj) {
//            continue;
//        }
//        if (!obj) {
//            obj = [NSNull null];
//        }
        
        
        
        if (!key) {
            continue;
        }
        if (!obj) {
            //            obj = [NSNull null];
            obj = @"";//如果为空就返回@"";
            //            NSLog(@"字典value为空 %s",__FUNCTION__);
        }
        
        safeKeys[j] = key;
        safeObjects[j] = obj;
        j++;
    }
    return [self gl_initWithObjects:safeObjects forKeys:safeKeys count:j];
}

@end

@implementation NSMutableDictionary (NilSafe)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = NSClassFromString(@"__NSDictionaryM");
        [class gl_swizzleMethod:@selector(setObject:forKey:) withMethod:@selector(gl_setObject:forKey:)];
        [class gl_swizzleMethod:@selector(setObject:forKeyedSubscript:) withMethod:@selector(gl_setObject:forKeyedSubscript:)];
    });
}

- (void)gl_setObject:(id)anObject forKey:(id<NSCopying>)aKey {
//    if (!aKey || !anObject) {
//        return;
//    }
    
    if (!aKey) {
         return;
    }
    if (!anObject) {
        //            obj = [NSNull null];
        anObject = @"";//如果为空就返回@"";
        //            NSLog(@"字典value为空 %s",__FUNCTION__);
    }
    
    
    [self gl_setObject:anObject forKey:aKey];
}

- (void)gl_setObject:(id)obj forKeyedSubscript:(id<NSCopying>)key {
//    if (!key || !obj) {
//        return;
//    }
    
    if (!key) {
        return;
    }
    if (!obj) {
        //            obj = [NSNull null];
        obj = @"";//如果为空就返回@"";
        //            NSLog(@"字典value为空 %s",__FUNCTION__);
    }
    
    
    [self gl_setObject:obj forKeyedSubscript:key];
}

@end
