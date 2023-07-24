//
//  SVProgressHUD+KZ.m
//  XiaoYuanSheQu
//
//  Created by 戴维保 on 16/9/6.
//  Copyright © 2016年 北京嗅美科技有限公司. All rights reserved.
//

#import "SVProgressHUD+KZ.h"

@implementation SVProgressHUD (KZ)

//加载中(不允许用户交互)
+ (void)showSVPLodingStart:(NSString *)message{
//设置显示的消息
    [SVProgressHUD showWithStatus:message];
//设置背景色==黑色
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
//不允许用户交互
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
    
}

//加载中(允许用户交互)
+ (void)showSVPLodingUseCanActionStart:(NSString *)message{
    //设置显示的消息
    [SVProgressHUD showWithStatus:message];
    //设置背景色==黑色
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    //允许用户交互
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    
}

+(void)showSVPSuccess{
    //设置背景色==黑色
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD showImage:[UIImage imageNamed:[NSString stringWithFormat:@"SVProgressHUD.bundle/%@",@"DWBSuccess"]] status:@"成功"];
//    [SVProgressHUD dismissWithDelay:5.5];
}

@end
