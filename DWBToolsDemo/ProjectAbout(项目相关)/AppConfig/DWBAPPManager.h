//
//  DWBAPPManager.h
//  DWBToolsDemo
//
//  Created by 戴维保 on 2018/10/22.
//  Copyright © 2018 潮汐科技有限公司. All rights reserved.
//
//在APP启动的时候做一些数据配置
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define RootNavController [DWBAPPManager sharedManager].rootNavigationController

@interface DWBAPPManager : NSObject
//单例初始化
+(instancetype)sharedManager;

///记录根控制器的导航栏
@property (nonatomic, strong) UINavigationController *rootNavigationController;

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

