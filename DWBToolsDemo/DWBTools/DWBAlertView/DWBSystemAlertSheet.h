//
//  DWBSystemAlertSheet.h
//  DWBToolsDemo
//
//  Created by chaoxi on 2020/1/2.
//  Copyright © 2020 chaoxi科技有限公司. All rights reserved.
//
///系统底部弹窗
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DWBSystemAlertSheet : NSObject

/**
 自己封装的aleatSheet【底部】弹框
 
 @param title 标题
 @param array 数组，不包含取消按钮
 @param redIndex 让那一按钮变红。-1代表都不变红
 @param isShow 是否展示取消按钮
 @param cancetitle 取消按钮的标题
 @param type 类型，-1代表默认
 @param blockAlert 回调点击了那个按钮从上到下，包含取消按钮依次是0，1.....
 */
+ (void)AlertMySystemAlertSheetWithTitle:(NSString*)title otherItemArrays:(NSArray *)array ShowRedindex:(NSInteger )redIndex isShowCancel:(BOOL)isShow CancelTitle:(NSString*)cancetitle Type:(NSInteger)type handler:(void(^)(NSInteger index))blockAlert;

@end

NS_ASSUME_NONNULL_END
