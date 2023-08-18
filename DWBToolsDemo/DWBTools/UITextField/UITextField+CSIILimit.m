//
//  UITextField+CSIILimit.m
//  LZMobileBank
//
//  Created by LzBank on 2021/5/20.
//  Copyright © 2021 Alibaba. All rights reserved.
//

#import "UITextField+CSIILimit.h"

#import <objc/runtime.h>

@implementation UITextField (CSIILimit)

static char limit;
//关联属性set
- (void)setLimitBlock:(LimitBlock)limitBlock {
    objc_setAssociatedObject(self, &limit, limitBlock, OBJC_ASSOCIATION_COPY);
}
//关联属性get
- (LimitBlock)limitBlock {
    return objc_getAssociatedObject(self, &limit);
}

//方法
- (void)addTextFieldLengthLimit:(LimitBlock)limit {
    //添加方法
    [self addTarget:self action:@selector(textFieldEditChanged:) forControlEvents:UIControlEventEditingChanged];
    self.limitBlock = limit;
}

//这个不是UITextField的代理方法，是添加上去的方法
- (void)textFieldEditChanged:(UITextField *)textField {
    NSString *lang = [[UIApplication sharedApplication]textInputMode].primaryLanguage; // 键盘输入模式
    // 简体中文输入，包括简体拼音，健体五笔，简体手写
    if ([lang isEqualToString:@"zh-Hans"]) {
        UITextRange *selectedRange = [textField markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            if (self.limitBlock) {
                self.limitBlock(textField.text);
            }
        }else{
            //有高亮选择的字符串，则暂不对文字进行统计和限制
        }
    }else{
        // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
        if (self.limitBlock) {
            self.limitBlock(textField.text);
        }
    }
}

@end
