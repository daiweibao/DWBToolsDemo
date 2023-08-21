//
//  DWBAppStoreGetData.m
//  DouZhuan
//
//  Created by 爱恨的潮汐 on 2018/11/1.
//  Copyright © 2018 品创时代互联网科技（北京）有限公司. All rights reserved.
//

#import "DWBAppStoreGetData.h"

@interface DWBAppStoreGetData()
//请求结果
@property(nonatomic,copy)void(^getAppStoreData)(BOOL isAppStoreSHTime);

@end


@implementation DWBAppStoreGetData


- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

/**
 请求数据判断是否是App Store审核期间:YES表示是审核期间
 */

+(void)getAppStoreDataWithCompletion:(void(^)(BOOL isAppStoreSHTime))completion{
    static DWBAppStoreGetData * manager;//控制器
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[DWBAppStoreGetData alloc] init];
    });
    
    //block
    manager.getAppStoreData = completion;
    
    //请求数据
    [manager updateAppStoreVersion];

}


#pragma mark ==================从App Store获取信息 S===========================
/**
 从appStore获取版本信息,用来审核期间判断影藏一些东西
 */
-(void)updateAppStoreVersion{
    //com.xiumei.GongXiangJie 1268925096
    //取得AppStore信息 https://itunes.apple.com/lookup?bundleId=com.xiumei.GongXiangJie,如果是在中国地区上架的，要加上cn/，https://itunes.apple.com/cn/lookup?bundleId=com.xiumei.GongXiangJie
    //根据BundleId获取是最有效的，,只在中国地区上架的app必须加上/cn,不然只在中国地区上架的app无法获取到数据，间书：https://www.jianshu.com/p/3bb2d0b22d78
    
    //正式
    NSString * pathChina = [NSString stringWithFormat:@"https://itunes.apple.com/cn/lookup?bundleId=%@",GET_BundleId];
    
    //测试
//      NSString * pathChina = [NSString stringWithFormat:@"https://itunes.apple.com/cn/lookup?bundleId=%@",@"com.top.quanmin.app"];
    
    //调用自己的单例，防止内存泄露，必须先在中国地区获取app信息(不然加载慢，因为大部分app都在中国地区上架)，如果获取不到再去美国地区获取
    AFHTTPSessionManager * manager =  [CXHttpTool sharedManager];
    [manager POST:pathChina parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"中国地区数据：%@",responseObject);
        //判断在中国地区能否获取到APP数据
        NSArray * arrayAppInfo = responseObject[@"results"];
        if ([responseObject[@"resultCount"] integerValue]  == 0 || arrayAppInfo.count==0) {
            //去美国地区获取app信息
            [self theUSAGetAppInfoLoad];
            
        }else{
            //在中国地区获取到了app信息，创建弹窗
            [self getEndAppStoreData:responseObject];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.getAppStoreData) {
            self.getAppStoreData(NO);
        }
        
        //审核状态赋值
        [DWBAPPManager sharedManager].isAppStoreSHTime = NO;
        
    }];
}

//在美国地区获取app信息
-(void)theUSAGetAppInfoLoad{
    //调用自己的单例，防止内存泄露，在美国地区获取app信息
    AFHTTPSessionManager * manager =  [CXHttpTool sharedManager];
    //在中国地区获取不到app信息，然后再去美国地区获取
     NSString * pathUSA = [NSString stringWithFormat:@"https://itunes.apple.com/lookup?bundleId=%@",GET_BundleId];
    [manager POST:pathUSA parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        dispatch_async(dispatch_get_main_queue(), ^{
//              NSLog(@"美国地区数据：%@",responseObject);
            //在美国地区获取到了app信息，创建弹窗
            [self getEndAppStoreData:responseObject];
        });
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.getAppStoreData) {
            self.getAppStoreData(NO);
        }
        //审核状态赋值
        [DWBAPPManager sharedManager].isAppStoreSHTime = NO;
    }];
}

//最终得到数据
-(void)getEndAppStoreData:(id)responseObject{
    //    [SVProgressHUD dismiss];//移除
    //判断能否获取到数据
    if ([responseObject[@"resultCount"] integerValue]  == 0) {
        //app没上架获取不到数据
        NSLog(@"当前app还没上架，在AppStore无法获取信息~");
        if (self.getAppStoreData) {
            self.getAppStoreData(YES);
        }
        //审核状态赋值
        [DWBAPPManager sharedManager].isAppStoreSHTime = YES;
        return;
    }
    //数据
    NSArray * arrayAppInfo = responseObject[@"results"];
    if (arrayAppInfo.count==0) {
        //获取不到数据
        NSLog(@"在AppStore无法获取信息~");
        if (self.getAppStoreData) {
            self.getAppStoreData(YES);
        }
        //审核状态赋值
        [DWBAPPManager sharedManager].isAppStoreSHTime = YES;
        return;
    }
    //appStore版本号
    NSString * appStoreVersion = arrayAppInfo.firstObject[@"version"];
    //判断能否获取到版本号,获取不到就返回
    if ([NSString isNULL:appStoreVersion]) {
        NSLog(@"在AppStore无法获取app版本号");
        if (self.getAppStoreData) {
            self.getAppStoreData(YES);
        }
        //审核状态赋值
        [DWBAPPManager sharedManager].isAppStoreSHTime = YES;
        return;
    }
    
    //appstore版本号转化数字
    NSInteger  appStoreVersionNum = [appStoreVersion stringByReplacingOccurrencesOfString:@"." withString:@""].integerValue;
    //本地版本号转化数字
    NSInteger  applocalVersionNum = GET_VERSION_Number.integerValue;
    //如果appstore版本号大于本地app版本号就是发现新版本了
    if (appStoreVersionNum > applocalVersionNum) {
        NSLog(@"发现新版本,审核通过了~");
        if (self.getAppStoreData) {
            self.getAppStoreData(NO);
        }
        //审核状态赋值
        [DWBAPPManager sharedManager].isAppStoreSHTime = NO;
        
    }else{
        NSLog(@"未发现新版本，还在审核中，当前app在appStore最新版本号是：%@，当前本地版本号是：%@",appStoreVersion,GET_VERSION);
        if (self.getAppStoreData) {
            self.getAppStoreData(YES);
        }
        //审核状态赋值
        [DWBAPPManager sharedManager].isAppStoreSHTime = YES;
    }
    
}


@end
