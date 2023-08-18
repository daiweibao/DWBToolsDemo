//
//  UIButton+ActionButton.h
//  aaa
//
//  Created by 季文斌 on 2023/8/14.
//  Copyright © 2023 Alibaba. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^CXButtonBlock)(UIButton *button);

@interface UIButton (ActionButton)
///属性
@property(nonatomic, copy)CXButtonBlock blockBtn;


/// 封装button点击事件
/// - Parameter buttonBlock: 回调
- (void)addTapButton:(CXButtonBlock)buttonBlock;

@end

NS_ASSUME_NONNULL_END
