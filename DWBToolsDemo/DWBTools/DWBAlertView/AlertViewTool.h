//
//  AlertViewTool.h
//  AlertActiionDemo
//
//  Created by Max on 16/8/30.
//  Copyright © 2016年 maxzhang. All rights reserved.
//
//弹窗提示类
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//类似微信底部弹窗
#import "JXActionSheet.h"

typedef void (^ActionBlockAtIndex)(NSInteger index);

@interface AlertViewTool : NSObject

@property (nonatomic, copy) ActionBlockAtIndex actionBlockAtIndex;


/**
 *  UIAlertControllerStyleAlert，多个按钮（中间提示) viewController填self
 *
 *  @param title      标题
 *  @param message    内容
 *  @param array      按钮数组
 *  @param controller 控制器
 *  @param block      block
 *
 *  @return 任意
 */
+ (id)AlertAlertWithTitle:(NSString*)title Message:(NSString *)message otherItemArrays:(NSArray *)array viewController:(UIViewController *)controller handler:(ActionBlockAtIndex)block;

//用法
//    UIAlertControllerStyleAlert
//[AlertViewTool AlertAlertWithTitle:@"标题" Message:@"这是一条消息" otherItemArrays:@[@"按钮1", @"按钮2"] viewController:self handler:^(NSInteger index) {
//    
//    if (index == 0) {
//        NSLog(@"点击了按钮1");
//    }
//    else if (index == 1) {
//        NSLog(@"点击了按钮2");
//    }
//    
//}];



/**
 *  UIAlertControllerStyleActionSheet 多个按钮（底部） isShowCancel==是否展示取消按钮，yes表示展示
 *
 *  @param title      标题
 *  @param message    内容
 *  @param array      按钮数组
 *  @param controller 控制器 填 self
 *  @param block      block
 *  @param isShow     是否显示删除按钮
 *  @param cancetitle 删除按钮的名字
 *
 *  @return 任意
 */

+ (id)AlertSheetToolWithTitle:(NSString*)title Message:(NSString *)message otherItemArrays:(NSArray *)array viewController:(UIViewController *)controller handler:(ActionBlockAtIndex)block isShowCancel:(BOOL)isShow CancelTitle:(NSString*)cancetitle;

//用法
//   UIAlertControllerStyleActionSheet
//    [AlertViewTool AlertSheetToolWithTitle:@"标题" Message:@"这是一条消息" otherItemArrays:@[@"按钮1", @"按钮2", @"按钮3"] viewController:self handler:^(NSInteger index) {
//        if (index == 0) {
//                NSLog(@"点击了按钮1");
//            }
//            else if (index == 1) {
//                NSLog(@"点击了按钮2");
//            }
//            else if (index == 2) {
//                NSLog(@"点击了按钮3");
//            }
//            else if (index == 2) {
//                NSLog(@"点击了取消");
//            }
//
//    } isShowCancel:YES CancelTitle:@"取消"];


/**
 用tableview封装的类似微信底部弹窗,redIndex为-1表示不显示红色按钮

 @param title 标题
 @param array 按钮数组
 @param block 回调block
 @param redIndex 让哪一个按钮变红，,-1代表都不变红
 @param cancetitle 取消按钮的汉字，为nil室不显示
 @return aler
 */
+(id)AlertWXSheetToolWithTitle:(NSString*)title otherItemArrays:(NSArray *)array ShowRedindex:(NSInteger )redIndex CancelTitle:(NSString*)cancetitle handler:(ActionBlockAtIndex)block;

//用法
//[AlertViewTool AlertWXSheetToolWithTitle:@"这是一条消息" otherItemArrays:@[@"第一个按钮",@"第二个"] ShowRedindex:-1 CancelTitle:@"取消" handler:^(NSInteger index) {
//    NSLog(@"%ld",(long)index);
//}];



/**
 自己封装的aleatSheet底部弹框
 
 @param controller 弹窗所在控制器
 @param title 标题
 @param array 数组，不包含取消按钮
 @param redIndex 让那一按钮变红。-1代表都不变红
 @param isShow 是否展示取消按钮
 @param cancetitle 取消按钮的标题
 @param type 类型，-1代表默认， 0代表成功（默认成功） 1代表失败  100代表允许重复弹窗 ,200代表允许移除老的弹窗，展示新的弹窗（推送用）
 @param block 回调点击了那个按钮从上到下，包含取消按钮依次是0，1.....
 */
+ (void)AlertMyCXSheetViewWithController:(UIViewController*)controller Title:(NSString*)title otherItemArrays:(NSArray *)array ShowRedindex:(NSInteger )redIndex isShowCancel:(BOOL)isShow CancelTitle:(NSString*)cancetitle Type:(NSInteger)type handler:(ActionBlockAtIndex)block;

/*
 //用法
 [AlertViewTool AlertMyCXSheetViewWithController:self Title:@"确定要退出？" otherItemArrays:@[@"确定",@"我在想想"] ShowRedindex:0 isShowCancel:YES CancelTitle:@"取消" Type:-1 handler:^(NSInteger index) {
 NSLog(@"%ld",index);
 }];
 */


@end
