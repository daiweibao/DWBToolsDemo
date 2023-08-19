//
//  NSDictionary+DeleteNull.h
//  DouZhuan
//
//  Created by 爱恨的潮汐 on 2018/10/26.
//  Copyright © 2018 品创时代互联网科技（北京）有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (DeleteNull)


+(id)changeType:(id)myObj;

/*
 
 使用方法：
 
 [model setValuesForKeysWithDictionary:[NSDictionary changeType:dict]];
 
 AFN请求接口获取到的数据包涵null值，处理的时候遇到了问题。
 
 在网上搜到了几种解决办法，自己尝试了两种都可以达到目的，在这里记录一下。
 
 第一种方法是使用分类给字典添加一个类方法，将字典中的null值全部替换为空字符串，代码如下：
 
 第二种方法是利用AFNetworking的自动解析，去除掉值为null的键值对，代码如下：
 
 _manager = [AFHTTPRequestOperationManager manager];
 AFJSONResponseSerializer *response = [AFJSONResponseSerializer serializer];
 response.removesKeysWithNullValues = YES;
 _manager.responseSerializer = response;
 _manager.requestSerializer = [AFJSONRequestSerializer serializer];
 但是这里有问题 如果用AFJSONResponseSerializer 有些请求返回的不是json 直接就走请求失败方法了
 
 作者：走停2015_iOS开发
 链接：https://www.jianshu.com/p/660c1c827a38
 來源：简书
 简书著作权归作者所有，任何形式的转载都请联系作者获得授权并注明出处。
 
 */


@end

NS_ASSUME_NONNULL_END
