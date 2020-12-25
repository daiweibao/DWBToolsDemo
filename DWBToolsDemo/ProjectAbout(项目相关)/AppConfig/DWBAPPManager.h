//
//  DWBAPPManager.h
//  DWBToolsDemo
//
//  Created by chaoxi on 2018/10/22.
//  Copyright © 2018 chaoxi科技有限公司. All rights reserved.
//
//在APP启动的时候做一些数据配置
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DWBAPPManager : NSObject
//单例初始化
+(instancetype)sharedManager;


/**
 apps是否在审核期间:YES表示是审核期间，NO不是
 */
@property(nonatomic,assign)BOOL isAppStoreSHTime;





//测试数据--属性
@property(nonatomic,copy)NSString * testName;

//方法
-(void)getMyName;


@end

NS_ASSUME_NONNULL_END

