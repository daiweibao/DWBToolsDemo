//
//  JDStatusBarNotification+KZ.h
//  XiaoYuanSheQu
//
//  Created by 戴维保 on 16/9/6.
//  Copyright © 2016年 北京嗅美科技有限公司. All rights reserved.
//

#import "JDStatusBarNotification.h"

@interface JDStatusBarNotification (KZ)

/**
 状态栏提醒，包含框架状态栏提醒和适配iPhoneX的适配

 @param message 展示的消息
 */
+ (void)showJDStatusBarMy:(NSString *)message;

@end
