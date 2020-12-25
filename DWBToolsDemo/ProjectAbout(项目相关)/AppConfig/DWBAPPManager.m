//
//  DWBAPPManager.m
//  DWBToolsDemo
//
//  Created by chaoxi on 2018/10/22.
//  Copyright © 2018 chaoxi科技有限公司. All rights reserved.
//

#import "DWBAPPManager.h"
#import "DWBAppStoreGetData.h"//从App Store获取app信息
@interface DWBAPPManager()

@end

@implementation DWBAPPManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.isAppStoreSHTime = NO;//必须初始化为NO，非审核期间
    }
    return self;
}

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

