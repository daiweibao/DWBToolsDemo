//
//  TouchIDHelp.h
//  AiHenDeChaoXi
//
//  Created by 戴维保 on 2018/3/22.
//  Copyright © 2018年 北京嗅美科技有限公司. All rights reserved.
//

//指纹登陆回调
#import <Foundation/Foundation.h>

@interface TouchIDHelp : NSObject


/**
 判断设备是否有指纹功能

 @return 返回YES代表有指纹功能
 */
+(BOOL)isHaveTouchID;


/**
 指纹解锁结果

 @param touchState 返回：成功，或者：失败
 */
+(void)TouchIDWithState:(void (^)(NSString * state))touchState;

@end
