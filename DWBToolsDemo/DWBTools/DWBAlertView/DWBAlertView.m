//
//  DWBAlertView.m
//  DWBToolsDemo
//
//  Created by 爱恨的潮汐 on 2018/9/8.
//  Copyright © 2018年 潮汐科技有限公司. All rights reserved.
//

#import "DWBAlertView.h"
#import "AlertCXCenterView.h"//中间弹窗
#import "AlertViewTool.h"//底部弹窗


@implementation DWBAlertView


/**
 自己封装的aleat总类【在中间弹窗】 type暂时还没用到
 
 @param controller 弹窗所在控制器
 @param title 标题
 @param message 内容
 @param array 按钮
 @param type 类型，1代表允许重复弹窗 ,2代表允许移除老的弹窗，展示新的弹窗（推送用）
 @param blockAlert 回调
 */
+ (void)AlertCXAlertCenterAllWithController:(UIViewController*)controller Title:(NSString*)title Message:(NSString *)message otherItemArrays:(NSArray *)array Type:(NSInteger)type handler:(void(^)(NSInteger index))blockAlert{
    
    //自己封装的【中间】弹窗，以后在这里修改替换成其他弹窗就好，换成系统的也可以
    [AlertCXCenterView AlertCXCenterAlertWithController:controller Title:title Message:message otherItemArrays:array Type:type handler:^(NSInteger indexCenter) {
        if (blockAlert) {
            blockAlert(indexCenter);
        }
    }];
    
    
//    //系统的
//    [AlertViewTool AlertAlertWithTitle:title Message:message otherItemArrays:array viewController:[UIApplication sharedApplication].keyWindow.rootViewController handler:^(NSInteger index) {
//        if (blockAlert) {
//            blockAlert(index);
//        }
//
//    }];
}






/**
 自己封装的aleatSheet【底部】弹框
 
 @param controller 弹窗所在控制器
 @param title 标题
 @param array 数组，不包含取消按钮
 @param redIndex 让那一按钮变红。-1代表都不变红
 @param isShow 是否展示取消按钮
 @param cancetitle 取消按钮的标题
 @param type 类型，-1代表默认， 0代表成功（默认成功） 1代表失败  100代表允许重复弹窗 ,200代表允许移除老的弹窗，展示新的弹窗（推送用） 300控制器不在屏幕中也能弹窗
 @param blockAlert 回调点击了那个按钮从上到下，包含取消按钮依次是0，1.....
 */
+ (void)AlertMyCXSheetAllViewWithController:(UIViewController*)controller Title:(NSString*)title otherItemArrays:(NSArray *)array ShowRedindex:(NSInteger )redIndex isShowCancel:(BOOL)isShow CancelTitle:(NSString*)cancetitle Type:(NSInteger)type handler:(void(^)(NSInteger index))blockAlert{
    
//    //自己封装的【底部】弹窗，以后在这里修改替换成其他弹窗就好，换成系统的也可以
//    [AlertViewTool AlertMyCXSheetViewWithController:controller Title:title otherItemArrays:array ShowRedindex:redIndex isShowCancel:isShow CancelTitle:cancetitle Type:type handler:^(NSInteger indexShee) {
//        if (blockAlert) {
//            blockAlert(indexShee);
//        }
//    }];
    
    //类似微信底部弹窗
    [AlertViewTool AlertWXSheetToolWithTitle:title otherItemArrays:array ShowRedindex:redIndex CancelTitle:cancetitle handler:^(NSInteger indexShee) {
        if (blockAlert) {
            blockAlert(indexShee);
        }
        
    }];
    
}


/**
 AFN其他错误弹窗提示
 
 @param responseObject AFN数据，包含错误信息那个字典
 */
+(void)alertAFNErrorWithResponseObject:(id)responseObject{
    
    //AFN其他错误提示
    NSString * msg = @"";
    if ([NSString isNULL:responseObject[@"errorMsg"]]==NO) {
        msg = responseObject[@"errorMsg"];
    }
    NSString * code = @"";
    if ([NSString isNULL:responseObject[@"code"]]==NO) {
        code = [NSString stringWithFormat:@"[%@]",responseObject[@"code"]];
    }
    //弹窗
    [DWBAlertView AlertCXAlertCenterAllWithController:[UIApplication sharedApplication].keyWindow.rootViewController Title:nil Message:[NSString stringWithFormat:@"%@%@",msg,code] otherItemArrays:@[@"知道啦"] Type:-1 handler:^(NSInteger index) {}];
}




@end
