//
//  DWBOpenAppStoreApp.m
//  miniVideo
//
//  Created by 戴维保 on 2020/4/27.
//  Copyright © 2020 北京赢响国际科技有限公司. All rights reserved.
//

#import "DWBOpenAppStoreApp.h"
//内部打开app需要导入头文件
#import<StoreKit/StoreKit.h>

@interface DWBOpenAppStoreApp()<SKStoreProductViewControllerDelegate>

@end

@implementation DWBOpenAppStoreApp

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

//单例初始化
+ (instancetype)sharedManager {
    static DWBOpenAppStoreApp * manager;//控制器
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[DWBOpenAppStoreApp alloc] init];
    });
    return manager;
}
///App内部打开AppStore,传入对应App的AppId
- (void)openAppStoreWithAppId:(NSString*)appId CompleteActionClose:(actionAppStoreCloseBlock) block {
    self.actionClose = block;//赋值
    SKStoreProductViewController*storeProductVC =[[SKStoreProductViewController alloc] init];
    storeProductVC.delegate=self;
    NSDictionary*dict = [NSDictionary dictionaryWithObject:appId forKey:SKStoreProductParameterITunesItemIdentifier];
    [storeProductVC loadProductWithParameters:dict completionBlock:^(BOOL result,NSError*_Nullableerror) {
        if(result) {
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:storeProductVC animated:YES completion:nil];
        }
    }];
}
#pragma mark -点击关闭按钮
-(void)productViewControllerDidFinish:(SKStoreProductViewController*)viewController{
    NSLog(@"关闭界面");
    [viewController dismissViewControllerAnimated:YES completion:nil];
    //回调
    if (self.actionClose) {
        self.actionClose();
    }
}


#pragma mark ===========打开AppStore外部===========
- (void)openAppStoreOutWithUrl:(NSString *)appUrl{
    if (@available(iOS 10.0, *)) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:appUrl] options:@{} completionHandler:^(BOOL success) {
            //打开成功
        }];
    } else {
        // Fallback on earlier versions
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:appUrl]];
    }
}


#pragma mark =======用法
/**
 [[DWBOpenAppStoreApp sharedManager] openAppStoreWithAppId:AppstoreId CompleteActionClose:^{
 
 }];
 
 */

@end
