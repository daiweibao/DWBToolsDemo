//
//  DWBDeviceHelp.m
//  DouZhuan
//
//  Created by 戴维保 on 2018/10/13.
//  Copyright © 2018 品创时代互联网科技（北京）有限公司. All rights reserved.
//

#import "DWBDeviceHelp.h"
#import <CoreMotion/CoreMotion.h>//陀螺仪
@implementation DWBDeviceHelp
//判断是否有摄像头(判断是否是模拟器)范湖YES是模拟器，NO是真机
+(BOOL)isSimulator{
    //    if([UIImagePickerController isSourceTypeAvailable:YES]){
    //        //有摄像头，是真机
    //        return NO;
    //    }else{
    //        //无摄像头，是模拟器
    //        return YES;
    //    }
    
    //百度的方法
    if (TARGET_IPHONE_SIMULATOR == 1 && TARGET_OS_IPHONE == 1) {
        
        //模拟器
        return YES;
        
    }else{
        
        //真机
        return NO;
    }
}

/**
 判断设备是否有陀螺仪(用单例)
 
 @return YES有，NO，没有
 */
+(BOOL)isHaveDevice_TLY{
    //判断陀螺仪是否可用和开启
    static CMMotionManager * motionManager;
    //单例
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
      motionManager = [[CMMotionManager alloc] init];
    });

    return [motionManager isGyroAvailable];
}

/** 获取磁盘总空间 */
+ (NSString *)getPhoneAllMemory_DiskSize{
    NSError *error = nil;
    NSDictionary *attrs = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:&error];
    if (error) return @"0";
    int64_t space =  [[attrs objectForKey:NSFileSystemSize] longLongValue];
    if (space < 0) space = -1;
    //得到手机磁盘空间z总容量
     NSString *totalDiskInfo = [NSString stringWithFormat:@"%.2fGB",space/1024/1024/1024.0];
    
    return totalDiskInfo;
}

/*
 一、iOS7以后不能获取手机IMEI
 
 iOS 2.0版本以后UIDevice提供一个获取设备唯一标识符的方法uniqueIdentifier，通过该方法我们可以获取设备的序列号，
 这个也是目前为止唯一可以确认唯一的标示符。好景不长，因为该唯一标识符与手机一一对应，苹果觉得可能会泄露用户隐私，
 所以在iOS5之后该方法就被废弃掉了，因此iOS5以后不能获取手机IMEI，但是也是可以通过私有API获取手机的IMEI号的，
 但是通过苹果私有API获取IMEI号，上架苹果商店会被拒掉的。

 */



//判断设备是否是iPad其他方法判断不准，YES代表是ipad
+ (BOOL)isiPadDevice
{
    NSString *deviceType = [UIDevice currentDevice].model;
    
    if([deviceType isEqualToString:@"iPhone"]) {
        //iPhone
        return NO;
    }
    else if([deviceType isEqualToString:@"iPod touch"]) {
        //iPod Touch
        return NO;
    }
    else if([deviceType isEqualToString:@"iPad"]) {
        //iPad
        return YES;
    }
    return NO;
    
    //这两个防范判断不准，不要用
    //#define is_iPhone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    //
    //#define is_iPad (UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPad)
}



@end
