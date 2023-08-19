//
//  CXShowInfoView.h
//  AiHenDeChaoXi
//
//  Created by 爱恨的潮汐 on 2018/4/20.
//  Copyright © 2018年 潮汐科技有限公司. All rights reserved.
//

//无按钮提示框，自动消失
#import <UIKit/UIKit.h>

@interface AlertCXShowInfo : UIView

/**
 自定义带图标的弹窗，弹窗后2s自动消失

 @param title 标题
 @param message 内容
 @param type 类型，成功还是失败，用来控制图标 -1为默认
 */
+ (void)showAletCXInfoTitle:(NSString*)title Message:(NSString *)message Type:(NSInteger)type;
@end
