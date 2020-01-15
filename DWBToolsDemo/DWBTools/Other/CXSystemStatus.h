//
//  CXSystemStatus.h
//  AiHenDeChaoXi
//
//  Created by 戴维保 on 2018/5/9.
//  Copyright © 2018年 潮汐科技有限公司. All rights reserved.
//
//系统访问权限状态
#import <Foundation/Foundation.h>

@interface CXSystemStatus : NSObject


/**
 授权【麦克风】,并判断权限
 @param isShowAlert 传入NO代表未开启时不弹窗提示，否则提示
 @param audioState 返回YES代表打开了，返回NO代表关闭了
 */
+(void)getAudioAuthWithisShowAlert:(BOOL)isShowAlert AndState:(void(^)(BOOL isON))audioState;


/**
 获取用户是否打开了【推送权限】,并选择是否弹窗提示用户去开启通知
 
 @param isShowAlert 传入NO代表未开启时不弹窗提示，否则提示
 @param notfState 返回YES代表打开了，返回NO代表关闭了
 */
+(void)getUserNotificationWithisShowAlert:(BOOL)isShowAlert AndStatus:(void(^)(BOOL isON))notfState;



/**
 获取用户是否打开了【相机】,并选择是否弹窗提示用户去开启通知，回调后处理必须在主线程：dispatch_async(dispatch_get_main_queue(), ^{
 });
 
 @param isShowAlert 传入NO代表未开启时不弹窗提示，否则提示
 @param videoState 返回YES代表打开了，返回NO代表关闭了
 */
+ (void)getVideoAuthActionWithisShowAlert:(BOOL)isShowAlert AndState:(void(^)(BOOL isONVideo))videoState;


/**
 获取用户是否打开了【相册】,并选择是否弹窗提示用户去开启通知，回调后处理必须在主线程：dispatch_async(dispatch_get_main_queue(), ^{
 });
 
 @param isShowAlert 传入NO代表未开启时不弹窗提示，否则提示
 @param phoneState 返回YES代表打开了，返回NO代表关闭了
 */
+ (void)getPhoneAuthActionWithisShowAlert:(BOOL)isShowAlert AndState:(void(^)(BOOL isONPhone))phoneState;

/**
 询问用户是否打开位置权限,只能是对象方法
 */
-(void)asksUserLocation;
/*
 //【调用】位置权限询问(需要强指针)
 //必须强指针，否则无效
 //        @property(nonatomic,strong)CXSystemStatus * cxlocation;
 self.cxlocation = [[CXSystemStatus alloc]init];
 [self.cxlocation asksUserLocation];
 */


/**
 检测用户是否开启了位置权限:YES开启了，NO没有
 
 @return 结果
 */
+(BOOL)isOpen_Location;

@end

