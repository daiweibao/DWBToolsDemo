//
//  CXScreenNotifHelp.m
//  aaa
//
//  Created by 季文斌 on 2023/11/7.
//  Copyright © 2023 Alibaba. All rights reserved.
//

#import "CXScreenNotifHelp.h"

@implementation CXScreenNotifHelp

+ (CXScreenNotifHelp *)sharedManager{
    static CXScreenNotifHelp * manager;//类
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[CXScreenNotifHelp alloc] init];
    });
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {        
        self.isShowAleat =NO;//默认不展示
    }
    return self;
}

#pragma mark---------截屏录屏监听 S-----------

/// 全局添加录屏和截屏监听，app启动后添加
- (void)addAllScreenNotif{
    //全局监听截屏
    [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationUserDidTakeScreenshotNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        //弹窗提示，此弹窗会关闭键盘
        if (self.isShowAleat==YES) {//判断是否展示弹窗
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"当前页面涉及隐私内容，不允许截屏" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
            [alertController addAction:okAction];
            [RootNavController presentViewController:alertController animated:YES completion:nil];
        }
    }];
    
    //全局监听录屏
    if (@available(iOS 11.0, *)) {
        [[NSNotificationCenter defaultCenter] addObserverForName:UIScreenCapturedDidChangeNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
            // 开始录屏时有弹框提示，结束录屏时就不弹框了。
            if ([UIScreen mainScreen].isCaptured==YES) {
                //开始录屏
                //弹窗提示，此弹窗会关闭键盘
                if (self.isShowAleat==YES) {//判断是否展示弹窗
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"检测到您正在录屏，为了您的账户安全，录屏文件请勿发送给他人" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
                    [alertController addAction:okAction];
                    [RootNavController presentViewController:alertController animated:YES completion:nil];
                }
            }else{
                //结束录屏
            }
        }];
    }
}

/*
//局部添加截屏、录屏通知
- (void)addScreenNotif{
    //局部监听截屏通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userDidTakeScreenshot:) name:UIApplicationUserDidTakeScreenshotNotification object:nil];
    if (@available(iOS 11.0, *)) {
        //iOS11后中新增了录屏功能
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userDidTakeScreenCaptured:) name:UIScreenCapturedDidChangeNotification object:nil];
    } else {
        // Fallback on earlier versions
    }
}
//截屏
-(void)userDidTakeScreenshot:(NSNotification *)notification{
    NSLog(@"检测到截屏");
    
}
//录屏
- (void)userDidTakeScreenCaptured:(NSNotification *)notification{
    // 开始录屏时有弹框提示，结束录屏时就不弹框了。
    if ([UIScreen mainScreen].isCaptured==YES) {
        //开始录屏
        
    }else{
        //结束录屏
    }
}

/// 移除录屏和截屏监听
/// - Parameter observer: 添加到那个观察者上：self，view或者控制器
- (void)removeScreenNotif{
    //移除截屏通知
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationUserDidTakeScreenshotNotification object:nil];
    //移除录屏通知
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIScreenCapturedDidChangeNotification object:nil];
}
*/

#pragma mark---------截屏录屏监听 E-----------


@end
