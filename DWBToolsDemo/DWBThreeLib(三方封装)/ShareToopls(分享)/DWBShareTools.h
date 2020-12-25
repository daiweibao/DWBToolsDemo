//
//  DWBShareTools.h
//  DouZhuan
//
//  Created by chaoxi on 2018/9/20.
//  Copyright © 2018年 chaoxi科技有限公司. All rights reserved.
//
//友盟分享封装 和 系统分享封装
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
//定义分享类型
typedef NS_ENUM(NSInteger,DWBShareType){
    shareType_OnlyText = 0,//仅仅分享文字
    shareType_OnlyImage,//仅仅分享图片
    shareType_OnlyUrl,//图文连接分享
};


@interface DWBShareTools : NSObject


/**
 分享到【微信小程序】
 
 @param controller 当前控制器（必传）
 @param title 标题（必x传）
 @param descr 描述
 @param shareUrl 低版本微信网页链接（低版本不支持小程序）
 @param shareImage thumImage  缩略图（UIImage或者NSData类型，或者image_url）(必传)
 @param pagePath 小程序页面路径，如 pages/page10007/page10007(必传)
 @param hdImage 小程序新版本的预览图 128k--必传显示在封面
 @param completion 返回分享结果：00成功，01用户取消分享，02分享失败
 */
+(void)shareToWXSmallProgramWithController:(UIViewController *)controller AndTitle:(NSString * _Nullable)title AndContent:(NSString * _Nullable)descr AndShareUrl:(NSString * _Nullable)shareUrl AndshareImage:(id)shareImage AndPagePath:(NSString * _Nullable)pagePath AndHdImage:(UIImage *)hdImage completion:(void (^)(NSString * codeStr,NSString * msg))completion;



/**
 分享到【微信好友】，分享类型：0只分享文字，1只分享图片，2正常分享（图文分享）
 
 @param controller 当前控制器
 @param title 标题
 @param descr 描述
 @param shareUrl 分享链接
 @param shareImage 分享缩略图
 @param sharetype 分享类型：1只分享文字, 2只分享图片，nil正常分享（图文分享）
 @param completion 分享结果：00成功，01用户取消分享，02分享失败
 */
+(void)shareToWXWithController:(UIViewController *)controller AndTitle:(NSString * _Nullable)title AndContent:(NSString * _Nullable)descr AndShareUrl:(NSString * _Nullable)shareUrl AndshareImage:(id)shareImage ShareType:(DWBShareType )sharetype completion:(void (^)(NSString * codeStr,NSString * msg))completion;


/**
 分享到【微信朋友圈】，分享类型：0只分享文字，1只分享图片，2正常分享（图文分享）
 
 @param controller 当前控制器
 @param title 标题
 @param descr 描述
 @param shareUrl 分享链接
 @param shareImage 分享缩略图
 @param sharetype 分享类型：1只分享文字, 2只分享图片，nil正常分享（图文分享）
 @param completion 分享结果 ：00成功，01用户取消分享，02分享失败
 */
+(void)shareToFriendsWithController:(UIViewController *)controller AndTitle:(NSString * _Nullable)title AndContent:(NSString * _Nullable)descr AndShareUrl:(NSString * _Nullable)shareUrl AndshareImage:(id)shareImage ShareType:(DWBShareType )sharetype completion:(void (^)(NSString * codeStr,NSString * msg))completion;


/**
 分享到【QQ好友】，分享类型：1正常分享（图文分享），2只分享图片，3只分享文字
 
 @param controller 当前控制器
 @param title 标题
 @param descr 描述
 @param shareUrl 分享链接
 @param shareImage 分享缩略图
 @param sharetype 分享类型：1只分享文字, 2只分享图片，nil正常分享（图文分享）
 @param completion 分享结果 ：00成功，01用户取消分享，02分享失败
 */
+(void)shareToQQFriendsWithController:(UIViewController *)controller AndTitle:(NSString * _Nullable)title AndContent:(NSString * _Nullable)descr AndShareUrl:(NSString * _Nullable)shareUrl AndshareImage:(id)shareImage ShareType:(DWBShareType )sharetype completion:(void (^)(NSString * codeStr,NSString * msg))completion;

/**
 分享到【QQ空间】，分享类型：1正常分享（图文分享），2只分享图片，3只分享文字
 
 @param controller 当前控制器
 @param title 标题
 @param descr 描述
 @param shareUrl 分享链接
 @param shareImage 分享缩略图
 @param sharetype 分享类型：1只分享文字, 2只分享图片，nil正常分享（图文分享）
 @param completion 分享结果：00成功，01用户取消分享，02分享失败
 */
+(void)shareToQzoneWithController:(UIViewController *)controller AndTitle:(NSString * _Nullable)title AndContent:(NSString * _Nullable)descr AndShareUrl:(NSString * _Nullable)shareUrl AndshareImage:(id)shareImage ShareType:(DWBShareType )sharetype completion:(void (^)(NSString * codeStr,NSString * msg))completion;



/**
 分享到【新浪微博】，分享类型：1正常分享（图文分享），2只分享图片，3只分享文字
 
 @param controller 当前控制器
 @param title 标题
 @param descr 描述
 @param shareUrl 分享链接
 @param shareImage 分享缩略图
 @param sharetype 分享类型：1只分享文字, 2只分享图片，nil正常分享（图文分享）
 @param completion 分享结果：00成功，01用户取消分享，02分享失败
 */
+(void)shareToSinaWBWithController:(UIViewController *)controller AndTitle:(NSString * _Nullable)title AndContent:(NSString * _Nullable)descr AndShareUrl:(NSString * _Nullable)shareUrl AndshareImage:(id)shareImage ShareType:(DWBShareType )sharetype completion:(void (^)(NSString * codeStr,NSString * msg))completion;




/**
 分享到【iOS系统分享】
 
 @param controller 当前控制器
 @param title 标题
 @param descr 描述
 @param shareUrl 分享链接
 @param shareImage 分享缩略图
 @param sharetype 分享类型：1只分享文字, 2只分享图片，nil正常分享（图文分享）
 @param completion 分享结果：00成功，01用户取消分享，02分享失败
 */
+(void)shareTo_SystemWithController:(UIViewController *)controller AndTitle:(NSString * _Nullable)title AndContent:(NSString * _Nullable)descr AndShareUrl:(NSString * _Nullable)shareUrl AndshareImage:(id)shareImage ShareType:(DWBShareType )sharetype completion:(void (^)(NSString * codeStr,NSString * msg,UIActivityType activeType))completion;

@end

NS_ASSUME_NONNULL_END
