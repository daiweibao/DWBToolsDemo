//
//  CXDeviceIPAddress.h
//  aaa
//
//  Created by 季文斌 on 2023/8/31.
//  Copyright © 2023 Alibaba. All rights reserved.
//获取IP地址

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CXDeviceIPAddress : NSObject

/// 获取IP地址
+ (NSString *)getIPAddress;

@end

NS_ASSUME_NONNULL_END
