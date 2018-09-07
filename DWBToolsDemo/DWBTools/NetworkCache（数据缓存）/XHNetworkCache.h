//
//  XHNetworkCache.h
//  XHNetworkCacheExample
//
//  Created by xiaohui on 16/6/25.
//  Copyright © 2016年 qiantou. All rights reserved.
//  代码地址:https://github.com/CoderZhuXH/XHNetworkCache

#import <Foundation/Foundation.h>

typedef void(^XHNetworkCacheCompletionBlock)(BOOL result);

@interface XHNetworkCache : NSObject

/**
 *  写入/更新缓存(同步) [按APP版本号缓存,不同版本APP,同一接口缓存数据互不干扰]
 *
 *  @param jsonResponse 要写入的数据(JSON)
 *  @param URL    数据请求URL
 *
 *  @return 是否写入成功
 */
+(BOOL)saveJsonResponseToCacheFile:(id)jsonResponse andURL:(NSString *)URL;

/**
 *  写入/更新缓存(异步) [按APP版本号缓存,不同版本APP,同一接口缓存数据互不干扰]
 *
 *  @param jsonResponse    要写入的数据(JSON)
 *  @param URL             数据请求URL
 *  @param completedBlock  异步完成回调(主线程回调)
 */
+(void)save_asyncJsonResponseToCacheFile:(id)jsonResponse andURL:(NSString *)URL completed:(XHNetworkCacheCompletionBlock)completedBlock;

/**
 *  获取缓存的对象(同步)
 *
 *  @param URL 数据请求URL
 *
 *  @return 缓存对象
 */
+(id )cacheJsonWithURL:(NSString *)URL;


/**
 *  清除所有缓存
 */
+(BOOL)clearCache;

/**
 *  获取缓存总大小(单位:M)
 *
 *  @return 缓存大小
 */
+ (float)cacheSize;


/*
 //使用示例
#pragma mark ================(异步)写入/更新缓存数据(只能是json类型，不能使model) ========
[XHNetworkCache save_asyncJsonResponseToCacheFile:response[@"data"] andURL:[NSString stringWithFormat:@"%@%@%@",GET_VERSION,YZqueryUser,model.groupId] completed:^(BOOL result) {
    //if(result)  NSLog(@"(异步)写入/更新缓存数据 成功");
    
    
}];

//取出群缓存数据
id cacheJsonGroupUserList = [XHNetworkCache cacheJsonWithURL:[NSString stringWithFormat:@"%@%@%@",GET_VERSION,YZqueryUser,model.groupId]];
 
 */

@end
