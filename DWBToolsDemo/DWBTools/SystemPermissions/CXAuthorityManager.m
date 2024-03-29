//
//  CXAuthorityManager.m
//  aaa
//
//  Created by 季文斌 on 2023/8/14.
//  Copyright © 2023 Alibaba. All rights reserved.
//


#import "CXAuthorityManager.h"
//相机权限
#import <Photos/Photos.h>
//定位
#import "CXLocationQXManager.h"

//蓝牙权限
#import "RCBBluetoothQXManager.h"
//推送权限
#import <UserNotifications/UserNotifications.h>

@implementation CXAuthorityManager


/// 请求当前设备的麦克风权限【音频权限】Privacy - Microphone Usage Description
/// - Parameter completion: YES代表有权限，NO代表无权限
+ (void)requestAudioPemissionWithResult:(void(^)( BOOL granted))completion{
    //查询麦克风权限状态
    AVAuthorizationStatus authStatus =
    [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
    if (authStatus==AVAuthorizationStatusNotDetermined) {
        //未询问用户是否获取麦克风权限：AVAuthorizationStatusNotDetermined
        //请求麦克风权限
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeAudio completionHandler:^(BOOL granted) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (granted==YES) {
                    //用户同意了权限
                    completion(YES);
                } else {
                    //用户拒绝了权限
                    [CXAuthorityManager showAlertWithJumpSettingType:JumpSettingTypeMicrophone];
                    completion(NO);
                }
            });
        }];
    }else if (authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
        //未授权，家长限制：AVAuthorizationStatusRestricted
        //用户未授权：AVAuthorizationStatusDenied
        //没有权限
        [CXAuthorityManager showAlertWithJumpSettingType:JumpSettingTypeMicrophone];
        completion(NO);
    }else if(authStatus==AVAuthorizationStatusAuthorized){
        //用户已授权：AVAuthorizationStatusAuthorized
        //有权限
        completion(YES);
    }else{
        //无权限
        [CXAuthorityManager showAlertWithJumpSettingType:JumpSettingTypeMicrophone];
        completion(NO);
    }
}

/// 获取是否有麦克风权限，未询问权限不去请求权限
/// - Parameter completion: YES有权限
+ (void)getMicrophonePermissions:(void(^)( BOOL granted))completion {
    //查询麦克风权限状态
    AVAuthorizationStatus authStatus =
    [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
    if (authStatus==AVAuthorizationStatusNotDetermined) {
        //未询问用户是否获取麦克风权限：AVAuthorizationStatusNotDetermined
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(NO);
        });
        
    }else if (authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
        //未授权，家长限制：AVAuthorizationStatusRestricted
        //用户未授权：AVAuthorizationStatusDenied
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(NO);
        });
        
    }else if(authStatus==AVAuthorizationStatusAuthorized){
        //用户已授权：AVAuthorizationStatusAuthorized
        //有权限
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(YES);
        });
    }else{
        //无权限
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(NO);
        });
    }
}


/// 查询是否有相机权限，无弹窗
/// - Parameter completion: YES代表有权限，NO代表无权限
+ (void)getCameraPermissions:(void(^)( BOOL granted))completion {
    AVAuthorizationStatus AVstatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    switch (AVstatus) {
        case AVAuthorizationStatusNotDetermined:{
            NSLog(@"尚未授权");
            completion(NO);
        }
            break;
        case AVAuthorizationStatusRestricted:{
            NSLog(@"受限制，无权限");
            completion(NO);
        }
            break;
        case AVAuthorizationStatusDenied:{
            NSLog(@"用户拒绝授权");
            completion(NO);
        }
            break;
        case AVAuthorizationStatusAuthorized:{
            NSLog(@"用户已授权");
            completion(YES);
        }
            break;
    }
}

/// 请求当前设备的相机权限：Privacy - Camera Usage Description
/// - Parameter completion: YES代表有权限，NO代表无权限
+ (void)requestCameraPemissionWithResult:(void(^)( BOOL granted))completion{
    if ([AVCaptureDevice respondsToSelector:@selector(authorizationStatusForMediaType:)]){
        AVAuthorizationStatus permission =
        [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        switch (permission) {
            case AVAuthorizationStatusAuthorized:
                completion(YES);
                break;
            case AVAuthorizationStatusDenied:
            case AVAuthorizationStatusRestricted:
            {
                [CXAuthorityManager showAlertWithJumpSettingType:JumpSettingTypeCamera];
                completion(NO);
            }
                break;
            case AVAuthorizationStatusNotDetermined:
            {
                //未授权，请求相机权限
                [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (granted) {
                            completion(YES);
                        } else {
                            [CXAuthorityManager showAlertWithJumpSettingType:JumpSettingTypeCamera];
                            completion(NO);
                        }
                    });
                }];
            }
                break;
        }
    }
}


/**
请求当前设备的相册权限：Privacy - Photo Library Additions Usage Description

@param completion 回调

*/
+ (void)requestAlbumPemissionWithResult:(void(^)( BOOL granted))completion{
    //获取相册授权状态
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    switch (status) {
        case PHAuthorizationStatusNotDetermined: {
            // 用户还没有做出选择 请求获取权限
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (status == PHAuthorizationStatusDenied) {
                        // 拒绝授权
                        [CXAuthorityManager showAlertWithJumpSettingType:JumpSettingTypeAlbum];
                        completion(NO);
                    }else if (status == PHAuthorizationStatusAuthorized) {
                        // 授权成功
                        completion(YES);
                    }else if (status == PHAuthorizationStatusRestricted) {
                        // 受限制,家长控制,不允许访问
                        [CXAuthorityManager showAlertWithJumpSettingType:JumpSettingTypeAlbum];
                        completion(NO);
                    }else{
                        //
                        [CXAuthorityManager showAlertWithJumpSettingType:JumpSettingTypeAlbum];
                        completion(NO);
                    }
                });
            }];
            break;
        }
            
        case PHAuthorizationStatusRestricted:
            // 受限制,家长控制,不允许访问
        case PHAuthorizationStatusDenied:
            // 用户拒绝授权使用相册，需提醒用户到设置里面去开启app相册权限
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                [CXAuthorityManager showAlertWithJumpSettingType:JumpSettingTypeAlbum];
                completion(NO);
            });
        }
            break;
        case PHAuthorizationStatusAuthorized:
        {
          // 用户已经授权，可以使用
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(YES);
            });
            break;
        }
            
        //PHAuthorizationStatusLimited API_AVAILABLE(ios(14))
//            用户已授权此应用程序访问有限的照片库。添加PHPhotoLibraryPreventAutomaticLimitedAccessAlert = YES到应用程序的信息。防止Plist自动报警更新用户选择的有限库。使用-[phpholibrary (photosuissupport) presentLimitedLibraryPickerFromViewController:]从PhotosUI/ phphoislibrary + photosuissupport .h手动呈现有限库选择器。
             
          
            
        default:
            break;
    }
}

/// 查询是否有相册权限，无弹窗
/// - Parameter completion: YES代表有权限，NO代表无权限
+ (void)getPhotoPermissions:(void(^)( BOOL granted))completion{
    PHAuthorizationStatus photoAuthorStatus = [PHPhotoLibrary authorizationStatus];
    switch (photoAuthorStatus) {
        case PHAuthorizationStatusNotDetermined:{
            NSLog(@"尚未授权");
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(NO);
            });
        }
            break;
        case PHAuthorizationStatusRestricted:{
            NSLog(@"受限制，无权限");
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(NO);
            });
        }
            break;
        case PHAuthorizationStatusDenied:{
            NSLog(@"用户拒绝授权");
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(NO);
            });
        }
            break;
        case PHAuthorizationStatusAuthorized:{
            NSLog(@"用户已授权");
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(YES);
            });
        }
            break;
    }
}

/// 获取当前手机的蓝牙权限【手机为中心设备】
/// @param completion YES表示有权限
+ (void)requestBluetootPemissionWithResult:(void(^)( BOOL granted))completion{
    [[RCBBluetoothQXManager sharedManager] requestBluetoothWithState:^(BOOL grantedBluetoot) {
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(grantedBluetoot);
        });
    }];
}
/// 【蓝牙】获取当前手机的蓝牙权限，不弹出提示
/// @param completion YES表示有权限
+ (void)getBluetootPemissionWithResult:(void(^)( BOOL granted))completion{
    [[RCBBluetoothQXManager sharedManager] getBluetoothWithState:^(BOOL grantedBluetoot) {
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(grantedBluetoot);
        });
    }];
}



/// 请求推送授权：
/// @param completion YES有权限
+ (void)requestNotification:(void(^)( BOOL granted))completion{
    if (@available(iOS 10, *)){
        UNUserNotificationCenter * center = [UNUserNotificationCenter currentNotificationCenter];
        //center.delegate = self;
        [center requestAuthorizationWithOptions:UNAuthorizationOptionAlert | UNAuthorizationOptionBadge | UNAuthorizationOptionSound completionHandler:^(BOOL granted, NSError * _Nullable error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (granted) {
                    // 允许推送
                    completion(YES);
                    
                }else{
                    //不允许
                    //没权限
                    [CXAuthorityManager showAlertWithJumpSettingType:JumpSettingTypeNotif];
                    completion(NO);
                    
                }
            });
            
        }];
    }else if(@available(iOS 8 , *)){
        UIApplication * application = [UIApplication sharedApplication];
        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound categories:nil]];
        [application registerForRemoteNotifications];
        
    }else{
        UIApplication * application = [UIApplication sharedApplication];
        [application registerForRemoteNotificationTypes:UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound];
        [application registerForRemoteNotifications];
    }
}
/// 获取推送权限状态：iOS10以上
/// @param completion YES代表有
+ (void)getPushPermissions:(void(^)( BOOL granted))completion{
    if (@available(iOS 10 , *)){
        [[UNUserNotificationCenter currentNotificationCenter] getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (settings.authorizationStatus == UNAuthorizationStatusDenied || settings.authorizationStatus == UNAuthorizationStatusNotDetermined) {
                    // 用户未授权开启通知
                    completion(NO);
                }else if (settings.authorizationStatus == UNAuthorizationStatusAuthorized) {
                    //用户已授权开启通知
                    completion(YES);
                }
            });
        }];
    }else if (@available(iOS 8 , *)){
        UIUserNotificationSettings * setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
        if (setting.types == UIUserNotificationTypeNone) {
            // 没权限
            completion(NO);
        }else{
            //有权限
            completion(NO);
        }
    }else{
        UIRemoteNotificationType type = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
        if (type == UIUserNotificationTypeNone){
            //没权限
            completion(NO);
        }else{
            //有权限
            completion(NO);
        }
    }
}


/// 获取定位权限状态，不会弹窗
/// @param completion YES有权限
+ (void)getLocationPermissionsCompletion:(void(^)( BOOL granted))completion{
    [[CXLocationQXManager sharedManager] getLocationPermissionsCompletion:^(BOOL grantedLocation) {
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(grantedLocation);
        });
    }];
}


/// 请求定位授权，弹出授权窗
/// @param completion YES代表有权限，NO代表无权限
+ (void)requestLocationManagerWithResult:(void(^)( BOOL granted))completion{
    [[CXLocationQXManager sharedManager] getLocationhWithState:^(BOOL grantedLocation) {
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(grantedLocation);
        });
    }];
}






#pragma mark ---------处理未开启权限提示与跳转------------------
/**
 跳转权限设置页面

 @param type 权限类型
 */
+ (void)showAlertWithJumpSettingType:(JumpSettingType)type{
    NSString *msg = @"";
    switch (type) {
        case JumpSettingTypeLocation:
            msg = @"App需要您的同意,才能访问您的位置信息，用于网点查询";
            break;
        case JumpSettingTypeCamera:
            msg = @"相机权限";
            break;
        case JumpSettingTypeAlbum:
            msg = @"相册权限";
            break;
        case JumpSettingTypeContact:
            msg = @"";
            break;
        case JumpSettingTypeMicrophone:
            msg = @"开启麦克风才能使用语音转账及语音助手等功能";
            break;
        case JumpSettingTypeNotif:
            msg = @"需要我获取推送权限，才能收到消息";
            break;
        case JumpSettingTypeBluetooth:
            msg = @"蓝牙权限";
            break;
        default:
            break;
    }
    //弹窗
    [CXAlertCXCenterView AlertCXCenterAlertWithController:[UIViewController getCurrentVC] Title:@"温馨提示" Message:msg otherItemArrays:@[@"取消",@"去设置"] Type:-2 handler:^(NSInteger indexCenter) {
        if(indexCenter==1){
            [CXAuthorityManager jumpToSetting];
        }
    }];
}
///未开启权限，跳转到设置页面
+ (void)jumpToSetting{
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]]) {
        if ([[UIDevice currentDevice].systemVersion doubleValue] >= 10.0) {
            //iOS10.0以上  使用的操作
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:nil];
        } else{
            //iOS10.0以下  使用的操作
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        }
    }
}


@end
