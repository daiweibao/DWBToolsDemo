//
//  CXAuthorityManager.h
//  aaa
//
//  Created by 季文斌 on 2023/8/14.
//  Copyright © 2023 Alibaba. All rights reserved.
//
//获取设备权限；参考：AuthorityManager

typedef enum {
    JumpSettingTypeLocation,      ///< 定位
    JumpSettingTypeCamera,        ///< 相机
    JumpSettingTypeAlbum,         ///< 相册
    JumpSettingTypeContact,       ///< 联系人
    JumpSettingTypeMicrophone,    ///< 麦克风
    JumpSettingTypeBluetooth      ///< 蓝牙
} JumpSettingType;

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CXAuthorityManager : NSObject

/// 【麦克风】请求当前设备的麦克风权限【音频权限】Privacy - Microphone Usage Description
/// - Parameter completion: YES代表有权限，NO代表无权限
+ (void)requestAudioPemissionWithResult:(void(^)( BOOL granted))completion;
/// 【麦克风】获取是否有麦克风权限，未询问权限不去请求权限
/// - Parameter completion: YES有权限
+ (void)getMicrophonePermissions:(void(^)( BOOL granted))completion;


/// 【相机】请求当前设备的相机权限：Privacy - Camera Usage Description
/// - Parameter completion: YES代表有权限，NO代表无权限
+ (void)requestCameraPemissionWithResult:(void(^)( BOOL granted))completion;
/// 【相机】查询是否有相机权限，无弹窗
/// - Parameter completion: YES代表有权限，NO代表无权限
+ (void)getCameraPermissions:(void(^)( BOOL granted))completion;


/// 【相册】请求当前设备的相册权限：请求当前设备的相册权限：Privacy - Photo Library Additions Usage Description
/// @param completion  YES代表有权限，NO代表无权限
+ (void)requestAlbumPemissionWithResult:(void(^)( BOOL granted))completion;
/// 【相册】查询是否有相册权限，无弹窗
/// - Parameter completion: YES代表有权限，NO代表无权限
+ (void)getPhotoPermissions:(void(^)( BOOL granted))completion;



/// 【蓝牙】获取当前手机的蓝牙权限【手机为中心设备】Privacy - Bluetooth Peripheral Usage Description
/// @param completion YES表示有权限
+ (void)requestBluetootPemissionWithResult:(void(^)( BOOL granted))completion;
/// 【蓝牙】获取当前手机的蓝牙权限，不弹出提示
/// @param completion YES表示有权限
+ (void)getBluetootPemissionWithResult:(void(^)( BOOL granted))completion;


/// 【推送】请求推送授权：
/// @param completion YES有权限
+ (void)requestNotification:(void(^)( BOOL granted))completion;
/// 【推送】获取推送权限状态：iOS10以上
/// @param completion YES代表有
+ (void)getPushPermissions:(void(^)( BOOL granted))completion;


/// 【定位】请求定位授权，弹出授权窗
/// @param completion YES代表有权限，NO代表无权限
+ (void)requestLocationManagerWithResult:(void(^)( BOOL granted))completion;
/// 【定位】获取定位权限状态，不会弹窗
/// @param completion YES有权限
+ (void)getLocationPermissionsCompletion:(void(^)( BOOL granted))completion;






/**
 跳转权限设置页面

 @param type 权限类型
 */
+ (void)showAlertWithJumpSettingType:(JumpSettingType)type;

@end

NS_ASSUME_NONNULL_END
