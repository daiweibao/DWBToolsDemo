//
//  DWBAlertView.h
//  DWBToolsDemo
//
//  Created by 戴维保 on 2018/9/8.
//  Copyright © 2018年 北京嗅美科技有限公司. All rights reserved.
//

//我的弹窗总类

#import <Foundation/Foundation.h>

@interface DWBAlertView : NSObject


/**
 自己封装的aleat总类 type暂时还没用到
 
 @param controller 弹窗所在控制器
 @param title 标题
 @param message 内容
 @param array 按钮
 @param type 类型，1代表允许重复弹窗 ,2代表允许移除老的弹窗，展示新的弹窗（推送用）
 @param blockAlert 回调
 */
+ (void)AlertCXAlertCenterAllWithController:(UIViewController*)controller Title:(NSString*)title Message:(NSString *)message otherItemArrays:(NSArray *)array Type:(NSInteger)type handler:(void(^)(NSInteger index))blockAlert;



/**
 自己封装的aleatSheet【底部】弹框
 
 @param controller 弹窗所在控制器
 @param title 标题
 @param array 数组，不包含取消按钮
 @param redIndex 让那一按钮变红。-1代表都不变红
 @param isShow 是否展示取消按钮
 @param cancetitle 取消按钮的标题
 @param type 类型，-1代表默认， 0代表成功（默认成功） 1代表失败  100代表允许重复弹窗 ,200代表允许移除老的弹窗，展示新的弹窗（推送用）
 @param blockAlert 回调点击了那个按钮从上到下，包含取消按钮依次是0，1.....
 */
+ (void)AlertMyCXSheetAllViewWithController:(UIViewController*)controller Title:(NSString*)title otherItemArrays:(NSArray *)array ShowRedindex:(NSInteger )redIndex isShowCancel:(BOOL)isShow CancelTitle:(NSString*)cancetitle Type:(NSInteger)type handler:(void(^)(NSInteger index))blockAlert;


/**
 AFN其他错误弹窗提示【AFN专用】
 
 @param responseObject AFN数据，包含错误信息那个字典
 */
+(void)alertAFNErrorWithResponseObject:(id)responseObject;


@end
