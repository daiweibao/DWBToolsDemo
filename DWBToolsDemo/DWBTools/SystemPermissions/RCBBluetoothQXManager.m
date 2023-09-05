//
//  RCBBluetoothQXManager.m
//  CsiiMobileFinance
//
//  Created by 小潮汐 on 2022/10/31.
//  Copyright © 2022 DWB. All rights reserved.
//
//Privacy - Bluetooth Always Usage Description
//Privacy - Bluetooth Peripheral Usage Description

#import "RCBBluetoothQXManager.h"
#import "CXAuthorityManager.h"
//蓝牙
#import <CoreBluetooth/CoreBluetooth.h>

@interface RCBBluetoothQXManager()<CBCentralManagerDelegate>
//以蓝牙为中心设备的初始化
@property (nonatomic, strong) CBCentralManager *cbManager;

@property (nonatomic, copy) void(^getBluetoothStateBlock)(CBCentralManager *centralBlue);

@end

@implementation RCBBluetoothQXManager

///单例初始化
+ (instancetype)sharedManager {
    static RCBBluetoothQXManager * manager;//
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[RCBBluetoothQXManager alloc] init];
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

/*
 
 本文介绍了现在检查CBPeripheralManager.authorizationStatus（），因为它已被弃用的处理方法，对大家解决问题具有一定的参考价值，需要的朋友们下面随着小编来一起学习吧！
 问题描述
 
 CBPeripheralManager.authorizationStatus（）和 CBPeripheralManagerAuthorizationStatus 。检查用户现在是否已授予在后台使用蓝牙权限的正确方法是什么？
 CBPeripheralManagerDelegate 具有 peripheralManagerDidUpdateState ，但无论用户是否授予许可，都不会返回未经授权的，而只会返回 poweredOn 或 poweredOff
 推荐答案
 
 CBCentralManager 和 CBPeripheralManager 继承自 CBManager 。
 从iOS 13开始， CBManager 有一个 授权 属性。您可以检查 .allowedAlways 。
 如果#available（iOS，可以使用 13.0，*）有条件地在iOS 13及更高版本上使用授权
 这篇关于现在检查CBPeripheralManager.authorizationStatus（），因为它已被弃用的文章就介绍到这了，希望我们推荐的答案对大家有所帮助，也希望大家多多支持IT屋！
 
 ------------------
 首先需要 #import <CoreBluetooth/CoreBluetooth.h>【需注意该权限虽然很早就支持，但是设置页面对应的开关仅在iOS 13之后才开始支持，iOS 13之前在设置页面是没有该对应开关的】
 
 另外蓝牙比较不同的是，它是一种双向性的权限，即你本身的设备可以作为中心设备，也可以作为被扫描到的外围设备，所以官方提供了CBCentralManager和CBPeripheralManager分别来管理中心和外围设备的情况。
 
 作为中心设备获取状态：CBCentralManager
 
 作为外围设备获取状态：CBPeripheralManager
 
 
 */

/*
 通过属性CBManagerState获取的是“控制中心”的蓝牙状态。
 
 iOS13增加了属性CBManagerAuthorization，来获取蓝牙的授权状态.
 */


/// 蓝牙状态查询请求
/// @param completionBluetoot YES标识蓝牙已开启
- (void)getBluetoothWithState:(void(^)( BOOL grantedBluetoot))completionBluetoot{
    if (self.cbManager==nil) {
       //尚未初始化,App启动后首次走
        [self initMyCbManager];
        //获取首次状态。初始化完后立即通过central.state无法获取到蓝牙状态，需要等待代理方法走了才能获取到
        __weak typeof(self) wself=self;
        [self setGetBluetoothStateBlock:^(CBCentralManager *centralBlue) {
            completionBluetoot([wself chooseBluetoothWithState]);
        }];
    }else{
        dispatch_async(dispatch_get_main_queue(), ^{
            completionBluetoot([self chooseBluetoothWithState]);
        });
    }
}

//#import <CoreBluetooth/CoreBluetooth.h>
//【App启动就初始化蓝牙】初始化蓝牙，并请求蓝牙授权弹窗权限，初始化时候会弹出蓝牙弹窗权限。同时设置下代理哦
-(void)initMyCbManager{
    NSDictionary *options = @{CBCentralManagerOptionShowPowerAlertKey:@NO};//不弹窗aleat蓝牙提示（配置）
    self.cbManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil options:options];
    
//    self.cbManager = [[CBCentralManager alloc]initWithDelegate:self queue:dispatch_get_main_queue()];
}

#pragma mark --------CBCentralManagerDelegate
//时时监听蓝牙状态变化，App首次启动，或者授权结束后，用户点击按钮后才走这里
- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    //【非常重要】用单例保证走一次回调，不能多走哦，否则会多次回调。下次走后面的直接查询状态。App打开时候走一次回调
    //
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if(self.getBluetoothStateBlock){
            self.getBluetoothStateBlock(central);
        }
    });
    if (@available(iOS 10.0, *)) {//CBManagerState只支持iOS10以上
        //日志打印用
        switch (central.state)
        {
            case CBManagerStatePoweredOn:
                NSLog(@"蓝牙已开启");
                //            根据SERVICE_UUID来扫描外设，如果不设置SERVICE_UUID，则扫描所有蓝牙设备
                //            第一个参数为CBUUID的数组，需要搜索特点服务的蓝牙设备，只要每搜索到一个符合条件的蓝牙设备都会调用didDiscoverPeripheral代理方法
                break;
            case CBManagerStatePoweredOff:
                NSLog(@"蓝牙已关闭, 请打开蓝牙");
                break;
            case CBManagerStateUnsupported:
                NSLog(@"设备不支持蓝牙");
                break;
            case CBManagerStateUnauthorized:
                NSLog(@"应用尚未被授权使用蓝牙");
                break;
            case CBManagerStateUnknown:
                NSLog(@"未知错误，请重新开启蓝牙");
                break;
            case CBManagerStateResetting:
                NSLog(@"蓝牙重置中");
                break;
            default:
                NSLog(@"Central Manager did change state");
                break;
        }
        
    } else {
        // Fallback on earlier versions
    }
}


-(BOOL)chooseBluetoothWithState{
    if (@available(iOS 10.0, *)) {
        //APP启动就初始化cbManager，不然这里在获取时才初始化，拿不到蓝牙状态
        //先检查App是否授权使用蓝牙（授权不受到蓝牙总开关状态影响）
        if (self.cbManager.state==CBManagerStateUnauthorized){
            NSLog(@"APP尚未被授权使用蓝牙--");
            //没有权限
            [CXAuthorityManager showAlertWithJumpSettingType:JumpSettingTypeBluetooth];
            return NO;
        }else{
            //再检查蓝牙总开关开了没
            if (self.cbManager.state==CBManagerStatePoweredOn) {
                NSLog(@"蓝牙已开启，可正常用--");
                return YES;
            }else{
                //蓝牙无法使用
                if (self.cbManager.state==CBManagerStatePoweredOff) {
                    NSLog(@"蓝牙已关闭, 请打开蓝牙--");
                    //蓝牙开关关闭了-弹窗提示
                    [CXAlertCXCenterView AlertCXCenterAlertWithController:[UIViewController getCurrentVC] Title:@"温馨提示" Message:@"手机蓝牙已关闭，请打开手机设置里和控制中心里的蓝牙开关" otherItemArrays:@[@"知道了"] Type:-1 handler:^(NSInteger indexCenter) {
                        
                    }];
                }else{
                    //蓝牙无法使用
                    [CXAlertCXCenterView AlertCXCenterAlertWithController:[UIViewController getCurrentVC] Title:@"温馨提示" Message:@"手机蓝牙无法使用，请检查蓝牙是否打开" otherItemArrays:@[@"知道了"] Type:-1 handler:^(NSInteger indexCenter) {
                        
                    }];
                }
                //无法使用
                return NO;
            }
        }
    } else {
        // Fallback on earlier versions
        //iOS10 以下暂时无法判断蓝牙是否开启，就返回开启吧
        return YES;
    }
}



//================以下代码已废弃===================
//#import <CoreBluetooth/CoreBluetooth.h>
+ (void)openPeripheralServiceWithBolck:(void(^)( BOOL granted))completion
{
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_7_0
    //老系统获取方法
    CBPeripheralManagerAuthorizationStatus cbAuthStatus = [CBPeripheralManager authorizationStatus];
    if (cbAuthStatus == CBPeripheralManagerAuthorizationStatusNotDetermined) {
        if (completion) {
            completion(NO);
        }
    } else if (cbAuthStatus == CBPeripheralManagerAuthorizationStatusRestricted || cbAuthStatus == CBPeripheralManagerAuthorizationStatusDenied) {
        if (completion) {
            completion(NO);
        }
    } else {
        if (completion) {
            completion(YES);
        }
    }
#endif
}


@end
