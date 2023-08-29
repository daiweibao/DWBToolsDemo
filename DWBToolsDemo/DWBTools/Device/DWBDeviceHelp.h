//
//  DWBDeviceHelp.h
//  DouZhuan
//
//  Created by 爱恨的潮汐 on 2018/10/13.
//  Copyright © 2018 品创时代互联网科技（北京）有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DWBDeviceHelp : NSObject

+ (DWBDeviceHelp *)sharedManager;


/// 是否是iPhone，YES是
+ (BOOL)isPhoneX;

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

/// 添加录屏和截屏监听
/// - Parameter observer: 添加到那个观察者上：self，view或者控制器
- (void)addScreenNotif:(id)observer;
/// 移除录屏和截屏监听
/// - Parameter observer: 添加到那个观察者上：self，view或者控制器
- (void)removeScreenNotif:(id)observer;

@end

NS_ASSUME_NONNULL_END
