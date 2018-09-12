//
//  STInputBar.h
//  STEmojiKeyboard
//
//  Created by zhenlintie on 15/5/29.
//  Copyright (c) 2015年 sTeven. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBHTextView.h"
@interface STInputBar : UIView

+ (instancetype)inputBar;

@property (assign, nonatomic) BOOL fitWhenKeyboardShowOrHide;

- (void)setDidSendClicked:(void(^)(NSString *text))handler;
//带占位符的输入框
@property (strong, nonatomic) ZBHTextView *textView;
//类型
@property(nonatomic,strong)NSString * typeString;

- (void)setInputBarSizeChangedHandle:(void(^)(void))handler;
//结束编辑时
@property(nonatomic,copy)void (^endEidt)(NSString * str);
//得到键盘高度
@property(nonatomic,copy)void (^getKeyboardHeight)(CGFloat KeyBoardHeight);

//清除评论框里的内容
-(void)DeleteContent;

//发包按钮点击
@property(nonatomic,copy)void (^senderRedEnvelope)(void);

#pragma mark ================= 聊天界面 ========



@end
