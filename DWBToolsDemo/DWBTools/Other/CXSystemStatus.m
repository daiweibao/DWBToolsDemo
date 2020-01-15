//
//  CXSystemStatus.m
//  AiHenDeChaoXi
//
//  Created by 戴维保 on 2018/5/9.
//  Copyright © 2018年 潮汐科技有限公司. All rights reserved.
//

#import "CXSystemStatus.h"

#import <Photos/Photos.h>//相册
#import <CoreLocation/CoreLocation.h>//定位
//通知--必须导入
#import <UserNotifications/UserNotifications.h>

@interface CXSystemStatus()<CLLocationManagerDelegate>

// 定位信息要使用成员变量否则会被arc提前释放一闪而过
@property (nonatomic, strong)CLLocationManager *manager;

@end


@implementation CXSystemStatus


#pragma mark ============= 麦克风 S===============
//授权麦克风,并判断权限
+(void)getAudioAuthWithisShowAlert:(BOOL)isShowAlert AndState:(void(^)(BOOL isON))audioState{
    //调用此方法弹出询问框，询问用户是否允许访问
    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeAudio completionHandler:^(BOOL granted) {
        //        NSLog(@"%@",granted ? @"麦克风准许":@"麦克风不准许");
        //用户点击允许或者拒接后，回调走这里
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
        
        //判断,为了block在主线程回调，必须用if
        if (authStatus==AVAuthorizationStatusNotDetermined) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                //没有询问是否开启麦克风
                [CXSystemStatus showSetAlertView:isShowAlert];
                
                // 没权限
                if (audioState) {
                    audioState(NO);
                }
                
                
            });
        }else  if (authStatus==AVAuthorizationStatusRestricted) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                //未授权，家长限制
                [CXSystemStatus showSetAlertView:isShowAlert];
                // 没权限
                if (audioState) {
                    audioState(NO);
                }
                
            });
        }else if (authStatus==AVAuthorizationStatusDenied) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                //玩家未授权
                [CXSystemStatus showSetAlertView:isShowAlert];
                // 没权限
                if (audioState) {
                    audioState(NO);
                }
                
            });
        }else if (authStatus==AVAuthorizationStatusAuthorized) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                 //玩家授权,已开启权限
                if (audioState) {
                    audioState(YES);
                }
                
            });
        }else{
        
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [CXSystemStatus showSetAlertView:isShowAlert];
                
                // 没权限
                if (audioState) {
                    audioState(NO);
                }
            });
        }
        
    }];
    
}

//提示用户进行麦克风使用授权
+ (void)showSetAlertView:(BOOL)isShowAlert{
    if (isShowAlert==NO) {
        //不提示
        return;
    }
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"麦克风权限未开启" message:@"麦克风权限未开启，请进入系统【设置】>【隐私】>【麦克风】中打开开关,开启麦克风功能" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *setAction = [UIAlertAction actionWithTitle:@"去设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //跳入当前App设置界面,素有获取权限的方法，多用于用户第一次操作应用，iOS 8.0之后，将这些设置都整合在一起，并且可以开启或关闭相应的权限。所有的权限都可以通过下面的方法打开：
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    }];
    [alertVC addAction:cancelAction];
    [alertVC addAction:setAction];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertVC animated:YES completion:nil];
}

#pragma mark ============= 麦克风 E===============



#pragma mark ============= 相机权限 S===============
//授权相机，询问用户是否开启，并判断状态
+ (void)getVideoAuthActionWithisShowAlert:(BOOL)isShowAlert AndState:(void(^)(BOOL isONVideo))videoState{
    //询问
    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
        //权限判断
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        
        //判断,为了block在主线程回调，必须用if
        if (authStatus==AVAuthorizationStatusNotDetermined) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                //没有询问是否开启相机
                [CXSystemStatus showSetAudioAlertView:isShowAlert];
                
                // 没权限
                if (videoState) {
                    videoState(NO);
                }
                
            });
        }else if (authStatus==AVAuthorizationStatusRestricted){
            
            dispatch_async(dispatch_get_main_queue(), ^{
                //未授权，家长限制
                [CXSystemStatus showSetAudioAlertView:isShowAlert];
                
                // 没权限
                if (videoState) {
                    videoState(NO);
                }
                
            });
            
        }else if (authStatus==AVAuthorizationStatusDenied){
            
            dispatch_async(dispatch_get_main_queue(), ^{
                //未授权;
                [CXSystemStatus showSetAudioAlertView:isShowAlert];
                
                // 没权限
                if (videoState) {
                    videoState(NO);
                }
                
            });
            
        }else if (authStatus==AVAuthorizationStatusAuthorized){
            
            dispatch_async(dispatch_get_main_queue(), ^{
                // 有权限
                if (videoState) {
                    videoState(YES);
                }
                NSLog(@"用户允许访问视频");
                
            });
            
        }else{
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [CXSystemStatus showSetAudioAlertView:isShowAlert];
                // 没权限
                if (videoState) {
                    videoState(NO);
                }
            });
        
        }

    }];
}

//提示用户开启相机权限
+ (void)showSetAudioAlertView:(BOOL)isShowAlert{
    if (isShowAlert==NO) {
        //不提示
        return;
    }
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"相机权限未开启" message:@"相机权限未开启，请进入系统【设置】>【隐私】>【相机】中打开开关,开启相机功能" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *setAction = [UIAlertAction actionWithTitle:@"去设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //跳入当前App设置界面,素有获取权限的方法，多用于用户第一次操作应用，iOS 8.0之后，将这些设置都整合在一起，并且可以开启或关闭相应的权限。所有的权限都可以通过下面的方法打开：
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    }];
    [alertVC addAction:cancelAction];
    [alertVC addAction:setAction];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertVC animated:YES completion:nil];
}

#pragma mark ============= 相机权限 E===============


#pragma mark ============= 相册权限 S===============
//授权照片权限并判断状态
+ (void)getPhoneAuthActionWithisShowAlert:(BOOL)isShowAlert AndState:(void(^)(BOOL isONPhone))phoneState{
    
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        
        PHAuthorizationStatus photoAuthorStatus = [PHPhotoLibrary authorizationStatus];
        if (photoAuthorStatus == PHAuthorizationStatusDenied) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
//                NSLog(@"用户拒绝当前应用访问相册,我们需要提醒用户打开访问开关");
                //没有询问是否开启相册
                [CXSystemStatus showSetPhoneAlertView:isShowAlert];
                
                // 没权限
                if (phoneState) {
                    phoneState(NO);
                }
                
            });

            
        }else if (photoAuthorStatus == PHAuthorizationStatusRestricted){
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
//                NSLog(@"家长控制,不允许访问");
                //没有询问是否开启相册
                [CXSystemStatus showSetPhoneAlertView:isShowAlert];
                
                // 没权限
                if (phoneState) {
                    phoneState(NO);
                }
            });

            
        }else if (photoAuthorStatus == PHAuthorizationStatusNotDetermined){
            
            dispatch_async(dispatch_get_main_queue(), ^{
//                NSLog(@"用户还没有做出选择");
                //没有询问是否开启相册
                [CXSystemStatus showSetPhoneAlertView:isShowAlert];
                
                // 没权限
                if (phoneState) {
                    phoneState(NO);
                }
                
            });

            
        }else if (photoAuthorStatus == PHAuthorizationStatusAuthorized){
            
            dispatch_async(dispatch_get_main_queue(), ^{
//                NSLog(@"用户允许当前应用访问相册");
                
                // 有权限
                if (phoneState) {
                    phoneState(YES);
                }
                
            });

            
        }
    }];
}


//提示用户开启相册权限
+ (void)showSetPhoneAlertView:(BOOL)isShowAlert{
    if (isShowAlert==NO) {
        //不提示
        return;
    }
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"相册权限未开启" message:@"相册权限未开启，请进入系统【设置】>【隐私】>【相册】中打开开关,开启相册功能" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *setAction = [UIAlertAction actionWithTitle:@"去设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //跳入当前App设置界面,素有获取权限的方法，多用于用户第一次操作应用，iOS 8.0之后，将这些设置都整合在一起，并且可以开启或关闭相应的权限。所有的权限都可以通过下面的方法打开：
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    }];
    [alertVC addAction:cancelAction];
    [alertVC addAction:setAction];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertVC animated:YES completion:nil];
}


#pragma mark ============= 相册权限 E===============



#pragma mark ============= 位置权限 S===============
//询问用户是否打开位置权限
-(void)asksUserLocation{
    
    // 判断是否打开了系统的位置服务
    BOOL isLocation = [CLLocationManager locationServicesEnabled];
    if (!isLocation) {
        NSLog(@"定位服务不可用，例如定位没有打开...");//没有打开位置。
    }
    // 定位信息要使用成员变量否则会被arc提前释放一闪而过
    self.manager = [[CLLocationManager alloc] init];
    self.manager.delegate = self;
    [self.manager requestAlwaysAuthorization];//一直获取定位信息
    [self.manager requestWhenInUseAuthorization];//使用的时候获取定位信息
    
}


//弹窗询问用户位置权限后用户点击后会走次代理方法---在代理方法中查看权限是否改变
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    switch (status) {
        case kCLAuthorizationStatusAuthorizedAlways://已经获取到权限，开启定位(总是)
            NSLog(@"Always Authorized");
            break;
        case kCLAuthorizationStatusAuthorizedWhenInUse://已经获取到权限，开启定位（使用的时候）
            NSLog(@"AuthorizedWhenInUse");
            break;
        case kCLAuthorizationStatusDenied://用户已经拒绝权限，去设置中开启权限
            NSLog(@"Denied");
            break;
        case kCLAuthorizationStatusNotDetermined://用户还未选择位置权限
            NSLog(@"not Determined");
            break;
        case kCLAuthorizationStatusRestricted://无法控制，无法获知状态
            NSLog(@"Restricted");
            break;
        default:
            break;
    }
}



/**
 检测用户是否开启了位置权限:YES开启了，NO没有

 @return 结果
 */
+(BOOL)isOpen_Location{
    
    // 判断是否打开了系统的位置服务
    BOOL isLocation = [CLLocationManager locationServicesEnabled];
    if (!isLocation) {
//        NSLog(@"定位服务不可用，例如定位没有打开...");//没有打开位置。
        return NO;
    }
    CLAuthorizationStatus CLstatus = [CLLocationManager authorizationStatus];
    switch (CLstatus) {
        case kCLAuthorizationStatusAuthorizedAlways://已经获取到权限，开启定位(总是)
//            NSLog(@"Always Authorized");
            return YES;
            break;
        case kCLAuthorizationStatusAuthorizedWhenInUse://已经获取到权限，开启定位（使用的时候）
//            NSLog(@"AuthorizedWhenInUse");
             return YES;
            break;
        case kCLAuthorizationStatusDenied://用户已经拒绝权限，去设置中开启权限
//            NSLog(@"Denied");
             return NO;
            break;
        case kCLAuthorizationStatusNotDetermined://用户还未选择位置权限
//            NSLog(@"not Determined");
            return NO;
            break;
        case kCLAuthorizationStatusRestricted://无法控制，无法获知状态
            NSLog(@"Restricted");
             return NO;
            break;
        default:
            break;
    }
    
}



#pragma mark ============= 位置权限 E===============




#pragma mark ============= 推送权限 S===============
+(void)getUserNotificationWithisShowAlert:(BOOL)isShowAlert AndStatus:(void(^)(BOOL isON))notfState{
    if (@available(iOS 10 , *))
    {
        [[UNUserNotificationCenter currentNotificationCenter] getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
            
            if (settings.authorizationStatus == UNAuthorizationStatusDenied)
            {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    // 没权限
                    //弹窗
                    [CXSystemStatus showNotificationAlertView:isShowAlert];
                    //回调
                    if (notfState) {
                        notfState(NO);
                    }
                    
                });

                
            }else{
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    // 有权限
                    if (notfState) {
                        notfState(YES);
                    }
                    
                });

            }
            
        }];
    }
    else if (@available(iOS 8 , *))
    {
        UIUserNotificationSettings * setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
        
        if (setting.types == UIUserNotificationTypeNone) {
            dispatch_async(dispatch_get_main_queue(), ^{
                // 没权限
                //弹窗
                [CXSystemStatus showNotificationAlertView:isShowAlert];
                //回调
                if (notfState) {
                    notfState(NO);
                }
                
            });

        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                // 有权限
                if (notfState) {
                    notfState(YES);
                }
                
            });

        }
    }
    else
    {
        //iOS8以下这样判断是否开启了推送开关
        UIRemoteNotificationType type = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
        if (type == UIUserNotificationTypeNone)
        {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                // 没权限
                //弹窗
                [CXSystemStatus showNotificationAlertView:isShowAlert];
                //回调
                if (notfState) {
                    notfState(NO);
                }
                
            });

        }else{
            
            dispatch_async(dispatch_get_main_queue(), ^{
                // 有权限
                if (notfState) {
                    notfState(YES);
                }
                
            });

        }
    }
}


//提示用户进行通知使用授权
+ (void)showNotificationAlertView:(BOOL)isShowAlert{
    if (isShowAlert==NO) {
        //不提示
        return;
    }
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"通知权限未开启" message:@"通知权限未开启，请进入系统【设置】>【通知】中打开开关,开启通知功能" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *setAction = [UIAlertAction actionWithTitle:@"去设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //跳入当前App设置界面,素有获取权限的方法，多用于用户第一次操作应用，iOS 8.0之后，将这些设置都整合在一起，并且可以开启或关闭相应的权限。所有的权限都可以通过下面的方法打开：
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    }];
    [alertVC addAction:cancelAction];
    [alertVC addAction:setAction];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertVC animated:YES completion:nil];
}

/*
 推送权限的申请
 
 加入头文件
 #ifdef NSFoundationVersionNumber_iOS_9_x_Max
 #import <UserNotifications/UserNotifications.h>
 #endif
 申请权限
 
 -(void) requestNotification
 {
 if (@available(iOS 10, *))
 {
 UNUserNotificationCenter * center = [UNUserNotificationCenter currentNotificationCenter];
 center.delegate = self;
 [center requestAuthorizationWithOptions:UNAuthorizationOptionAlert | UNAuthorizationOptionBadge | UNAuthorizationOptionSound completionHandler:^(BOOL granted, NSError * _Nullable error) {
 
 if (granted) {
 // 允许推送
 }else{
 //不允许
 }
 
 }];
 }
 else if(@available(iOS 8 , *))
 {
 UIApplication * application = [UIApplication sharedApplication];
 
 [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound categories:nil]];
 [application registerForRemoteNotifications];
 }
 else
 {
 UIApplication * application = [UIApplication sharedApplication];
 [application registerForRemoteNotificationTypes:UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound];
 [application registerForRemoteNotifications];
 }
 }
 
 作者：careyang
 链接：https://www.jianshu.com/p/bdc64eb29908
 來源：简书
 著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。
 */

#pragma mark ============= 推送权限 E===============



@end

