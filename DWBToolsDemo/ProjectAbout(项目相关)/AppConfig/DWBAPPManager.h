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

@interface DWBAPPManager : NSObject
//单例初始化
+(instancetype)sharedManager;

//测试数据--属性
@property(nonatomic,copy)NSString * testName;

//方法
-(void)getMyName;

@end

NS_ASSUME_NONNULL_END
