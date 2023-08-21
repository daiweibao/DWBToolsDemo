//
//  CXHttpTool.h
//  DWBToolsDemo
//
//  Created by 季文斌 on 2023/8/21.
//  Copyright © 2023 潮汐科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

NS_ASSUME_NONNULL_BEGIN

@interface CXHttpTool : NSObject
//
+ (AFHTTPSessionManager *)sharedManager;

/**
 post请求-客户端

 @param url 接口地址，如：homePageQry.do
 @param para 参数
 @param show 是否显示遮罩
 @param showMsg 是否弹窗显示错误信息
 @param successBlock 成功回调
 @param failureBlock 失败回调
 */
+ (void)postWithURL:(NSString *)url Parameters:(NSDictionary *)para ShowHUD:(BOOL)show ShowErrorMsg:(BOOL)showMsg Success:(void(^)(BOOL isSuccess,id data))successBlock Failure:(void(^)(NSError * _Nonnull error))failureBlock;


/**
 是否有网（可能不准），返回NO代表没网，YES有网
 
 @return 结果
 */
+ (BOOL)isHaveNetwork;

@end

NS_ASSUME_NONNULL_END

/**
 //使用
 [CXHttpTool postWithURL:@"home.do" Parameters:@{} ShowHUD:YES ShowErrorMsg:YES Success:^(BOOL isSuccess, id  _Nonnull data) {
     if(!isSuccess){
         return;
     }
     //在这里处理数据
     
 } Failure:^(NSString * _Nonnull errorMessage) {
     
 }];
 
 */
