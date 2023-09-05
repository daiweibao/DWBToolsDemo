//
//  AFNetworkingChange.m
//  aaa
//
//  Created by 季文斌 on 2023/9/4.
//  Copyright © 2023 Alibaba. All rights reserved.
//

#import "CXAFNetworkingChange.h"

static NSString const * YZNetworkState = @"NO";//网络状态，可变
static NSTimeInterval YZnetworkChange = 0;//0表示切换前处于有网状态，1表示切换前处于没网状态

@implementation CXAFNetworkingChange

/**
 是否有网，返回NO代表没网，YES有网

 @return 结果，不太准，谨慎使用。
 */
+ (BOOL)isHaveNetwork {
    return [AFNetworkReachabilityManager sharedManager].reachable;
}


#pragma mark - 网络监听
/**
 监听网络状态,在AppDelegate里调用
 */
+ (void)yz_currentNetStates {
    
    AFNetworkReachabilityManager *manger = [AFNetworkReachabilityManager sharedManager];
    
    [manger setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        /*
         AFNetworkReachabilityStatusUnknown          = -1,
         AFNetworkReachabilityStatusNotReachable     = 0,
         AFNetworkReachabilityStatusReachableViaWWAN = 1,
         AFNetworkReachabilityStatusReachableViaWiFi = 2,
         */
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:{
                YZNetworkState = @"NO";
                YZnetworkChange = 1;//网络切换到没网状态
//                [DWBToast showCenterWithText:@"当前无网络，请稍后再试！"];
            }
                break;
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"没有网络");
                YZNetworkState = @"NO";
                YZnetworkChange = 1;//网络切换到没网状态
//                [DWBToast showCenterWithText:@"当前无网络，请稍后再试！"];
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"3G|4G");
                YZNetworkState = @"4G";
//                [DWBToast showCenterWithText:@"当前为非Wi-Fi环境，请注意流量消耗！"];
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"WiFi");
                YZNetworkState = @"WIFI";
                break;
            default:
                break;
        }
        if (![YZNetworkState isEqualToString:@"NO"]) {
            //有网，每次切换有网都走这里
        }
        
        if (![YZNetworkState isEqualToString:@"NO"] && YZnetworkChange==1) {
            YZnetworkChange = 0;//有网状态记录
            //发出网络状态改变的通知，从没网到有网
            [[NSNotificationCenter defaultCenter] postNotificationName:@"YZ_networkChange" object:nil];
        }else{
            //从有网到没网，或者从有网到有网
            
        }
    }];
    [manger startMonitoring];//开始监听
}


@end

