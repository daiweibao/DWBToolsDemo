//
//  JHViewLoading.h
//  XiaoYuanSheQu
//
//  Created by 戴维保 on 2016/11/16.
//  Copyright © 2016年 北京嗅美科技有限公司. All rights reserved.
//
//小菊花加载
#import <UIKit/UIKit.h>

@interface JHViewLoading : UIView
//创建ActivityIndicatorView
+(void)createActivityIndicatorView:(UIView*)view Type:(NSString *)type;
//开始加载ActivityIndicatorView
+(void)startActivityIndicatorView:(UIView*)view;
//结束加载ActivityIndicatorView
+(void)endActivityIndicatorView:(UIView*)view;

@end
