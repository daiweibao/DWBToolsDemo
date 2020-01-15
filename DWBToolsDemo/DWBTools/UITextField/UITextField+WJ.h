//
//  UITextField+WJ.h
//  SearchDemo
//
//  Created by 戴维保 on 15/9/22.
//  Copyright © 2015年 潮汐科技有限公司. All rights reserved.
//
//UITextField监听键盘删除键,textField内容为空也能监听到，系统的内容为空是监听不道的（2018年5月15日）
#import <UIKit/UIKit.h>
@protocol WJTextFieldDelegate <UITextFieldDelegate>
@optional
//监听方法
- (void)textFieldDidDeleteBackward:(UITextField *)textField;
@end
@interface UITextField (WJ)
@property (weak, nonatomic) id<WJTextFieldDelegate> delegate;
@end
/**
 *  监听删除按钮
 *  object:UITextField
 */
extern NSString * const WJTextFieldDidDeleteBackwardNotification;
