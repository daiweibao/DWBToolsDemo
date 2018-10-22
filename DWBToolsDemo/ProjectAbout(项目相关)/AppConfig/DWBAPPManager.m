//
//  DWBAPPManager.m
//  DWBToolsDemo
//
//  Created by 戴维保 on 2018/10/22.
//  Copyright © 2018 潮汐科技有限公司. All rights reserved.
//

#import "DWBAPPManager.h"

@interface DWBAPPManager()

@end

@implementation DWBAPPManager

//单例初始化
+ (instancetype)sharedManager {
    
    static DWBAPPManager * manager;//控制器
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[DWBAPPManager alloc] init];
    });
    return manager;
}

//名字
-(NSString *)testName{
    return @"我说名字";
}

//用方法
-(void)getMyName{
    
    NSLog(@"得到我的名字");
}

@end
