//
//  DWBAlretCXSheetView.h
//  AiHenDeChaoXi
//
//  Created by 戴维保 on 2018/4/20.
//  Copyright © 2018年 潮汐科技有限公司. All rights reserved.
//
//自己封装的底部弹窗
#import <UIKit/UIKit.h>

typedef void (^ActionBlockAtIndex)(NSInteger index);

@interface DWBAlretCXSheetView : UIView
///回调经按钮tage
@property (nonatomic, copy) ActionBlockAtIndex actionBlockAtIndex;

/**
 自己封装的aleatSheet底部弹框
 
 @param controller 弹窗所在控制器
 @param title 标题
 @param array 数组，不包含取消按钮
 @param redIndex 让那一按钮变红,-1代表都不变红
 @param isShow 是否展示取消按钮
 @param cancetitle 取消按钮的标题
 @param type 类型，-1代表默认 0代表成功（默认成功） 1代表失败  100代表允许重复弹窗 ,200代表允许移除老的弹窗，展示新的弹窗（推送用）300控制器不在屏幕中也能弹窗
 @param block 回调点击了那个按钮从上到下，包含取消按钮依次是0，1.....
 */
+ (void)AlertMyCXSheetViewWithController:(UIViewController*)controller Title:(NSString*)title otherItemArrays:(NSArray *)array ShowRedindex:(NSInteger )redIndex isShowCancel:(BOOL)isShow CancelTitle:(NSString*)cancetitle Type:(NSInteger)type handler:(ActionBlockAtIndex)block;

@end
