//
//  UITextField+CSIILimit.h
//  LZMobileBank
//
//  Created by LzBank on 2021/5/20.
//  Copyright © 2021 Alibaba. All rights reserved.
//
//时时监听键盘输入内容
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^LimitBlock)(NSString *text);

@interface UITextField (CSIILimit)
@property (nonatomic , copy)LimitBlock limitBlock;

///添加时时监听输入框输入内容，并回调限制内容输入长度
- (void)addTextFieldLengthLimit:(LimitBlock)limit;

@end


NS_ASSUME_NONNULL_END

/**
 方法一：
 //使用案例，比如限制手机号只能输入11位
 [self.phoneTextField addTextFieldLengthLimit:^(NSString * _Nonnull text) {
     //限制长度不能超过6位
     if (self.phoneTextField.text.length > 11) {
         self.phoneTextField.text = [self.phoneTextField.text substringToIndex:11];
     }
 }];
 
 
 方法二：通知
 //时时监听键盘
 [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(infoAction:) name:UITextFieldTextDidChangeNotification object:nil];
 
 //时时监听键盘限制手机号码输入长度为11位
 - (void)infoAction:(NSNotification*)notf{
 //    UITextField * textField = notf.object;
     //限制手机号最多11位
     if (self.phoneTextField.text.length > 11) {
         self.phoneTextField.text = [self.phoneTextField.text substringToIndex:11];
     }
 }
 
 */
