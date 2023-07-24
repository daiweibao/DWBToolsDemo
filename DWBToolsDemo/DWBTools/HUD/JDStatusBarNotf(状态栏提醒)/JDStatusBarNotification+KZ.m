//
//  JDStatusBarNotification+KZ.m
//  XiaoYuanSheQu
//
//  Created by 戴维保 on 16/9/6.
//  Copyright © 2016年 北京嗅美科技有限公司. All rights reserved.
//

#import "JDStatusBarNotification+KZ.h"
//适配iPhoneX用的状态栏
#import "SDDrowNoticeView.h"

@implementation JDStatusBarNotification (KZ)

//状态栏展示信息(分享成功与失败)
+ (void)showJDStatusBarMy:(NSString *)message{
    if ([NSString isNULL:message]) {
        //判空
        return;
    }
    if (iPhoneX) {
        //适配iPhoneX用的状态栏提醒
         [SDDrowNoticeView showJDStatusBarMySelfIPhoneX:message];
    }else{
        //顶部状态栏提醒--JDStatusBarStyleDark 样式
        //    JDStatusBarStyleDark，黑色
        [JDStatusBarNotification showWithStatus:message dismissAfter:2 styleName:JDStatusBarStyleDark];
        
    }
}

@end
