//
//  AFNetworkingChange.h
//  aaa
//
//  Created by 季文斌 on 2023/9/4.
//  Copyright © 2023 Alibaba. All rights reserved.
//
//监听网路状态变化：AFN4.0
#import <Foundation/Foundation.h>
#import "AFNetworking.h"
NS_ASSUME_NONNULL_BEGIN

@interface CXAFNetworkingChange : NSObject

/**
 是否有网，返回NO代表没网，YES有网
 
 @return 结果，不太准，谨慎使用。
 */
+ (BOOL)isHaveNetwork;

/**
 监听网络状态,在AppDelegate里调用
 */
+ (void)yz_currentNetStates;

@end

NS_ASSUME_NONNULL_END
