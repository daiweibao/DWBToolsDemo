//
//  RCBBluetoothQXManager.h
//  CsiiMobileFinance
//
//  Created by 小潮汐 on 2022/10/31.
//  Copyright © 2022 DWB. All rights reserved.
//
//蓝牙权限：Privacy - Bluetooth Peripheral Usage Description

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RCBBluetoothQXManager : NSObject
///单例初始化
+ (instancetype)sharedManager;

/// 蓝牙状态请求，弹窗让用户授权
/// @param completionBluetoot YES标识蓝牙已开启
- (void)requestBluetoothWithState:(void(^)( BOOL grantedBluetoot))completionBluetoot;

/// 蓝牙状态查询，不弹窗
/// @param completionBluetoot YES标识蓝牙已开启
- (void)getBluetoothWithState:(void(^)( BOOL grantedBluetoot))completionBluetoot;

@end

NS_ASSUME_NONNULL_END
