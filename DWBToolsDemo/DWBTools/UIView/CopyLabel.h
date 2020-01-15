//
//  CopyLabel.h
//  ZuiMeiXinNiang
//
//  Created by 戴维保 on 16/7/25.
//  Copyright © 2016年 潮汐科技有限公司. All rights reserved.
//-

#import <UIKit/UIKit.h>

@interface CopyLabelItem : NSObject

@property (nonatomic, copy, nonnull) NSString *itemContent;
@property (nonatomic, strong, nonnull) UIColor *itemColor;
@property (nonatomic, strong, nonnull) UIFont *itemFont;

@end


@interface CopyLabel : UILabel

/**  复制模块使用  */
// 复制按钮即将显示的回调(开始复制操作)
@property (nonatomic, copy, nullable) void(^willShowMenu)(void);

// 复制按钮的即将隐藏的回调(结束复制操作)
@property (nonatomic, copy, nullable) void(^willHiddenMenu)(void);

// 将“subFromIndexString”之后的内容复制到剪切板(不设置属性代表默认全部复制)
@property (nonatomic, copy, nullable) NSString *subFromIndexString;

// 将“appendString”添加在原内容之后复制到钱切板(不设置属性代表默认全部复制)
@property (nonatomic, copy, nullable) NSString *appendString;

// 是否使用该属性
@property (nonatomic, assign) BOOL isCopy;


// 字间距 自定义属性
@property (nonatomic, assign) CGFloat characterSpace;

// 行间距 自定义属性
@property (nonatomic, assign) CGFloat lineSpace;

// 需要改变字号或者字体颜色  ChangeItem的数组
@property (nonatomic, strong, nullable) NSArray *changeArray;

// 获取lab的高度
- (CGFloat)getLableHeightWithMaxWidth:(CGFloat)maxWidth;



@end
