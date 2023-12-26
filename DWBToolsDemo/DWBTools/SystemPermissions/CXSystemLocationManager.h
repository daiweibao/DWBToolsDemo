//
//  CXSystemLocationManager.h
//  aaa
//
//  Created by 季文斌 on 2023/12/26.
//  Copyright © 2023 Alibaba. All rights reserved.
//
//系统定位，获取经纬度
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CXSystemLocationManager : NSObject
+(instancetype)shareManager;
///经度
@property (nonatomic, strong) NSString *longitudeString;
///纬度
@property (nonatomic, strong) NSString *latitudeString;

//开始定位
- (void)startLocation;

@end

NS_ASSUME_NONNULL_END
