//
//  NSNull+safe.m
//  NSNullDemo
//
//  Created by chaoxi on 2017/4/16.
//  Copyright © 2017年 chaoxi科技有限公司. All rights reserved.
//

#import "NSNull+safe.h"

#define NullObjects @[@"",@0,@{},@[]]

@implementation NSNull (safe)
//必须返回一个方法签名不能为空
- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector {
    
    NSMethodSignature *signature = [super methodSignatureForSelector:selector];
    
    if (signature != nil) return signature;
    
    for (NSObject *object in NullObjects) {
        
        signature = [object methodSignatureForSelector:selector];
        
        if (signature) {
            //strcmp比较两个字符串，相同返回0
            //这里 @ 是指返回值为对象 id
            if (strcmp(signature.methodReturnType, "@") == 0) {
                
                signature = [[NSNull null] methodSignatureForSelector:@selector(__returnNil)];
                NSLog(@"处理：%@", NSStringFromSelector(selector));

            }
            break;
        }
    }
    
    return signature;
}
//消息转发的最后一步
- (void)forwardInvocation:(NSInvocation *)anInvocation {
    //如果返回值是对象 设置方法为__returnNil
    if (strcmp(anInvocation.methodSignature.methodReturnType, "@") == 0) {
        //设置方法为 __returnNil
        anInvocation.selector = @selector(__returnNil);
        [anInvocation invokeWithTarget:self];
        return;
    }
    //遍历 查看那个@"",@0,@{},@[] 那个响应了selector，然后丢给它去执行
    for (NSObject *object in NullObjects) {
        
        if ([object respondsToSelector:anInvocation.selector]) {
            
            [anInvocation invokeWithTarget:object];
            return;
        }
    }
    //抛出异常
    [self doesNotRecognizeSelector:anInvocation.selector];
}

- (id)__returnNil {
    return nil;
}

@end
