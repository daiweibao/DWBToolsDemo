//
//  CXHttpTool.m
//  DWBToolsDemo
//
//  Created by 季文斌 on 2023/8/21.
//  Copyright © 2023 潮汐科技有限公司. All rights reserved.
//

#import "CXHttpTool.h"

@interface CXHttpTool ()

@end

@implementation CXHttpTool

//用单例防止重复创建造成内存泄露
+ (AFHTTPSessionManager *)sharedManager {
    static AFHTTPSessionManager * manager;//
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 初始化请求管理类
        manager = [AFHTTPSessionManager manager];
        
        //如果出现415错误，那么申明请求的数据是json类型必须打开）：Request failed: unsupported media type (415)
        //申明请求的数据是json类型
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        
        //申明返回的结果是json类型(可选，没报错就不用打开)
        //  manager.responseSerializer = [AFJSONResponseSerializer serializer];
        // [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        // 支持内容格式
//        manager.responseSerializer.acceptableContentTypes  =  [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain",@"application/xml", nil];
        manager.responseSerializer.acceptableContentTypes =  [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/plain",@"text/html",@"text/css", nil];
        
    });
    return manager;
}


/**
 post请求-客户端

 @param url 接口地址，如：homePageQry.do
 @param para 参数
 @param show 是否显示遮罩
 @param showMsg 是否弹窗显示错误信息
 @param successBlock 成功回调
 @param failureBlock 失败回调
 */
+ (void)postWithURL:(NSString *)url Parameters:(NSDictionary *)para ShowHUD:(BOOL)show ShowErrorMsg:(BOOL)showMsg Success:(void(^)(BOOL isSuccess,id data))successBlock Failure:(void(^)(NSError * _Nonnull error))failureBlock{
    if (show) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD showHUDLodingStart:@"加载中..." toView:[UIViewController getCurrentVC].view];
        });
    }
    //调用自己的单例，防止内存泄露
    AFHTTPSessionManager * manager =  [CXHttpTool sharedManager];
    [manager POST:url parameters:para headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (show) {
                [MBProgressHUD hideHUDForView:[UIViewController getCurrentVC].view];//隐藏HUD
            }
            //成功
            NSDictionary * responseDict = CXSafeDic(responseObject);//response可能是字符串数组之类的，防止崩溃
            NSString * RejCode = [NSString stringWithFormat:@"%@",responseDict[@"_RejCode"]];//错误码
            NSString * msg = [NSString stringWithFormat:@"%@",responseDict[@"_RejMsg"]];//提示语
            
            if ([RejCode isEqualToString:@"000000"]){
                //成功
                if (successBlock) {
                    successBlock(YES,responseDict);
                }
            }else{
                //接口调用成功--但是业务不完全成功弹窗报错，拦截器DTRpcCommonInterceptor里拦截了一些错误提示，这里只处理一部分
                //回调
                if (successBlock) {
                    successBlock(NO,responseDict);
                }
                //
                if (showMsg) {
                    //展示错误提示，需要过滤掉会话超时的情况，会话超时，在拦截器DTRpcCommonInterceptor里处理
                    if([CXHttpTool isLoginTimeOutWithRejCode:RejCode AndUrl:url]==NO){
                        //非会话超时提示
                        [CXAlertCXCenterView AlertCXCenterAlertWithController:[UIViewController getCurrentVC] Title:@"提示" Message:msg otherItemArrays:@[@"知道啦"] Type:-1 handler:^(NSInteger indexCenter) {
                            
                        }];
                    }else{
                        //会话超时处理，弹窗内部自动处理重复弹出
                        [CXAlertCXCenterView AlertCXCenterAlertWithController:[UIViewController getCurrentVC] Title:@"提示" Message:msg otherItemArrays:@[@"去登录"] Type:-1 handler:^(NSInteger indexCenter) {
                            if(indexCenter==0){
                                //去登录
                            }
                        }];
                    }
                }
            }
            
        });
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (show) {
                [MBProgressHUD hideHUDForView:[UIViewController getCurrentVC].view];//隐藏HUD
            }
            //网络请求失败
            //网络请求取消：NSURLErrorCancelled
            if ((error.code == NSURLErrorCancelled)) {
                //网络请求取消的情况不做任何处理
            }else{
                if (failureBlock) {
                    failureBlock(error);
                }
                if (showMsg) {
                    //
                    [CXAlertCXCenterView AlertCXCenterAlertWithController:[UIViewController getCurrentVC] Title:@"提示" Message:error.localizedDescription otherItemArrays:@[@"知道啦"] Type:-1 handler:^(NSInteger indexCenter) {
                        
                    }];
                }
            }
        });
    }];
}

/// 是否会话超时：YES代表会话超时
/// - Parameters:
///   - RejCode: 错误码
///   - urlPath: 网络请求接口
+ (BOOL)isLoginTimeOutWithRejCode:(NSString *)RejCode AndUrl:(NSString *)urlPath{
    //会话超时，设备被顶
    if([RejCode isEqualToString:@"700000"]||//会话超时错误码1
       [RejCode isEqualToString:@"800000"]//会话超时错误码2
       ){
        ////登录时的查询接口除外
        if (![urlPath isEqualToString:@"query.login.do"] &&//过滤：获取所有登录方式接口
            ![urlPath isEqualToString:@"query.logintype.do"]//过滤：默认登录方式接口查询
            ) {
            return YES;//会话超时
        }
        return NO;
    }
    return NO;
}

/**
 是否有网，返回NO代表没网，YES有网

 @return 结果
 */
+ (BOOL)isHaveNetwork {
    return [AFNetworkReachabilityManager sharedManager].reachable;
}

@end
