//
//  CXHUDLoading.h
//  aaa
//
//  Created by 季文斌 on 2023/10/26.
//  Copyright © 2023 Alibaba. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CXHUDLoading : NSObject

+ (CXHUDLoading *)sharedManager;

/// loding加载中
/// - Parameters:
///   - title: 标题
///   - view: 添加到那一块view上
+ (void)showLoadingWithTitle:(NSString *)title toView:(UIView *)view;

///移除loading
+ (void)hideHUDLoading;

@end

NS_ASSUME_NONNULL_END
