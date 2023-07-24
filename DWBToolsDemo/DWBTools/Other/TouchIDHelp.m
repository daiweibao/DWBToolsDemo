//
//  TouchIDHelp.m
//  AiHenDeChaoXi
//
//  Created by 戴维保 on 2018/3/22.
//  Copyright © 2018年 北京嗅美科技有限公司. All rights reserved.
//

#import "TouchIDHelp.h"
#import <LocalAuthentication/LocalAuthentication.h>

@interface TouchIDHelp()
//指纹状态回调，类内部方法
@property(nonatomic,copy)void (^TouchstateNei)(NSString * stateNei);
@end

@implementation TouchIDHelp

#pragma mark =========== 判断是否有指纹功能=============
+(BOOL)isHaveTouchID{
    //初始化
    if (ios8orLater) {
        //本地认证上下文联系对象，每次使用指纹识别验证功能都要重新初始化，否则会一直显示验证成功。
        LAContext * context = [[LAContext alloc] init];
        NSError * error = nil;
        //验证是否具有指纹认证功能
        BOOL canEvaluatePolicy = [context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error];
        if (error) {
            NSLog(@"%@", error.localizedDescription);
        }
        if (canEvaluatePolicy) {
            //        NSLog(@"有指纹认证功能");
            return YES;
        }else{
            return NO;
        }
    }else{
        return NO;
    }
}


#pragma mark =========== 指纹识别结果=============
//回调指纹验证结果
+(void)TouchIDWithState:(void (^)(NSString * state))touchState{
    //初始化
    TouchIDHelp * touch = [[TouchIDHelp alloc]init];
    [touch setTouchstateNei:^(NSString *stateNei) {
        dispatch_async(dispatch_get_main_queue(), ^{
            //回调认证结果
            if (touchState) {
                touchState(stateNei);
            }
            
        });
    }];
    //初始化
    if (ios8orLater) {
        if (ios9orLater) {
            //调用方法iOS9
            [touch TouchIDiOS9];
        }else{
            //调用方法iOS8
            [touch TouchIDiOS8];
        }
        
    }else{
        //iOS8开始才有指纹识别
        [DWBToast showCenterWithText:@"系统版本不支持TouchID"];
    }
}


//指纹识别是iPhone5s iOS8.0之后推出的功能，需要硬件以及软件的支持。
#pragma mark ===============iOS9以上指纹识别--S--------
//iOS9指纹识别，第3次、第5次输错都会弹出系统密码
-(void)TouchIDiOS9{
    if (ios9orLater) {
        //本地认证上下文联系对象，每次使用指纹识别验证功能都要重新初始化，否则会一直显示验证成功。
        LAContext * context = [[LAContext alloc] init];
        NSError * error = nil;
        //验证是否具有指纹认证功能,iOS8不能用
        BOOL canEvaluatePolicy = [context canEvaluatePolicy:LAPolicyDeviceOwnerAuthentication error:&error];
        if (error) {
            NSLog(@"%@", error.localizedDescription);
        }
        if (canEvaluatePolicy) {
//            NSLog(@"有指纹认证功能");
            // 指纹认证错误后的第二个按钮文字（不写默认为“输入密码”）
            context.localizedFallbackTitle = @"输入密码";
            [context evaluatePolicy:LAPolicyDeviceOwnerAuthentication localizedReason:@"验证指纹以登陆你的账号" reply:^(BOOL success, NSError *error) {
                // 切换到主线程
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (success) {
//                        NSLog(@"指纹验证成功");
                        //成功回调
                        if (self.TouchstateNei) {
                            self.TouchstateNei(@"成功");
                        }
                    } else {
                        NSLog(@"指纹认证失败，%@",error.description);
                        NSLog(@"%ld", (long)error.code);
                        //失败回调
                        if (self.TouchstateNei) {
                            self.TouchstateNei(@"失败");
                        }
                        /*
                        // 错误码 error.code
                        switch (error.code) {
                                
                            case LAErrorUserCancel: {
                                NSLog(@"用户取消验证Touch ID");// -2 在TouchID对话框中点击了取消按钮或者按了home键
                                //回调
                                if (self.TouchstateNei) {
                                    self.TouchstateNei(@"失败");
                                }
                            }
                                break;
                                
                            case LAErrorUserFallback: {
                                NSLog(@"用户选择输入密码"); // -3 在TouchID对话框中点击了输入密码按钮
                            }
                                break;
                                
                            case LAErrorSystemCancel: { NSLog(@"取消授权，如其他应用切入，用户自主"); // -4 TouchID对话框被系统取消，例如按下电源键
                            }
                                break;
                                
                            case LAErrorPasscodeNotSet: {
                                NSLog(@"设备系统未设置密码"); // -5
                            }
                                break;
                                
                            case LAErrorTouchIDNotAvailable: {
                                
                                NSLog(@"设备未设置Touch ID"); // -6
                            }
                                break;
                                
                            case LAErrorTouchIDNotEnrolled:  {
                                
                                NSLog(@"用户未录入指纹"); // -7
                            }
                                break;
                                
                            case LAErrorAppCancel: {
                                NSLog(@"用户不能控制情况下APP被挂起"); // -9
                            }
                                break;
                                
                            case LAErrorInvalidContext: {
                                
                                NSLog(@"LAContext传递给这个调用之前已经失效"); // -10
                            }
                                break;
                                
                            default: {
                                NSLog(@"其他情况");
                            }
                                break;
                        }
                         */
                    }
                });
            }];
            
        } else {
//            NSLog(@"无指纹认证功能");
            [DWBToast showCenterWithText:@"无指纹认证功能"];
        }
    }
}

#pragma mark ===============iOS9以上指纹识别--E--------



#pragma mark ===============iOS8指纹识别--S--------
//iOS8指纹识别,iOS8输入5次指纹，第6次弹出系统密码。
-(void)TouchIDiOS8{
    //本地认证上下文联系对象，每次使用指纹识别验证功能都要重新初始化，否则会一直显示验证成功。
    LAContext * context = [[LAContext alloc] init];
    NSError * error = nil;
    //验证是否具有指纹认证功能
    BOOL canEvaluatePolicy = [context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error];
    if (error) {
        NSLog(@"%@", error.localizedDescription);
    }
    if (canEvaluatePolicy) {
        NSLog(@"有指纹认证功能");
        // 指纹认证错误后的第二个按钮文字（不写默认为“输入密码”）
        context.localizedFallbackTitle = @"输入密码";
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"验证指纹以确认您的身份" reply:^(BOOL success, NSError *error) {
            // 切换到主线程
            dispatch_async(dispatch_get_main_queue(), ^{
                if (success) {
//                    NSLog(@"指纹验证成功");
                    //成功回调
                    if (self.TouchstateNei) {
                        self.TouchstateNei(@"成功");
                    }
                } else {
                    NSLog(@"指纹认证失败，%@",error.description);
                    NSLog(@"%ld", (long)error.code);
                    
                    //失败回调
                    if (self.TouchstateNei) {
                        self.TouchstateNei(@"失败");
                    }
                    
                    /*
                    // 错误码 error.code
                    switch (error.code) {
                        case LAErrorAuthenticationFailed:{
                            NSLog(@"授权失败"); // -1 连续三次指纹识别错误
                        }
                            break;
                            
                        case LAErrorUserCancel: {
                            NSLog(@"--用户取消验证Touch ID");// -2 在TouchID对话框中点击了取消按钮或者按了home键
                        }
                            break;
                            
                        case LAErrorUserFallback: {
                            
                            NSLog(@"用户选择输入密码"); // -3 在TouchID对话框中点击了输入密码按钮,在这里可以做一些自定义的操作。
                        }
                            break;
                            
                        case LAErrorSystemCancel: { NSLog(@"取消授权，如其他应用切入，用户自主"); // -4 TouchID对话框被系统取消，例如按下电源键
                        }
                            break;
                            
                        case LAErrorPasscodeNotSet: {
                            NSLog(@"设备系统未设置密码"); // -5
                        }
                            break;
                            
                        case LAErrorTouchIDNotAvailable: {
                            
                            NSLog(@"设备未设置Touch ID"); // -6
                        }
                            break;
                            
                        case LAErrorTouchIDNotEnrolled:  {
                            
                            NSLog(@"用户未录入指纹"); // -7
                        }
                            break;
                        default: {
                            NSLog(@"其他情况");
                        }
                            break;
                    }
                     */
                }
            });
        }];
        
    } else {
//        NSLog(@"无指纹认证功能");
        [DWBToast showCenterWithText:@"无指纹认证功能"];
    }
    
}

#pragma mark ===============iOS8指纹识别--E--------
/*
 LAPolicyDeviceOwnerAuthentication
 
 生物指纹识别或系统密码验证。注意这个policy是9.0的API，对于8.0系统的手机不能使用。如果TOUCH ID 可用，且已经录入指纹，则优先调用指纹验证。其次是调用系统密码验证，如果没有开启设备密码，则不可以使用这种验证方式。指纹识别验证失败三次将自动弹出设备密码输入框，如果不进行密码输入。再次进来还可以有两次机会验证指纹，如果都失败则TOUCH ID被锁住。以后也只能弹出设备密码输入框。补充:值得注意的是在iOS9系统中，前三次验证失败会自动弹出密码验证框，后两次验证失败后不会自动弹出密码验证框。而在iOS 10系统中，前三次验证失败或者后两次验证失败，都会自动弹出密码验证框。
 
 作者：C己__
 链接：https://www.jianshu.com/p/3ff9d8edae8e
 來源：简书
 著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。
 */

@end
