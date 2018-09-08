//
//  MBProgressHUD+MJ.m
//
//  Created by mj on 13-4-18.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "MBProgressHUD+MJ.h"

@implementation MBProgressHUD (MJ)
#pragma mark 显示信息
+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view
{
    
    if ([NSString isNULL:text]) {
        text = @"";
    }
    
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    
    hud.detailsLabelText = text;
    hud.detailsLabelFont = [UIFont systemFontOfSize:17.0];
    // 设置图片
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", icon]]];
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    //背景颜色
    hud.color = [UIColor colorWithRed:0.259 green:0.263 blue:0.271 alpha:1.000];
    //透明度
    hud.alpha = 0.9;
    //变大动画
    hud.animationType = MBProgressHUDAnimationFade;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    //不要挡住用户其他操作
    hud.userInteractionEnabled = NO;
    
    // 1.5秒之后再消失
    [hud hide:YES afterDelay:1.5];
    
}

#pragma mark 显示错误信息
+ (void)showError:(NSString *)error toView:(UIView *)view{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self show:error icon:@"bigerror.png" view:view];
    });
}
//icon-info
#pragma mark 显示成功信息
+ (void)showSuccess:(NSString *)success toView:(UIView *)view
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self show:success icon:@"DWBSuccess.png" view:view];
    });
}

#pragma mark 显示提示信息
+ (void)showInfo:(NSString *)info
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self show:info icon:@"icon-info.png" view:nil];
    });
}

#pragma mark 显示没网提示
+ (void)showNoNetwork:(NSString *)noNetwork
{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self show:noNetwork icon:@"DWBError.png" view:nil];
    });
    
}

#pragma mark 显示一些信息==纯文字提示
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view {
    
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    //变大动画
    hud.animationType = MBProgressHUDAnimationFade;
    //纯文本
    hud.mode = MBProgressHUDModeText;
    
    //提示的内容detailsLabelText 多行显示 labelText 只显示一行
    hud.detailsLabelText = message;
    //字体大小
    hud.detailsLabelFont = [UIFont systemFontOfSize:17.0];
    //背景颜色
    hud.color = [UIColor colorWithRed:0.145 green:0.149 blue:0.149 alpha:1.000];
    //透明度
    hud.alpha = 0.9;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    //不要挡住用户其他操作
    hud.userInteractionEnabled = NO;
    // YES代表需要蒙版效果
    //    hud.dimBackground = YES;
    //多少时间后影藏
    [hud hide:YES afterDelay:1.5];
    
    return hud;
}


+ (void)showSuccess:(NSString *)success
{
    [self showSuccess:success toView:nil];
}

+ (void)showError:(NSString *)error
{
    [self showError:error toView:nil];
}

+ (MBProgressHUD *)showMessage:(NSString *)message
{
    return [self showMessage:message toView:nil];
}

+ (void)hideHUDForView:(UIView *)view
{
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    [self hideHUDForView:view animated:YES];
}

//影藏keyWindows上的
+ (void)hideHUD
{
    [self hideHUDForView:[UIApplication sharedApplication].keyWindow];
}


//展示加载中，不会自动影藏
+ (void)showHUDLodingStart:(NSString *)message toView:(UIView *)view{
    
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    
    MBProgressHUD * hudLoding = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    hudLoding.animationType = MBProgressHUDAnimationFade;
    //背景颜色
    hudLoding.color = [UIColor colorWithRed:0.145 green:0.149 blue:0.149 alpha:1.000];
    //透明度
    hudLoding.alpha = 0.9;
    
    [hudLoding setLabelText:message];
}

//加载完成
+ (void)showHUDLodingEnd:(NSString *)message toView:(UIView *)view{
    //先影藏加载中
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    [self hideHUDForView:view animated:NO];
    //在创建加载完成
    MBProgressHUD * hudLoding = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hudLoding.animationType = MBProgressHUDAnimationFade;
    hudLoding.mode = MBProgressHUDModeText;
    //背景颜色
    hudLoding.color = [UIColor colorWithRed:0.145 green:0.149 blue:0.149 alpha:1.000];
    //透明度
    hudLoding.alpha = 0.9;
    
    hudLoding.detailsLabelText = message;
    hudLoding.detailsLabelFont = [UIFont systemFontOfSize:17.0];
    //不要挡住用户其他操作
    hudLoding.userInteractionEnabled = NO;
    
    [hudLoding hide:YES afterDelay:0.5];
    // 隐藏时候从父控件中移除
    hudLoding.removeFromSuperViewOnHide = YES;
    
    
}


//圆形进度条
+ (void)showHUDMBProgress:(float)progress title:(NSString*)title toView:(UIView *)view{
    
    //先影藏其他HUD
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    [self hideHUDForView:view animated:NO];
    //创建
    MBProgressHUD * hudLoding = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hudLoding.animationType = MBProgressHUDAnimationFade;
    hudLoding.alpha = 0.9;
    hudLoding.color = [UIColor colorWithRed:0.145 green:0.149 blue:0.149 alpha:1.000];
    dispatch_async(dispatch_get_main_queue(), ^{
        //加载中的环形进度
        hudLoding.mode = MBProgressHUDModeAnnularDeterminate;
        hudLoding.progress = progress;
        [hudLoding setLabelText:[NSString stringWithFormat:@"%@%.1f%%",title,100.0 * progress]];
        
    });
}


@end
