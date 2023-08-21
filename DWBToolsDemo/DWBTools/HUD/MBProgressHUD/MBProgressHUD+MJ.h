//
//  MBProgressHUD+MJ.h
//
//  Created by mj on 13-4-18.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "MBProgressHUD.h"
//上下都能显示的提示框，类似安卓
#import "DWBToast.h"
//转圈圈加载刷新控件
#import "LoadingCircleHUD.h"

@interface MBProgressHUD (MJ)

//MBProgressHUD的扩展类
//带图片成功
//+ (void)showSuccess:(NSString *)success toView:(UIView *)view;
////带图片失败
//+ (void)showError:(NSString *)error toView:(UIView *)view;
////纯文字提示
//+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;
//默认
+ (void)showSuccess:(NSString *)success;
//默认
+ (void)showError:(NSString *)error;
//带图片的提示信息
+ (void)showInfo:(NSString *)info;
#pragma mark 显示没网提示
+ (void)showNoNetwork:(NSString *)noNetwork;
//展示纯文字消息
+ (MBProgressHUD *)showMessage:(NSString *)message;

///展示加载中，不会自动影藏
+ (void)showHUDLodingStart:(NSString *)message toView:(UIView *)view;
///加载完成传入的view和showHUDLodingStart的view一样
+ (void)showHUDLodingEnd:(NSString *)message toView:(UIView *)view;
//圆形进度条
+ (void)showHUDMBProgress:(float)progress title:(NSString*)title toView:(UIView *)view;

///影藏指定view上的
+ (void)hideHUDForView:(UIView *)view;

////加载中（用法）
//[MBProgressHUD showHUDLodingStart:@"加载中..." toView:self.view];
//[MBProgressHUD showHUDLodingEnd:@"加载完成" toView:self.view];
////失败时影藏加载中
//[MBProgressHUD hideHUDForView:self.view];

@end
