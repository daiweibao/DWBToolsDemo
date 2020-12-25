//
//  CXDinDinEventMessageHelp.h
//  cx
//
//  Created by chaoxi on 2020/10/16.
//  Copyright © 2020 chaoxi科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CXDinDinEventMessageHelp : NSObject

+ (instancetype)sharedInstance;

///开始记录，必须要初始化,可以在AppDelegate里初始化
- (void)startTimer;

@end

NS_ASSUME_NONNULL_END
/*
 //AppDelegate里钉钉操作消息统计-初始化,AppDelegate里必须实现相应的代理方法(applicationDidBecomeActive、applicationDidEnterBackground)，否则会崩溃
 [[CXDinDinEventMessageHelp sharedInstance] startTimer];
 
 依赖pod:
 #钉钉消息
 pod 'RSSwizzle'
 */
