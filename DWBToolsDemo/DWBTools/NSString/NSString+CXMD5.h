//
//  NSString+CXMD5.h
//  AiHenDeChaoXi
//
//  Created by 戴维保 on 2018/3/19.
//  Copyright © 2018年 潮汐科技有限公司. All rights reserved.
//
//MD5加密类
#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
@interface NSString (CXMD5)
//MD5大写加密
- (NSString *)MD5Hash;
//MD5小写加密
+ (NSString *)md5:(NSString *)str;

/**
 sha1加密
 
 @param str <#str description#>
 @return <#return value description#>
 */
+(NSString*) sha1:(NSString *)str;

/**
 获取视频等大文件的MD5
 
 @param asset 视频的ALAsset
 @return MD5
 */
+(NSString *)fileMD5WithAsset:(ALAsset *)asset;

@end
