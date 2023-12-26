//
//  CXLocationQXManager.h
//  aaa
//
//  Created by 季文斌 on 2023/12/26.
//  Copyright © 2023 Alibaba. All rights reserved.
//
//系统定位权限-封装
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CXLocationQXManager : NSObject

///单例初始化
+ (instancetype)sharedManager;

/// 系统定位权限请求，会弹窗授权
/// @param completionLocation YES是已开启
- (void)getLocationhWithState:(void(^)( BOOL grantedLocation))completionLocation;

/// 获取定位权限状态，不会弹窗
/// @param completion YES有权限
- (void)getLocationPermissionsCompletion:(void(^)( BOOL grantedLocation))completion;

@end

NS_ASSUME_NONNULL_END
