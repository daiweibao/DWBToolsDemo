//
//  DWBAFNetworking.h
//  DWBToolsDemo
//
//  Created by 爱恨的潮汐 on 2018/9/6.
//  Copyright © 2018年 潮汐科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
@interface DWBAFNetworking : NSObject
//自己封装afn单例
+ (AFHTTPSessionManager *)sharedManager;

/**
 AFNetworking二次封装-POST
 
 @param URLString 请求接口
 @param parameters 接口参数-字典
 @param controller 当前控制器，传入nil也可以
 @param type 类型
 @param results 请求成功结果
 @param MyError 失败结果
 */
+(void)POST:(NSString *_Nullable)URLString parameters:(id _Nullable )parameters controller:(UIViewController*)controller type:(NSString *)type success:(void (^_Nullable)(id _Nullable responseObject))results failure:(void (^_Nullable)(NSError * _Nullable error))MyError;

/**
 是否有网，返回NO代表没网，YES有网
 
 @return 结果
 */
+ (BOOL)isHaveNetwork;

@end
