//
//  CXVersionUpdate.h
//  AiHenDeChaoXi
//
//  Created by 爱恨的潮汐 on 2018/5/8.
//  Copyright © 2018年 潮汐科技有限公司. All rights reserved.
//
//从appStore获取版本更新提示弹窗
#import <Foundation/Foundation.h>

@interface CXVersionUpdate : NSObject

/**
 从appStore获取版本信息，在引导页滑动完成后再去请求数据，不然特殊情况显示不出来
 
 @param isShowFailAleat 获取不到新版本是否弹窗
 */
+(void)updateAppStoreVersionWithShowFailAleat:(BOOL)isShowFailAleat;

@end
