//
//  DWBAPPManager.m
//  DWBToolsDemo
//
//  Created by 爱恨的潮汐 on 2018/10/22.
//  Copyright © 2018 潮汐科技有限公司. All rights reserved.
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

-(UINavigationController *)rootNavigationController{
    if(_rootNavigationController==nil){
        //如果为空，就获取当前显示的控制器，以防万一
        return [UIViewController getCurrentVC].navigationController;
    }else{
        return _rootNavigationController;
    }
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

