//
//  DWBShareTools.m
//  DouZhuan
//
//  Created by 戴维保 on 2018/9/20.
//  Copyright © 2018年 潮汐科技有限公司. All rights reserved.
//

#import "DWBShareTools.h"

@implementation DWBShareTools


#pragma mark ===================微信小程序分享 S====================
/**
 分享到【微信小程序】

 @param controller 当前控制器（必传）
 @param title 标题（必x传）
 @param descr 描述
 @param shareUrl 低版本微信网页链接（低版本不支持小程序）
 @param shareImage thumImage  缩略图（UIImage或者NSData类型，或者image_url）(必传)
 @param pagePath 小程序页面路径，如 pages/page10007/page10007(必传)
 @param hdImage 小程序新版本的预览图 128k--必传显示在封面
 @param completion 返回分享结果
 */
+(void)shareToWXSmallProgramWithController:(UIViewController *)controller AndTitle:(NSString * _Nullable)title AndContent:(NSString * _Nullable)descr AndShareUrl:(NSString * _Nullable)shareUrl AndshareImage:(id)shareImage AndPagePath:(NSString * _Nullable)pagePath AndHdImage:(UIImage *)hdImage completion:(void (^)(NSString * codeStr,NSString * msg))completion{
    //判空
    if ([NSString isNULL:title]==YES) {
        title = @"";
    }
    if ([NSString isNULL:descr]==YES) {
        descr = @"";
    }
    if ([NSString isNULL:shareUrl]==YES) {
        shareUrl = AppstoreUrl;//判空,app下载连接
    }
    //设置判空图
    if (shareImage==nil) {
        shareImage = [UIImage imageNamed:default_CoverImage];
    }

    if (!hdImage) {
        hdImage = [UIImage imageNamed:default_CoverImage];
    }
    
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    UMShareMiniProgramObject *shareObject = [UMShareMiniProgramObject shareObjectWithTitle:title descr:descr thumImage:shareImage];
    //兼容微信低版本网页地址连接
    shareObject.webpageUrl = shareUrl;
    //小程序username，如 gh_3ac2059ac66f
    shareObject.userName = @"gh_24a0b9807286";//--项目中固定写死
    //小程序页面路径，如 pages/page10007/page10007
    shareObject.path = pagePath;
    messageObject.shareObject = shareObject;
     //小程序新版本的预览图 128k
     NSData *imageData = [hdImage compressWithLengthLimit:127 * 1024.0f];//限制图片不能超过过128k,否则必死
    shareObject.hdImageData = imageData;
    
    shareObject.miniProgramType = UShareWXMiniProgramTypeRelease; // 可选体验版和开发板
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_WechatSession messageObject:messageObject currentViewController:controller completion:^(id data, NSError *error) {

        NSString * shareResultsCode;//分享结果编码
        NSString * messageInfo = @"";//提示消息

        if (error) {

//            if (error.code==UMSocialPlatformErrorType_NotUsingHttps) {
//                 shareResultsCode = @"01";
//                messageInfo = @"分享失败，图片链接必须为https";
//
//            }else if (error.code==UMSocialPlatformErrorType_NotInstall){
//                 shareResultsCode = @"02";
//                 messageInfo = @"分享失败，你没有安微信";
//
//
//            }else if (error.code==UMSocialPlatformErrorType_Cancel){
//                 shareResultsCode = @"03";
//                messageInfo = @"分享失败，用户取消操作";
//
//            }else{
//                shareResultsCode = @"04";
//                messageInfo = @"分享失败";
//            }

//为鼓励用户自发分享喜爱的内容，减少“强制分享至不同群”等滥用分享能力，破坏用户体验的行为，微信开放平台分享功能即日起做出如下调整：
//新版微信客户端（6.7.2及以上版本）发布后，用户从App中分享消息给微信好友，或分享到朋友圈时，开发者将无法获知用户是否分享完成。
//具体调整点为：分享接口调用后，不再返回用户是否分享完成事件，即原先的cancel事件和success事件将统一为success事件。
//请开发者尽快做好调整。
//
//微信团队
//2018年08月13日
            
            //分享失败
            shareResultsCode = @"02";
            messageInfo = @"分享失败";

        }else{
            //取消分享也会走这里
            shareResultsCode = @"00";
            messageInfo = @"分享成功";
        }

        dispatch_async(dispatch_get_main_queue(), ^{
            //分享结果回调
            if (completion) {
                completion(shareResultsCode,messageInfo);
            }

        });

    }];
}

#pragma mark ===================微信小程序分享 E====================c





#pragma mark ===================微信好友分享 S====================

/**
 分享到【微信好友】，分享类型：1正常分享（图文分享），2只分享图片，3只分享文字

 @param controller 当前控制器
 @param title 标题
 @param descr 描述
 @param shareUrl 分享链接
 @param shareImage 分享缩略图
 @param sharetype 分享类型：1只分享文字, 2只分享图片，nil正常分享（图文分享）
 @param completion 分享结果
 */
+(void)shareToWXWithController:(UIViewController *)controller AndTitle:(NSString * _Nullable)title AndContent:(NSString * _Nullable)descr AndShareUrl:(NSString * _Nullable)shareUrl AndshareImage:(id)shareImage ShareType:(DWBShareType )sharetype completion:(void (^)(NSString * codeStr,NSString * msg))completion{

    //判空
    if ([NSString isNULL:title]==YES) {
        title = @"";
    }
    if ([NSString isNULL:descr]==YES) {
        descr = @"";
    }
    if ([NSString isNULL:shareUrl]==YES) {
        shareUrl = @"";
    }
    
    //缩略图判空
    if (!shareImage) {
        shareImage = [UIImage imageNamed:appLogoName];
    }
    
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    if (sharetype == shareType_OnlyText) {
#pragma mark =============只分享文字===============
        //只分享文字
        //设置文本
        messageObject.text = title;
        
    }else if (sharetype == shareType_OnlyImage) {
#pragma mark =============只分享图片===============
        
        //创建图片内容对象
        UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
        //如果有缩略图，则设置缩略图本地
        shareObject.thumbImage = shareImage;
        
        [shareObject setShareImage:shareImage];
        //分享消息对象设置分享内容对象
        messageObject.shareObject = shareObject;
        
    }else{
#pragma mark =============网页分享===============
        //网页分享
        //设置判空图
        if (shareImage==nil) {
            shareImage = [UIImage imageNamed:default_CoverImage];
        }
        
        //网页连接跟缩略图分享
        UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:title descr:descr thumImage:shareImage];
        
        if ([NSString isNULL:shareUrl]==YES) {
            [DWBToast showCenterWithText:@"失败，分享连接不存在"];
            
        }else if (![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:shareUrl]]){
            //不是https开头的
            [DWBToast showCenterWithText:@"分享连接是无效网址"];
            NSLog(@"分享连接：%@",shareUrl);
        }
        //设置网页地址(不设置，直接分享失败)
        shareObject.webpageUrl = shareUrl;
        //分享消息对象设置分享内容对象
        messageObject.shareObject = shareObject;
    }
    
#pragma mark ==============调用公共分享类=======================
    //调用分享接口  currentViewController用于弹出类似邮件分享、短信分享等这样的系统页面
    [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_WechatSession messageObject:messageObject currentViewController:controller completion:^(id data, NSError *error) {
        NSString * shareResultsCode;//分享结果编码
        NSString * messageInfo = @"";//提示消息
        if (!error) {
            shareResultsCode = @"00";
            messageInfo = @"分享成功";
            
        }else{
            shareResultsCode = @"02";
            messageInfo = @"分享失败";
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //分享结果回调
            if (completion) {
                completion(shareResultsCode,messageInfo);
            }
        });
    }];
}
#pragma mark ===================微信好友分享 E====================





#pragma mark ===================微信朋友圈分享 S====================

/**
 分享到【微信朋友圈】，分享类型：1正常分享（图文分享），2只分享图片，3只分享文字
 
 @param controller 当前控制器
 @param title 标题
 @param descr 描述
 @param shareUrl 分享链接
 @param shareImage 分享缩略图
 @param sharetype 分享类型：1只分享文字, 2只分享图片，nil正常分享（图文分享）
 @param completion 分享结果
 */
+(void)shareToFriendsWithController:(UIViewController *)controller AndTitle:(NSString * _Nullable)title AndContent:(NSString * _Nullable)descr AndShareUrl:(NSString * _Nullable)shareUrl AndshareImage:(id)shareImage ShareType:(DWBShareType )sharetype completion:(void (^)(NSString * codeStr,NSString * msg))completion{
    //判空
    if ([NSString isNULL:title]==YES) {
        title = @"";
    }
    if ([NSString isNULL:descr]==YES) {
        descr = @"";
    }
    if ([NSString isNULL:shareUrl]==YES) {
        shareUrl = @"";
    }
    
    //缩略图判空
    if (!shareImage) {
       shareImage = [UIImage imageNamed:appLogoName];
    }
    
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    if (sharetype == shareType_OnlyText) {
#pragma mark =============只分享文字===============
        //只分享文字
        //设置文本
        messageObject.text = title;
        
    }else if (sharetype == shareType_OnlyImage) {
#pragma mark =============只分享图片===============
        
        //创建图片内容对象
        UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
        //如果有缩略图，则设置缩略图本地
        shareObject.thumbImage = shareImage;
        
        [shareObject setShareImage:shareImage];
        //分享消息对象设置分享内容对象
        messageObject.shareObject = shareObject;
        
    }else{
#pragma mark =============网页分享===============
        //网页分享
        //设置判空图
        if (shareImage==nil) {
            shareImage = [UIImage imageNamed:default_CoverImage];
        }
        
        //网页连接跟缩略图分享
        UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:title descr:descr thumImage:shareImage];
        
        if ([NSString isNULL:shareUrl]==YES) {
            [DWBToast showCenterWithText:@"失败，分享连接不存在"];
            
        }else if (![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:shareUrl]]){
            //不是https开头的
            [DWBToast showCenterWithText:@"分享连接是无效网址"];
            NSLog(@"分享连接：%@",shareUrl);
        }
        //设置网页地址(不设置，直接分享失败)
        shareObject.webpageUrl = shareUrl;
        //分享消息对象设置分享内容对象
        messageObject.shareObject = shareObject;
    }

#pragma mark ==============调用公共分享类=======================
    //调用分享接口  currentViewController用于弹出类似邮件分享、短信分享等这样的系统页面
    [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_WechatTimeLine messageObject:messageObject currentViewController:controller completion:^(id data, NSError *error) {
        NSString * shareResultsCode;//分享结果编码
        NSString * messageInfo = @"";//提示消息
        if (!error) {
            shareResultsCode = @"00";
            messageInfo = @"分享成功";
            
        }else {
            shareResultsCode = @"02";
            messageInfo = @"分享失败";
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //分享结果回调
            if (completion) {
                completion(shareResultsCode,messageInfo);
            }
        });
    }];
    
}
#pragma mark ===================微信朋友圈分享 E====================



#pragma mark ===================QQ好友分享 S====================

/**
 分享到【QQ好友】，分享类型：1正常分享（图文分享），2只分享图片，3只分享文字
 
 @param controller 当前控制器
 @param title 标题
 @param descr 描述
 @param shareUrl 分享链接
 @param shareImage 分享缩略图
 @param sharetype 分享类型：1只分享文字, 2只分享图片，nil正常分享（图文分享）
 @param completion 分享结果
 */
+(void)shareToQQFriendsWithController:(UIViewController *)controller AndTitle:(NSString * _Nullable)title AndContent:(NSString * _Nullable)descr AndShareUrl:(NSString * _Nullable)shareUrl AndshareImage:(id)shareImage ShareType:(DWBShareType )sharetype completion:(void (^)(NSString * codeStr,NSString * msg))completion{
    //判空
    if ([NSString isNULL:title]==YES) {
        title = @"";
    }
    if ([NSString isNULL:descr]==YES) {
        descr = @"";
    }
    if ([NSString isNULL:shareUrl]==YES) {
        shareUrl = @"";
    }
    
    //缩略图判空
    if (!shareImage) {
        shareImage = [UIImage imageNamed:appLogoName];
    }
    
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    if (sharetype == shareType_OnlyText) {
#pragma mark =============只分享文字===============
        //只分享文字
        //设置文本
        messageObject.text = title;
        
    }else if (sharetype == shareType_OnlyImage) {
#pragma mark =============只分享图片===============
        
        //创建图片内容对象
        UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
        //如果有缩略图，则设置缩略图本地
        shareObject.thumbImage = shareImage;
        
        [shareObject setShareImage:shareImage];
        //分享消息对象设置分享内容对象
        messageObject.shareObject = shareObject;
        
    }else{
#pragma mark =============网页分享===============
        //网页分享
        //设置判空图
        if (shareImage==nil) {
            shareImage = [UIImage imageNamed:default_CoverImage];
        }
        
        //网页连接跟缩略图分享
        UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:title descr:descr thumImage:shareImage];
        
        if ([NSString isNULL:shareUrl]==YES) {
            [DWBToast showCenterWithText:@"失败，分享连接不存在"];
            
        }else if (![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:shareUrl]]){
            //不是https开头的
            [DWBToast showCenterWithText:@"分享连接是无效网址"];
            NSLog(@"分享连接：%@",shareUrl);
        }
        //设置网页地址(不设置，直接分享失败)
        shareObject.webpageUrl = shareUrl;
        //分享消息对象设置分享内容对象
        messageObject.shareObject = shareObject;
    }
    
#pragma mark ==============调用公共分享类=======================
    //调用分享接口  currentViewController用于弹出类似邮件分享、短信分享等这样的系统页面
    [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_QQ messageObject:messageObject currentViewController:controller completion:^(id data, NSError *error) {
        NSString * shareResultsCode;//分享结果编码
        NSString * messageInfo = @"";//提示消息
        
        if (!error) {
            shareResultsCode = @"00";
            messageInfo = @"分享成功";
            
        }else {
            if (error.code==UMSocialPlatformErrorType_Cancel){
                shareResultsCode = @"01";
                messageInfo = @"分享失败，用户取消操作";
                
            }else{
                shareResultsCode = @"02";
                messageInfo = @"分享失败";
                
            }
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //分享结果回调
            if (completion) {
                completion(shareResultsCode,messageInfo);
            }
        });
    }];
    
}


#pragma mark ===================QQ好友分享 E====================








#pragma mark ===================QQ空间分享 S====================

/**
 分享到【QQ空间】，分享类型：1正常分享（图文分享），2只分享图片，3只分享文字
 
 @param controller 当前控制器
 @param title 标题
 @param descr 描述
 @param shareUrl 分享链接
 @param shareImage 分享缩略图
 @param sharetype 分享类型：1只分享文字, 2只分享图片，nil正常分享（图文分享）
 @param completion 分享结果
 */
+(void)shareToQzoneWithController:(UIViewController *)controller AndTitle:(NSString * _Nullable)title AndContent:(NSString * _Nullable)descr AndShareUrl:(NSString * _Nullable)shareUrl AndshareImage:(id)shareImage ShareType:(DWBShareType )sharetype completion:(void (^)(NSString * codeStr,NSString * msg))completion{
    //判空
    if ([NSString isNULL:title]==YES) {
        title = @"";
    }
    if ([NSString isNULL:descr]==YES) {
        descr = @"";
    }
    if ([NSString isNULL:shareUrl]==YES) {
        shareUrl = @"";
    }
    
    //缩略图判空
    if (!shareImage) {
        shareImage = [UIImage imageNamed:appLogoName];
    }
    
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    if (sharetype == shareType_OnlyText) {
#pragma mark =============只分享文字===============
        //只分享文字
        //设置文本
        messageObject.text = title;
        
    }else if (sharetype == shareType_OnlyImage) {
#pragma mark =============只分享图片===============
        
        //创建图片内容对象
        UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
        //如果有缩略图，则设置缩略图本地
        shareObject.thumbImage = shareImage;
        
        [shareObject setShareImage:shareImage];
        //分享消息对象设置分享内容对象
        messageObject.shareObject = shareObject;
        
    }else{
#pragma mark =============网页分享===============
        //网页分享
        //设置判空图
        if (shareImage==nil) {
            shareImage = [UIImage imageNamed:default_CoverImage];
        }
        
        //网页连接跟缩略图分享
        UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:title descr:descr thumImage:shareImage];
        
        if ([NSString isNULL:shareUrl]==YES) {
            [DWBToast showCenterWithText:@"失败，分享连接不存在"];
            
        }else if (![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:shareUrl]]){
            //不是https开头的
            [DWBToast showCenterWithText:@"分享连接是无效网址"];
            NSLog(@"分享连接：%@",shareUrl);
        }
        //设置网页地址(不设置，直接分享失败)
        shareObject.webpageUrl = shareUrl;
        //分享消息对象设置分享内容对象
        messageObject.shareObject = shareObject;
    }
    
#pragma mark ==============调用公共分享类=======================
    //调用分享接口  currentViewController用于弹出类似邮件分享、短信分享等这样的系统页面
    [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_Qzone messageObject:messageObject currentViewController:controller completion:^(id data, NSError *error) {
        NSString * shareResultsCode;//分享结果编码
        NSString * messageInfo = @"";//提示消息
        if (!error) {
            shareResultsCode = @"00";
            messageInfo = @"分享成功";
            
        }else {
            if (error.code==UMSocialPlatformErrorType_Cancel){
                shareResultsCode = @"01";
                messageInfo = @"分享失败，用户取消操作";
                
            }else{
                shareResultsCode = @"02";
                messageInfo = @"分享失败";
                
            }
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //分享结果回调
            if (completion) {
                completion(shareResultsCode,messageInfo);
            }
        });
    }];
    
}


#pragma mark ===================QQ空间分享 E====================








#pragma mark ===================新浪微博分享 S====================
/**
 分享到【新浪微博】，分享类型：1正常分享（图文分享），2只分享图片，3只分享文字
 
 @param controller 当前控制器
 @param title 标题
 @param descr 描述
 @param shareUrl 分享链接
 @param shareImage 分享缩略图
 @param sharetype 分享类型：1只分享文字, 2只分享图片，nil正常分享（图文分享）
 @param completion 分享结果
 */
+(void)shareToSinaWBWithController:(UIViewController *)controller AndTitle:(NSString * _Nullable)title AndContent:(NSString * _Nullable)descr AndShareUrl:(NSString * _Nullable)shareUrl AndshareImage:(id)shareImage ShareType:(DWBShareType )sharetype completion:(void (^)(NSString * codeStr,NSString * msg))completion{
    //判空
    if ([NSString isNULL:title]==YES) {
        title = @"";
    }
    if ([NSString isNULL:descr]==YES) {
        descr = @"";
    }
    if ([NSString isNULL:shareUrl]==YES) {
        shareUrl = @"";
    }
    
    //缩略图判空
    if (!shareImage) {
        shareImage = [UIImage imageNamed:appLogoName];
    }
    
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    if (sharetype == shareType_OnlyText) {
#pragma mark =============只分享文字===============
        //只分享文字
        //分享到新浪微博拼接上APP小尾巴
        title = [NSString stringWithFormat:@"%@%@ #%@#（来自@%@）",title,descr,GET_APPName,GET_APPName];
        //设置文本
        messageObject.text = title;
        
    }else if (sharetype == shareType_OnlyImage) {
#pragma mark =============只分享图片===============
        
        //设置只分享图片的描述
        if ([NSString isNULL:title]==YES) {
            //无分享标题
            messageObject.text = [NSString stringWithFormat:@"我在%@分享了一张图片 #%@#（来自@%@）",GET_APPName,GET_APPName,GET_APPName];
            
        }else{
            //有分享标题
            messageObject.text = [NSString stringWithFormat:@"%@ #%@#（来自@%@）",title,GET_APPName,GET_APPName];
            
        }
        
        //创建图片内容对象
        UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
        
        //如果有缩略图，则设置缩略图本地
        shareObject.thumbImage = shareImage;
        //分享的图片
        [shareObject setShareImage:shareImage];
        //分享消息对象设置分享内容对象
        messageObject.shareObject = shareObject;
        
    }else{
#pragma mark =============网页分享===============
        //网页分享
        //设置文本
        //分享到新浪微博拼接上APP小尾巴
        shareUrl = [NSString stringWithFormat:@"~>>%@  #%@#（来自@%@）",shareUrl,GET_APPName,GET_APPName];
        messageObject.text =[NSString stringWithFormat:@"%@%@%@",title,descr,shareUrl];
        //创建图片内容对象
        UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
        //如果有缩略图，则设置缩略图
        shareObject.thumbImage = shareImage;
        //分享的图片
        shareObject.shareImage = shareImage;
        //分享消息对象设置分享内容对象
        messageObject.shareObject = shareObject;
    }
    
#pragma mark ==============调用公共分享类=======================
    //调用分享接口  currentViewController用于弹出类似邮件分享、短信分享等这样的系统页面
    [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_Sina messageObject:messageObject currentViewController:controller completion:^(id data, NSError *error) {
        NSString * shareResultsCode;//分享结果编码
        NSString * messageInfo = @"";//提示消息
        if (!error) {
            shareResultsCode = @"00";
            messageInfo = @"分享成功";
            
        }else {
            if (error.code==UMSocialPlatformErrorType_Cancel){
                shareResultsCode = @"01";
                messageInfo = @"分享失败，用户取消操作";
                
            }else{
                shareResultsCode = @"02";
                messageInfo = @"分享失败";
                
            }
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //分享结果回调
            if (completion) {
                completion(shareResultsCode,messageInfo);
            }
        });
    }];
    
}


#pragma mark ===================新浪微博分享分享 E====================











#pragma mark ====================iOS系统分享 S=================================
+(void)shareTo_SystemWithController:(UIViewController *)controller AndTitle:(NSString * _Nullable)title AndContent:(NSString * _Nullable)descr AndShareUrl:(NSString * _Nullable)shareUrl AndshareImage:(id)shareImage ShareType:(DWBShareType )sharetype completion:(void (^)(NSString * codeStr,NSString * msg,UIActivityType activeType))completion{
  
    //判空
    if ([NSString isNULL:title]==YES) {
        title = @"";
    }
    if ([NSString isNULL:descr]==YES) {
        descr = @"";
    }
    if ([NSString isNULL:shareUrl]==YES) {
        shareUrl = @"";
    }
    
    //缩略图判空
    if (!shareImage) {
        shareImage = [UIImage imageNamed:appLogoName];
    }
    
    
    //分享的标题--textToShare固定变量名字，不能改
    NSString *textToShare = title;
    //分享的图片 固定变量名字，不能改
    UIImage *imageToShare = shareImage;
    //分享的url 固定变量名字，不能改
    NSURL *urlToShare = [NSURL URLWithString:shareUrl];

    //要确定textToShare, imageToShare, urlToShare均不为空，否则不会弹出系统分享界面
    NSArray *activityItems = @[textToShare,imageToShare, urlToShare];


    UIActivityViewController *vc = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];

//    当弹出视图框的时候，我们发现上边很多图标是我们用不到，我们可以将用不到的图标去掉，用到的函数是
//    vc.excludedActivityTypes = @[UIActivityTypePostToFacebook,UIActivityTypePostToTwitter,UIActivityTypeMessage,UIActivityTypeMail,UIActivityTypePrint,UIActivityTypeCopyToPasteboard,UIActivityTypeAssignToContact,UIActivityTypeSaveToCameraRoll,UIActivityTypeAddToReadingList,UIActivityTypePostToFlickr,UIActivityTypePostToVimeo,UIActivityTypePostToTencentWeibo,UIActivityTypeAirDrop];


    UIActivityViewControllerCompletionWithItemsHandler myBlock = ^(UIActivityType activityType, BOOL completed, NSArray *returnedItems, NSError *activityError) {//activityType 分享平台
// activityType： com.tencent.xin.sharetimeline 微信好友和朋友圈
//        com.tencent.mqq.ShareExtension qq空间--qq好友
//        com.sina.weibo.ShareExtension  新浪微博

//           NSLog(@"activityType :%@", activityType);
        NSString * shareResultsCode;//分享结果编码
        NSString * messageInfo = @"";//提示消息
        if (completed) {
            //成功
            shareResultsCode = @"00";
            messageInfo = @"分享成功";
        } else {
           //失败
            shareResultsCode = @"02";
            messageInfo = @"分享失败";
        }
        //回调
        dispatch_async(dispatch_get_main_queue(), ^{
            //分享结果回调
            if (completion) {
                completion(shareResultsCode,messageInfo,activityType);
            }
        });
        [vc dismissViewControllerAnimated:YES completion:nil];
    };
    // 初始化completionHandler，当post结束之后（无论是done还是cancell）该blog都会被调用
    vc.completionWithItemsHandler = myBlock;

//    在展现view controller时，必须根据当前的设备类型，使用适当的方法。在iPad上，必须通过popover来展现view controller。在iPhone和iPodtouch上，必须以模态的方式展现。
    [controller presentViewController:vc animated:YES completion:nil];

    
}
#pragma mark ====================iOS系统分享 S=================================





@end
