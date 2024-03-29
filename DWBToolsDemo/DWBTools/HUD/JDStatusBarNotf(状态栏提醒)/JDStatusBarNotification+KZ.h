//
//  JDStatusBarNotification+KZ.h
//  XiaoYuanSheQu
//
//  Created by 爱恨的潮汐 on 16/9/6.
//  Copyright © 2016年 潮汐科技有限公司. All rights reserved.
//

#import "JDStatusBarNotification.h"

@interface JDStatusBarNotification (KZ)

/**
 状态栏提醒，包含框架状态栏提醒和适配iPhoneX的适配

 @param message 展示的消息
 */
+ (void)showJDStatusBarMy:(NSString *)message;

@end
