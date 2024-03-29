//
//  UILabel+RemoveNull.m
//  取出字符串中的null
//
//  Created by 爱恨的潮汐 on 2018/11/19.
//  Copyright © 2018 品创时代互联网科技（北京）有限公司. All rights reserved.
//

#import "UILabel+RemoveNull.h"
#import <objc/runtime.h>

@implementation UILabel (RemoveNull)
+ (void)load
{
    [super load];
    Method method = class_getInstanceMethod([self class], @selector(setText:));
    Method removeMethod = class_getInstanceMethod([self class], @selector(removeNullSetText:));
    method_exchangeImplementations(method, removeMethod);
}

- (void)removeNullSetText:(NSString *)string{
    //(1)字符串判空替换
    if ([NSString isNULL:string]) {
        string = @"";
    }
#pragma mark ----(2)字符串中包含某个字符串
    else if ([string rangeOfString:@"(null)"].location != NSNotFound){
        string = [string stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
    }
    else if ([string rangeOfString:@"<null>"].location != NSNotFound){
        string = [string stringByReplacingOccurrencesOfString:@"<null>" withString:@""];
    }
    else if ([string rangeOfString:@"nil"].location != NSNotFound){
        string = [string stringByReplacingOccurrencesOfString:@"nil" withString:@""];
    }
    else if ([string rangeOfString:@"null"].location != NSNotFound){
        string = [string stringByReplacingOccurrencesOfString:@"null" withString:@""];
    }
    
    [self removeNullSetText:string];
}
@end
