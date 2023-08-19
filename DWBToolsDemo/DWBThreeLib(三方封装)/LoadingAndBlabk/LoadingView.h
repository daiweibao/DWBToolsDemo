//
//  LoadingView.h
//  XiaoYuanSheQu
//
//  Created by 爱恨的潮汐 on 16/9/12.
//  Copyright © 2016年 潮汐科技有限公司. All rights reserved.
//
//封装的加载中和加载失败网络提示
#import <UIKit/UIKit.h>

@interface LoadingView : UIView

/**
 加载失败的回调
 */
@property (nonatomic,copy)void (^loadingfailureRefresh)(void);

/**
 封装方法，传入起始坐标和高度，是否创建返回键 就可以-外部调用

 @param controller 控制器self
 @param isBack 是否要创建返回按钮
 @param max_Y 控件Y的最大坐标
 @param height 控件高度
 @param loadeFailure 加载失败后的点击事件回调
 */
+(void)loadingView:(UIViewController*)controller isCreateBack:(BOOL)isBack viewMaxY:(CGFloat)max_Y viewHeight:(CGFloat)height LoadeFailure:(void (^)(void))loadeFailure;


/**
 加载失败UI--外部调用
 
 @param controller 当前控制器
 */
+(void)loadingfailureUIWithController:(UIViewController*)controller;


/**
 *  移除加载中——控制器传进去+填self-外部调用
 */
+(void)removeLoadingController:(UIViewController*)controller;

@end
