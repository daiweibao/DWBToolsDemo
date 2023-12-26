//
//  CXLocationQXManager.m
//  aaa
//
//  Created by 季文斌 on 2023/12/26.
//  Copyright © 2023 Alibaba. All rights reserved.
//

#import "CXLocationQXManager.h"
//定位权限
#import <CoreLocation/CLLocationManager.h>

#import "CXAuthorityManager.h"

@interface CXLocationQXManager ()<CLLocationManagerDelegate>

//设置一个定位管理者：CLLocationManager实例必须是全局的变量，否则授权提示弹框会一闪而过，不会一直显示。
@property (nonatomic, strong) CLLocationManager *locationManager;

//用户授权定位权限后回调
@property (nonatomic, copy) void(^getLocationStateBlock)(CLAuthorizationStatus status);


@end

@implementation CXLocationQXManager

///单例初始化
+ (instancetype)sharedManager {
    static CXLocationQXManager * manager;//
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[CXLocationQXManager alloc] init];
    });
    return manager;
}

/// 系统定位权限请求，会弹窗授权
/// @param completionLocation YES代表有权限，NO代表无权限
- (void)getLocationhWithState:(void(^)( BOOL grantedLocation))completionLocation{
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    if(status==kCLAuthorizationStatusNotDetermined){
        //尚未授权-未询问用户是否授权
       self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;//设置代理
        //当程序当前的授权状态为未决定时，在前台时请求定位服务许可时使用。需要先在 Info.plist 文件中设置一个Key:NSLocationWhenInUseUsageDescription, 如果不设置key，系统会忽略定位请求。
        
        //// 请求定位权限，有两个方法，取决于你的定位使用情况
        //一个是requestAlwaysAuthorization，一个是requestWhenInUseAuthorization
        [self.locationManager requestWhenInUseAuthorization];
        
//       这里有一个细节要注意，CLLocationManager实例必须是全局的变量，否则授权提示弹框会一闪而过，不会一直显示。
        //授权状态改变时就会触发代理方法
        //- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
        [self setGetLocationStateBlock:^(CLAuthorizationStatus status) {
            //用户授权状态判断
            [CXAuthorityManager getLocationPermissionsCompletion:^(BOOL granted) {
                completionLocation(granted);
            }];
        }];
        
    }else if (status==kCLAuthorizationStatusRestricted){
        NSLog(@"受限制，无权限");
        [CXAuthorityManager showAlertWithJumpSettingType:JumpSettingTypeLocation];
        completionLocation(NO);
        
    }else if (status==kCLAuthorizationStatusDenied){
        NSLog(@"用户拒绝授权");
        [CXAuthorityManager showAlertWithJumpSettingType:JumpSettingTypeLocation];
        completionLocation(NO);
        
    }else if (status==kCLAuthorizationStatusAuthorizedAlways||//获得前后台授权
              status==kCLAuthorizationStatusAuthorizedWhenInUse//获得前台授权
              ){
        NSLog(@"用户已授权");
        completionLocation(YES);
    }else{
        [CXAuthorityManager showAlertWithJumpSettingType:JumpSettingTypeLocation];
        completionLocation(NO);
    }
}

// 用户定位授权状态改变代理回调
-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    //回调用户授权状态
    if(status==kCLAuthorizationStatusNotDetermined){
        //未询问用户情况，不回调
    }else{
        if(self.getLocationStateBlock){
            self.getLocationStateBlock(status);
        }
    }
}



/// 获取定位权限状态，不会弹窗
/// @param completion YES有权限
- (void)getLocationPermissionsCompletion:(void(^)( BOOL grantedLocation))completion{
    
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    if(status==kCLAuthorizationStatusNotDetermined){
        NSLog(@"尚未授权-未询问用户是否授权");
        completion(NO);
        
    }else if (status==kCLAuthorizationStatusRestricted){
        NSLog(@"受限制，无权限");
        completion(NO);
        
    }else if (status==kCLAuthorizationStatusDenied){
        NSLog(@"用户拒绝授权");
//        // 类方法，判断是否开启定位服务
//        if ([CLLocationManager locationServicesEnabled]) {
//            NSLog(@"定位服务开启，被拒绝");
//        } else {
//            NSLog(@"定位服务关闭，不可用");
//        }
        completion(NO);
        
    }else if (status==kCLAuthorizationStatusAuthorizedAlways||//获得前后台授权
              status==kCLAuthorizationStatusAuthorizedWhenInUse//获得前台授权
              ){
        //获得前后台授权、获得前台授权
        NSLog(@"用户已授权");
        completion(YES);
        
    }else{
        completion(NO);
    }
    
    
//    if ([CLLocationManager locationServicesEnabled]) {//判断是否打开了位置服务
//      //
//    }else {
//        NSLog(@"定位服务尚未开启");
//        completion(NO);
//
//    }
}


@end
