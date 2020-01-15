//
//  DWBAFNetworking.m
//  DWBToolsDemo
//
//  Created by 戴维保 on 2018/9/6.
//  Copyright © 2018年 潮汐科技有限公司. All rights reserved.
//

#import "DWBAFNetworking.h"

static NSString const * YZNetworkState = @"NO";//网络状态，可变
static NSTimeInterval YZnetworkChange = 0;//网络是否改变过

//单例
static AFHTTPSessionManager *manager;

@implementation DWBAFNetworking


//用单例防止重复创建造成内存泄露
+ (AFHTTPSessionManager *)sharedManager {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 初始化请求管理类
        manager = [AFHTTPSessionManager manager];
        
        //如果出现415错误，那么申明请求的数据是json类型必须打开）：Request failed: unsupported media type (415)
        //申明请求的数据是json类型
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        
        //申明返回的结果是json类型(可选，没报错就不用打开)
//          manager.responseSerializer = [AFJSONResponseSerializer serializer];
//         [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//
        // 支持内容格式
        manager.responseSerializer.acceptableContentTypes  =  [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain",@"application/xml", nil];
        
        
    });
    return manager;
}

/**
 AFNetworking二次封装-POST
 
 @param URLString 请求接口
 @param parameters 接口参数-字典
 @param controller 当前控制器
 @param type 类型
 @param results 请求成功结果
 @param MyError 失败结果
 */
+(void)POST:(NSString *_Nullable)URLString parameters:(id _Nullable )parameters controller:(UIViewController*)controller type:(NSString *)type success:(void (^_Nullable)(id _Nullable responseObject))results failure:(void (^_Nullable)(NSError * _Nullable error))MyError{
    //    errorMsg 错误提示
    //必须控制器
    if (![controller isKindOfClass:[UIViewController class]]) {
        //如果控制器不存在就用跟控制器
        controller = [UIApplication sharedApplication].keyWindow.rootViewController;
    }
    //系统的
    //    AFHTTPSessionManager * manager=[AFHTTPSessionManager manager];
    //    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"application/json"];
    
    //调用自己的单例，防止内存泄露
    AFHTTPSessionManager * manager =  [DWBAFNetworking sharedManager];
    
    
    
    [manager GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //所有情况都回调请求结果
        if (results) {
            results(responseObject);
        }
        
        /*
         //其他错误提示
         [AlertCXView AlertCXAlertCenterAllWithController:self Title:responseObject[@"errorMsg"] Message:nil otherItemArrays:@[@"知道啦"]  Type:-1 handler:^(NSInteger index) {}];
         
         */
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
          
            
        });
        
        //数据请求失败
        NSLog(@"数据请求失败：%@",error.localizedDescription);
        if (MyError) {
            MyError(error);
        }
        
        NSLog(@"404接口：%@",URLString);
        
    }];
    
    
}


/**
 是否有网，返回NO代表没网，YES有网

 @return 结果
 */
+ (BOOL)isHaveNetwork {
    return [AFNetworkReachabilityManager sharedManager].reachable;
}


#pragma mark - 网络监听
/**
 监听网络状态,在AppDelegate里调用
 */
+ (void)yz_currentNetStates {
    
    AFNetworkReachabilityManager *manger = [AFNetworkReachabilityManager sharedManager];
    
    [manger setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        /*
         AFNetworkReachabilityStatusUnknown          = -1,
         AFNetworkReachabilityStatusNotReachable     = 0,
         AFNetworkReachabilityStatusReachableViaWWAN = 1,
         AFNetworkReachabilityStatusReachableViaWiFi = 2,
         */
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                YZNetworkState = @"NO";
                YZnetworkChange = 1;
                break;
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"没有网络");
                YZNetworkState = @"NO";
                YZnetworkChange = 1;
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"3G|4G");
                YZNetworkState = @"4G";
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"WiFi");
                YZNetworkState = @"WIFI";
                break;
            default:
                break;
        }
        if (![YZNetworkState isEqualToString:@"NO"]) {
            //有网
        }
        
        if (![YZNetworkState isEqualToString:@"NO"] && YZnetworkChange) {
            YZnetworkChange = 0;
            //发出网络状态改变的通知，从没网到有网
            [[NSNotificationCenter defaultCenter] postNotificationName:@"YZ_networkChange" object:nil];
        }
    }];
    [manger startMonitoring];//开始监听
}


@end
