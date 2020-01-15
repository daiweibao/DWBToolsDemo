//
//  UILabel+Click.h
//  DWBToolsDemo
//
//  Created by 戴维保 on 2018/9/12.
//  Copyright © 2018年 潮汐科技有限公司. All rights reserved.
//
//label点击指定文字，并回调点击方法
#import <UIKit/UIKit.h>


@protocol YBAttributeTapActionDelegate <NSObject>
@optional
/**
 *  YBAttributeTapActionDelegate
 *
 *  @param string  点击的字符串
 *  @param range   点击的字符串range
 *  @param index 点击的字符在数组中的index
 */
- (void)dwb_attributeTapReturnString:(NSString *)string
                              range:(NSRange)range
                              index:(NSInteger)index;
@end

@interface YBAttributeModel : NSObject

@property (nonatomic, copy) NSString *str;

@property (nonatomic, assign) NSRange range;

@end


#pragma mark =========== 上面是代理方法===================

@interface UILabel (Click)


/**
 *  是否打开点击效果，默认是打开
 */
@property (nonatomic, assign) BOOL enabledTapEffect;

/**
 *  给文本添加点击事件Block回调
 *
 *  @param strings  需要添加的字符串数组
 *  @param tapClick 点击事件回调
 */
- (void)dwb_addAttributeTapActionWithStrings:(NSArray <NSString *> *)strings
                                 tapClicked:(void (^) (NSString *string , NSRange range , NSInteger index))tapClick;

/**
 *  给文本添加点击事件delegate回调
 *
 *  @param strings  需要添加的字符串数组
 *  @param delegate delegate
 */
- (void)dwb_addAttributeTapActionWithStrings:(NSArray <NSString *> *)strings
                                   delegate:(id <YBAttributeTapActionDelegate> )delegate;

@end
