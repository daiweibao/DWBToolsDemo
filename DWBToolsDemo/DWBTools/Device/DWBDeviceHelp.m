//
//  DWBDeviceHelp.m
//  DouZhuan
//
//  Created by 爱恨的潮汐 on 2018/10/13.
//  Copyright © 2018 品创时代互联网科技（北京）有限公司. All rights reserved.
//

#import "DWBDeviceHelp.h"
#import <CoreMotion/CoreMotion.h>//陀螺仪

#import <sys/utsname.h>//获取设备型号要导入头文件

@implementation DWBDeviceHelp

+ (DWBDeviceHelp *)sharedManager{
    static DWBDeviceHelp * manager;//类
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[DWBDeviceHelp alloc] init];
    });
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}


//可以使用一下语句判断是否是刘海手机：
+ (BOOL)isPhoneX {
    BOOL isiPhoneX = NO;
    if (UIDevice.currentDevice.userInterfaceIdiom != UIUserInterfaceIdiomPhone) {//判断是否是手机
        //如果不是手机
        return isiPhoneX;
    }
    if (@available(iOS 11.0, *)) {
        UIWindow *mainWindow = [UIApplication sharedApplication].keyWindow;
        if (mainWindow.safeAreaInsets.bottom > 0.0) {////底部安全边距
            isiPhoneX = YES;
        }
    }
    return isiPhoneX;
}

//适配iPhone X 状态栏高度 20或者44
+ (CGFloat)getStatusBarHeightBySafeArea {
    if (@available(iOS 11.0, *)) {
        // 非刘海屏，若存在状态条隐藏显示的切换，会有window.safeAreaInsets.top返回为0的异常情况
        if ([self.class screenIsBangs]) {
            //刘海屏
            UIWindow *window = [UIApplication.sharedApplication.windows firstObject];
            return window.safeAreaInsets.top;
        }
    }
    return 20;
}
///是否是刘海屏幕
+ (BOOL)screenIsBangs {
    if (@available(iOS 11.0, *)) {
        UIWindow *window = [UIApplication.sharedApplication.windows firstObject];
        return (window.safeAreaInsets.bottom > 0);
    }
    return NO;
}


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



#pragma mark---------截屏录屏监听 S-----------

/// 添加录屏和截屏监听
/// - Parameter observer: 添加到那个观察者上：self，view或者控制器
- (void)addScreenNotif:(id)observer{
    //截屏通知
    [[NSNotificationCenter defaultCenter] addObserver:observer selector:@selector(userDidTakeScreenshot:) name:UIApplicationUserDidTakeScreenshotNotification object:nil];
    if (@available(iOS 11.0, *)) {
        //iOS11后中新增了录屏功能
        [[NSNotificationCenter defaultCenter] addObserver:observer selector:@selector(userDidTakeScreenCaptured:) name:UIScreenCapturedDidChangeNotification object:nil];
    } else {
        // Fallback on earlier versions
    }
}
//截屏
-(void)userDidTakeScreenshot:(NSNotification *)notification{
    NSLog(@"检测到截屏");
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"当前页面涉及隐私内容，不允许截屏" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:okAction];
    [RootNavController presentViewController:alertController animated:YES completion:nil];
}
//录屏
- (void)userDidTakeScreenCaptured:(NSNotification *)notification{
    // 开始录屏时有弹框提示，结束录屏时就不弹框了。
//    if (![UIScreen mainScreen].isCaptured) {
//        return;
//    }
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"检测到您正在录屏，为了您的账户安全，录屏文件请勿发送给他人" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:okAction];
    [RootNavController presentViewController:alertController animated:YES completion:nil];
}

/// 移除录屏和截屏监听
/// - Parameter observer: 添加到那个观察者上：self，view或者控制器
- (void)removeScreenNotif:(id)observer{
    //移除截屏通知
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationUserDidTakeScreenshotNotification object:nil];
    //移除录屏通知
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIScreenCapturedDidChangeNotification object:nil];
}

/*
//移除截屏通知
[[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationUserDidTakeScreenshotNotification object:nil];
 //移除录屏通知
[[NSNotificationCenter defaultCenter] removeObserver:self name:UIScreenCapturedDidChangeNotification object:nil];


//补充：全局监听截屏录屏通知

if (@available(iOS 11.0, *)) {
    [[NSNotificationCenter defaultCenter] addObserverForName:UIScreenCapturedDidChangeNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        [Utils showToastWithMsg:@"发现正在录屏，请注意个人信息安全" Duration:2.0];
    }];
}
//截屏
[[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationUserDidTakeScreenshotNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
    [Utils showToastWithMsg:@"发现截屏操作，请注意个人信息安全" Duration:2.0];
}];
*/
#pragma mark---------截屏录屏监听 E-----------


///获取设备型号
+ (NSString *)getCurrentDeviceModel{
    struct utsname systemInfo;
    uname(&systemInfo); // 获取系统设备信息
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
    NSDictionary *dict = @{
                           // iPhone
                           @"iPhone5,1" : @"iPhone 5",
                           @"iPhone5,2" : @"iPhone 5",
                           @"iPhone5,3" : @"iPhone 5c",
                           @"iPhone5,4" : @"iPhone 5c",
                           @"iPhone6,1" : @"iPhone 5s",
                           @"iPhone6,2" : @"iPhone 5s",
                           @"iPhone7,1" : @"iPhone 6 Plus",
                           @"iPhone7,2" : @"iPhone 6",
                           @"iPhone8,1" : @"iPhone 6s",
                           @"iPhone8,2" : @"iPhone 6s Plus",
                           @"iPhone8,4" : @"iPhone SE",
                           @"iPhone9,1" : @"iPhone 7",
                           @"iPhone9,2" : @"iPhone 7 Plus",
                           @"iPhone9,3" : @"iPhone 7",
                           @"iPhone9,4" : @"iPhone 7 Plus",
                           @"iPhone10,1" : @"iPhone 8",
                           @"iPhone10,2" : @"iPhone 8 Plus",
                           @"iPhone10,4" : @"iPhone 8",
                           @"iPhone10,5" : @"iPhone 8 Plus",
                           @"iPhone10,3" : @"iPhone X",
                           @"iPhone10,6" : @"iPhone X",
                           @"iPhone11,2" : @"iPhone XS",
                           @"iPhone11,4" : @"iPhone XS Max",
                           @"iPhone11,6" : @"iPhone XS Max",
                           @"iPhone11,8" : @"iPhone XR",
                           @"iPhone12,1" : @"iPhone 11",
                           @"iPhone12,3" : @"iPhone 11 Pro",
                           @"iPhone12,5" : @"iPhone 11 Pro Max",
                           @"iPhone12,8" : @"iPhone SE Gen2",
                           @"iPhone13,1" : @"iPhone 12 mini",
                           @"iPhone13,2" : @"iPhone 12",
                           @"iPhone13,3" : @"iPhone 12 Pro",
                           @"iPhone13,4" : @"iPhone 12 Pro Max",
                           @"iPhone14,4" : @"iPhone 13 mini",
                           @"iPhone14,5" : @"iPhone 13",
                           @"iPhone14,2" : @"iPhone 13 Pro",
                           @"iPhone14,3" : @"iPhone 13 Pro Max",
                           @"iPhone14,7" : @"iPhone 14",
                           @"iPhone14,8" : @"iPhone 14 Plus",
                           @"iPhone15,2" : @"iPhone 14 Pro",
                           @"iPhone15,3" : @"iPhone 14 Pro Max",
                           @"i386" : @"iPhone Simulator",
                           @"x86_64" : @"iPhone Simulator"
                           };
    NSString *name = dict[platform];
    //如果能获取到设备名称就返回设别名称，获取不到就返回系统信息
    return name ? name : platform;
    
//   iPhone设备型号官网地址：https://www.theiphonewiki.com/wiki/Models
}
 




@end
