//
//  DWBAppStoreGetData.h
//  DouZhuan
//
//  Created by 爱恨的潮汐 on 2018/11/1.
//  Copyright © 2018 品创时代互联网科技（北京）有限公司. All rights reserved.
//
//从App Store请求app数据
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DWBAppStoreGetData : NSObject

/**
 请求数据判断是否是App Store审核期间:YES表示是审核期间
 */
+(void)getAppStoreDataWithCompletion:(void(^)(BOOL isAppStoreSHTime))completion;

@end

NS_ASSUME_NONNULL_END
