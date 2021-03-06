//
//  DWBDeviceHelp.m
//  DouZhuan
//
//  Created by chaoxi on 2018/10/13.
//  Copyright © 2018 chaoxi科技有限公司. All rights reserved.
//

#import "DWBDeviceHelp.h"
#import <CoreMotion/CoreMotion.h>//陀螺仪
#import <objc/runtime.h>
#import <AdSupport/AdSupport.h>
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


/**
 获取APP启动图片
 
 @return image
 */
+ (UIImage *)getTheLaunchImage
{
    CGSize viewSize = [UIScreen mainScreen].bounds.size;
    
    NSString *viewOrientation = nil;
    if (([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationPortraitUpsideDown) || ([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationPortrait)) {
        viewOrientation = @"Portrait";
    } else {
        viewOrientation = @"Landscape";
    }
    
    
    NSString *launchImage = nil;
    
    NSArray* imagesDict = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    for (NSDictionary* dict in imagesDict)
    {
        CGSize imageSize = CGSizeFromString(dict[@"UILaunchImageSize"]);
        
        if (CGSizeEqualToSize(imageSize, viewSize) && [viewOrientation isEqualToString:dict[@"UILaunchImageOrientation"]])
        {
            launchImage = dict[@"UILaunchImageName"];
        }
    }
    
    return [UIImage imageNamed:launchImage];
    
}


#pragma mark ============通过bundleId打开APP S======

/**
 通过App协议打开第三方APP，YES能打开，NO不能打开
 
 @param urlSchemes APP的协议
 @return 结果
 */
+(BOOL)openThreeAPPWithCompleteWithUrlSchemes:(NSString *)urlSchemes{
    //打开app
    BOOL isCanOpenApp = [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@://",urlSchemes]]];
    
    //    if (isCanOpenApp==YES) {
    //        NSLog(@"能打开APP");
    //    }else{
    //        NSLog(@"不能打开APP");
    //    }
    
    return isCanOpenApp;
}

#pragma mark ============通过bundleId打开APP E======

///iphone广告Id传给后台【IDFA】
+ (NSString *)getAdSafeIdIDFA{
    //IDFA==获取手机广告ID要导入头文件，只要不重置系统都不会变（#import <AdSupport/AdSupport.h>）
    NSString *adId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    if ([NSString isNULL:adId]) {//判空
        return @"";
    }
    return adId;
}

@end
