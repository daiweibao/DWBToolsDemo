//
//  JXActionSheet.h
//  JXKit
//
//  Created by huangxiangwang on 16/1/18.
//  Copyright © 2016年 JX.Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/**
 *  操作回调，如果用户点击空白处，不选中任何button，则 clickedIndex = NSNotFound， isCancel = YES
 *  clickedIndex 从0开始， cancelButton是最后一个， titleButton不能点击
 */
typedef void(^JXSheetCompletionHanlde)(NSInteger clickedIndex, BOOL isCancel);

@interface JXActionSheet : UIView

@property (nullable, nonatomic, copy) NSString *title;
@property (nullable, nonatomic, copy) NSString *cancelTitle;
@property (nullable, nonatomic, copy) NSArray *otherTitles;
@property (nonatomic, assign) NSInteger destructiveButtonIndex; ///<从otherButton中指定某个button为destructiveButton, default = -1;

- (instancetype)initWithTitle:(nullable NSString *)title cancelTitle:(nullable NSString *)cancelTitle otherTitles:(nullable NSArray<NSString *> *)otherTitles;

@property (nonatomic, strong) UIColor *titleColor;   ///<default grayColor
@property (nonatomic, strong) UIColor *destructiveColor; ///<default redColor
@property (nonatomic, strong) UIColor *otherTitlesColor; ///<default blackColor

@property (nonatomic, strong) UIFont *titleFont; ///<default systemFont 14.
@property (nonatomic, strong) UIFont *otherTitlesFont;  ///< default systemFont 18.

- (void)showView;
- (void)dismissForCompletionHandle:(nullable JXSheetCompletionHanlde)handle;

@end

NS_ASSUME_NONNULL_END













