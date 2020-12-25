//
//  AppCerashOpenHelp.h
//  BXJianZhi
//
//  Created by chaoxi on 2020/11/14.
//  Copyright © 2020 chaoxi科技有限公司. All rights reserved.
//
///掌控开关
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AppCerashOpenHelp : NSObject
+ (instancetype)sharedManager;
@end

/**
 ///AppDelegate里初始化崩溃类
 [AppCerashOpenHelp sharedManager];
 
 */

NS_ASSUME_NONNULL_END
