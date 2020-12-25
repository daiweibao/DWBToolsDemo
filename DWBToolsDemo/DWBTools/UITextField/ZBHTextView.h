//
//  ZBHTextView.h
//
//  Created by chaoxi on 16/1/22.
//  Copyright © 2016年 chaoxi科技有限公司. All rights reserved.
//
//UITextView带占位符
#import <UIKit/UIKit.h>

@interface ZBHTextView : UITextView
/** 占位文字 */
@property(nonatomic, copy) NSString *placeholder;
/** 占位文字颜色 */
@property(nonatomic, strong) UIColor *placeholderColor;

@end
