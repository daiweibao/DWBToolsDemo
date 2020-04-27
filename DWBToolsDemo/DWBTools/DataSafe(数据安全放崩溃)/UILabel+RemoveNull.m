//
//  UILabel+RemoveNull.m
//  取出字符串中的null
//
//  Created by 戴维保 on 2018/11/19.
//  Copyright © 2018 潮汐科技有限公司. All rights reserved.
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
     string = [NSString stringWithFormat:@"%@",string];///必须格式化类型，否则会崩溃
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
