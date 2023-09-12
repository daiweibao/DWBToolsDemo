//
//  CXUUIDHelp.h
//  ZuiMeiXinNiang
//
//  Created by 爱恨的潮汐 on 2017/3/27.
//  Copyright © 2017年 zmxn. All rights reserved.
//
//KeyChainStore获取手机UUID，应用卸载后也不会变，存到系统钥匙串里了
#import <Foundation/Foundation.h>

@interface CXUUIDHelp : NSObject

/**
 得到UUID

 @return 卸载后也不回变的UUID
 */
+(NSString *)getUUID;

@end
