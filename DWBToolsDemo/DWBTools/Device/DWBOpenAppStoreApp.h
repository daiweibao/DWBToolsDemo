//
//  DWBOpenAppStoreApp.h
//  miniVideo
//
//  Created by chaoxi on 2020/4/27.
//  Copyright © 2020 北京chaoxi科技有限公司. All rights reserved.
//
//内部打开AppStore应用
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
//打开AppStore后点击取消按钮回调
typedef void (^actionAppStoreCloseBlock)(void);

@interface DWBOpenAppStoreApp : NSObject
//初始化Block
@property (nonatomic, copy) actionAppStoreCloseBlock actionClose;

///单例初始化
+ (instancetype)sharedManager;

/// App内部打开AppStore,传入对应App的AppId
/// @param appId AppId
/// @param block 取消按钮回调
- (void)openAppStoreWithAppId:(NSString*)appId CompleteActionClose:(actionAppStoreCloseBlock) block;

/// App外部打开AppStore，传入Http地址
- (void)openAppStoreOutWithUrl:(NSString *)appUrl;

@end

NS_ASSUME_NONNULL_END
