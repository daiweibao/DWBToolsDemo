//
//  DWBDeviceHelp.h
//  DouZhuan
//
//  Created by chaoxi on 2018/10/13.
//  Copyright © 2018 chaoxi科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DWBDeviceHelp : NSObject
/**
 判断是否有摄像头(判断是否是模拟器)范湖YES是模拟器，NO是真机
 
 @return 结果
 */
+(BOOL)isSimulator;


/**
 判断设备是否有r陀螺仪

 @return YES有，NO，没有
 */
+(BOOL)isHaveDevice_TLY;


/**
 获取磁盘总空间,如64G 128G

 @return 结果，返回单位G
 */
+ (NSString *)getPhoneAllMemory_DiskSize;

/**
 判断设备是否是iPad其他方法判断不准，YES代表是ipad
 
 @return YES代表是iPad
 */
+ (BOOL)isiPadDevice;


/**
 获取APP启动图片
 
 @return image
 */
+ (UIImage *)getTheLaunchImage;

/**
 通过App协议打开第三方APP，YES能打开，NO不能打开
 
 @param urlSchemes APP的协议
 @return 结果
 */
+(BOOL)openThreeAPPWithCompleteWithUrlSchemes:(NSString *)urlSchemes;

///iphone广告Id传给后台【IDFA】
+ (NSString *)getAdSafeIdIDFA;


@end

NS_ASSUME_NONNULL_END
