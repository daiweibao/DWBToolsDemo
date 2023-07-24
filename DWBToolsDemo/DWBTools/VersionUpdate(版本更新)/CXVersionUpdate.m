//
//  CXVersionUpdate.m
//  AiHenDeChaoXi
//
//  Created by 戴维保 on 2018/5/8.
//  Copyright © 2018年 北京嗅美科技有限公司. All rights reserved.
//

#import "CXVersionUpdate.h"
//发现新版本弹窗
#import "DownUpdateAppAleat.h"

@interface CXVersionUpdate()

@end

@implementation CXVersionUpdate



/**
 从appStore获取版本信息

 @param isShowFailAleat 获取不到新版本是否弹窗
 */
+(void)updateAppStoreVersionWithShowFailAleat:(BOOL)isShowFailAleat{
    //com.xiumei.GongXiangJie 1268925096
    //取得AppStore信息 https://itunes.apple.com/lookup?bundleId=com.xiumei.GongXiangJie,如果是在中国地区上架的，要加上cn/，https://itunes.apple.com/cn/lookup?bundleId=com.xiumei.GongXiangJie
    //根据BundleId获取是最有效的，,只在中国地区上架的app必须加上/cn,不然只在中国地区上架的app无法获取到数据，间书：https://www.jianshu.com/p/3bb2d0b22d78
    NSString * pathChina = [NSString stringWithFormat:@"https://itunes.apple.com/cn/lookup?bundleId=%@",GET_BundleId];
    //测试
//     NSString * pathChina = [NSString stringWithFormat:@"https://itunes.apple.com/cn/lookup?bundleId=%@",@"com.chaoxi.wangfuvideo"];
    //调用自己的单例，防止内存泄露，必须先在中国地区获取app信息(不然加载慢，因为大部分app都在中国地区上架)，如果获取不到再去美国地区获取
    AFHTTPSessionManager * manager =  [DWBAFNetworking sharedManager];
    [manager POST:pathChina parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        dispatch_async(dispatch_get_main_queue(), ^{
            //判断在中国地区能否获取到APP数据
            NSArray * arrayAppInfo = responseObject[@"results"];
            if ([responseObject[@"resultCount"] integerValue]  == 0 || arrayAppInfo.count==0) {
                //去美国地区获取app信息
                [CXVersionUpdate theUSAGetAppInfoLoadWithShowFailAleat:isShowFailAleat];
                
            }else{
                //在中国地区获取到了app信息，创建弹窗
                [CXVersionUpdate createUI:responseObject AndShowFailAleat:isShowFailAleat];
                NSLog(@"在中国地区获取到了app信息");
            }
        });
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

//在美国地区获取app信息
+(void)theUSAGetAppInfoLoadWithShowFailAleat:(BOOL)isShowFailAleat{
    //调用自己的单例，防止内存泄露，在美国地区获取app信息
    AFHTTPSessionManager * manager =  [DWBAFNetworking sharedManager];
    //在中国地区获取不到app信息，然后再去美国地区获取
    NSString * pathUSA = [NSString stringWithFormat:@"https://itunes.apple.com/lookup?bundleId=%@",GET_BundleId];
    [manager POST:pathUSA parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        dispatch_async(dispatch_get_main_queue(), ^{
            //在美国地区获取到了app信息，创建弹窗
            [CXVersionUpdate createUI:responseObject AndShowFailAleat:isShowFailAleat];
        });
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}




//创建弹窗
+(void)createUI:(id)responseObject AndShowFailAleat:(BOOL)isShowFailAleat{
//    [SVProgressHUD dismiss];//移除
    //判断能否获取到数据
    if ([responseObject[@"resultCount"] integerValue]  == 0) {
        //app没上架获取不到数据
        NSLog(@"当前app还没上架，在AppStore无法获取信息~");
        if (isShowFailAleat==YES) {
            //提示
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"暂未发现新版本" message:nil preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                return ;
            }];
            [alertController addAction:okAction];
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
            
        }
        
    
        return;
    }
    //数据
    NSArray * arrayAppInfo = responseObject[@"results"];
    if (arrayAppInfo.count==0) {
        //获取不到数据
        NSLog(@"在AppStore无法获取信息~");
        if (isShowFailAleat==YES) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"暂未发现新版本" message:nil preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                return ;
            }];
            [alertController addAction:okAction];
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
        }
        return;
    }
    //appStore版本号
    NSString * appStoreVersion = arrayAppInfo.firstObject[@"version"];
    //判断能否获取到版本号,获取不到就返回
    if ([NSString isNULL:appStoreVersion]) {
        NSLog(@"在AppStore无法获取app版本号");
        if (isShowFailAleat==YES) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"暂未发现新版本" message:nil preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                return ;
            }];
            [alertController addAction:okAction];
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
        }
        return;
    }
    
    //appstore版本号转化数字
    NSInteger  appStoreVersionNum = [appStoreVersion stringByReplacingOccurrencesOfString:@"." withString:@""].integerValue;
    //本地版本号转化数字
    NSInteger  applocalVersionNum = GET_VERSION_Number.integerValue;
    
    //app版本更新内容说明
    NSString * appReleaseNotes = arrayAppInfo.firstObject[@"releaseNotes"];
    
    //如果appstore版本号大于本地app版本号就是发现新版本了
    if (appStoreVersionNum > applocalVersionNum) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [DownUpdateAppAleat downUpdateAppAleatWithVersion:appStoreVersion AndContent:appReleaseNotes];
        });
        
        NSLog(@"发现新版本~");
        
    }else{
        
        if ([NSString isNULL:appStoreVersion]) {
            if (isShowFailAleat==YES) {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"暂未发现新版本" message:nil preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                    return ;
                }];
                [alertController addAction:okAction];
                [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
            }
            return;
        }
        
        NSLog(@"未发现新版本，当前app在appStore最新版本号是：%@，当前本地版本号是：%@",appStoreVersion,GET_VERSION);
    }
    
}

/*
 
 //没数据
 {
 "resultCount":0,
 "results": []
 }
 
 //有数据
 
po responseObject
{
    resultCount = 1;
    results =     (
                   {
                       advisories =             (
                       );
                       appletvScreenshotUrls =             (
                       );
                       artistId = 1268925096;
                       artistName = "Wenqing Zhang";
                       artistViewUrl = "https://itunes.apple.com/us/developer/wenqing-zhang/id1268925096?uo=4";
                       artworkUrl100 = "https://is5-ssl.mzstatic.com/image/thumb/Purple128/v4/d7/1c/69/d71c69a5-58a9-2bcf-10d8-7f8c359ce74c/source/100x100bb.jpg";
                       artworkUrl512 = "https://is5-ssl.mzstatic.com/image/thumb/Purple128/v4/d7/1c/69/d71c69a5-58a9-2bcf-10d8-7f8c359ce74c/source/512x512bb.jpg";
                       artworkUrl60 = "https://is5-ssl.mzstatic.com/image/thumb/Purple128/v4/d7/1c/69/d71c69a5-58a9-2bcf-10d8-7f8c359ce74c/source/60x60bb.jpg";
                       bundleId = "com.xiumei.GongXiangJie";
                       contentAdvisoryRating = "4+";
                       currency = USD;
                       currentVersionReleaseDate = "2018-01-27T01:45:48Z";
                       description = "\U5171\U4eab\U8857\U2014\U2014\U5f00\U542f\U5feb\U4e50\U901b\U8857 \n\U5171\U4eab\U8857\Uff0c\U662f\U4e00\U6b3e\U57fa\U4e8eLBS\U5b9a\U4f4d\Uff0c\U968f\U65f6\U968f\U5730\U548c\U8eab\U8fb9\U7684\U964c\U751f\U4eba\U4e00\U8d77\U5171\U4eab\U5546\U5bb6\U7ea2\U5229\U3001\U5171\U4eab\U81ea\U8eab\U6280\U80fd\U7684\U795e\U5668\U3002\U5728\U901b\U8857\U4e2d\U5bfb\U627e\U8857\U53cb\U4e00\U8d77\U53c2\U52a0\U5546\U5bb6\U7684\U4f18\U60e0\U6d3b\U52a8\Uff0c\U4ece\U800c\U8fbe\U5230\U6d3b\U52a8\U95e8\U69db\Uff0c\U5171\U4eab\U4f4e\U4ef7\U7684\U4f18\U60e0\Uff1b\U5e76\U4e14\U8fd8\U80fd\U5728\U7b2c\U4e00\U65f6\U95f4\U83b7\U53d6\U5173\U6ce8\U5e97\U94fa\U7684\U4f18\U60e0\U4fe1\U606f\Uff0c\U7edd\U4e0d\U9519\U8fc7\U4efb\U4f55\U7cbe\U5f69\Uff01\U5171\U4eab\U8857\U4e0d\U4ec5\U8ba9\U4f60\U4f53\U9a8c\U5230\U901b\U8857\U7684\U4e50\U8da3\Uff0c\U8fd8\U53ef\U4ee5\U901a\U8fc7\U7ebf\U4e0b\U4ea4\U6613\U7ed3\U4ea4\U5fd7\U540c\U9053\U5408\U7684\U964c\U751f\U8857\U53cb\Uff01\n\U3010\U6ee1\U51cf\U62fc\U8d2d\U3011\U5171\U4eab\U4f60\U7684\U6ee1\U51cf\U4f18\U60e0\U5238\Uff0c\U9080\U8bf7\U8857\U53cb\U4e00\U8d77\U6765\U53c2\U52a0\U8fbe\U5230\U5546\U5bb6\U7684\U6d3b\U52a8\U95e8\U69db\Uff0c\U5171\U540c\U4eab\U53d7\U5546\U5bb6\U7684\U4f18\U60e0\Uff1b\U53ca\U65f6\U53d1\U73b0\U611f\U5174\U8da3\U7684\U62fc\U8d2d\U6d3b\U52a8\Uff0c\U548c\U8857\U53cb\U4e00\U8d77\U7ec4\U56e2\U8d2d\U4e70\Uff0c\U4eab\U53d7\U5546\U5bb6\U7684\U4f18\U60e0\U4e70\U5355\Uff1b\n\U3010\U5546\U5bb6\U4f18\U60e0\U3011\U968f\U65f6\U968f\U5730\U53d1\U73b0\U9644\U8fd1\U6216\U5404\U5927\U5546\U4e1a\U5708\U7684\U5546\U5bb6\U4f18\U60e0\Uff0c\U4e00\U952e\U53d1\U8d77\U62fc\U5355\Uff0c\U5bfb\U627e\U9700\U6c42\U76f8\U540c\U7684\U4eab\U53cb\Uff0c\U5171\U540c\U4eab\U53d7\U5546\U5bb6\U7684\U4f18\U60e0\Uff1b\U8fd8\U53ef\U4ee5\U6839\U636e\U4e2a\U4eba\U5174\U8da3\U5173\U6ce8\U5e97\U94fa\U5bfc\U8d2d\Uff0c\U7b2c\U4e00\U65f6\U95f4get\U5230\U559c\U7231\U5e97\U94fa\U7684\U4f18\U60e0\U6d3b\U52a8\Uff0c\U83b7\U53d6\U5e97\U94fa\U7684\U6700\U65b0\U4f18\U60e0\U4fe1\U606f\Uff0c\U53ca\U65f6\U5230\U5e97\U8d2d\U4e70\Uff0c\U7edd\U4e0d\U9519\U8fc7\U4efb\U4f55\U7cbe\U5f69\Uff01\n\U3010\U540c\U8da3\U8857\U53cb\U3011\U62fc\U5355\U7ed3\U8bc6\U76f8\U540c\U5174\U8da3\U7684\U8857\U53cb\n\U901b\U8857\U5c31\U7528\U5171\U4eab\U8857";
                       features =             (
                       );
                       fileSizeBytes = 50026496;
                       formattedPrice = Free;
                       genreIds =             (
                                               6005
                                               );
                       genres =             (
                                             "Social Networking"
                                             );
                       ipadScreenshotUrls =             (
                       );
                       isGameCenterEnabled = 0;
                       isVppDeviceBasedLicensingEnabled = 1;
                       kind = software;
                       languageCodesISO2A =             (
                                                         EN
                                                         );
                       minimumOsVersion = "8.0";
                       price = 0;
                       primaryGenreId = 6005;
                       primaryGenreName = "Social Networking";
                       releaseDate = "2017-09-22T20:42:49Z";
                       releaseNotes = "1\U3001\U53d1\U62fc\U8d2d\U53ef\U4ee5\U9009\U62e9\U66f4\U957f\U7684\U7b49\U5f85\U65f6\U95f4\U3002\n2\U3001\U90e8\U5206UI\U754c\U9762\U7684\U4f18\U5316\U3002\n3\U3001\U4fee\U590dbug~\U3002";
                       screenshotUrls =             (
                                                     "https://is5-ssl.mzstatic.com/image/thumb/Purple128/v4/f0/63/3d/f0633dba-cde1-1c07-4c68-9c6297e8cdf1/source/392x696bb.jpg",
                                                     "https://is1-ssl.mzstatic.com/image/thumb/Purple118/v4/4e/cf/85/4ecf857b-cda9-b35c-85df-050a0338f973/source/392x696bb.jpg",
                                                     "https://is3-ssl.mzstatic.com/image/thumb/Purple118/v4/6c/69/09/6c690933-46a4-2853-f4ac-8337148b49d0/source/392x696bb.jpg",
                                                     "https://is5-ssl.mzstatic.com/image/thumb/Purple118/v4/16/b3/df/16b3df48-863e-fd70-64d9-ca6347c7cd59/source/392x696bb.jpg"
                                                     );
                       sellerName = "Wenqing Zhang";
                       supportedDevices =             (
                                                       "iPad2Wifi-iPad2Wifi",
                                                       "iPad23G-iPad23G",
                                                       "iPhone4S-iPhone4S",
                                                       "iPadThirdGen-iPadThirdGen",
                                                       "iPadThirdGen4G-iPadThirdGen4G",
                                                       "iPhone5-iPhone5",
                                                       "iPodTouchFifthGen-iPodTouchFifthGen",
                                                       "iPadFourthGen-iPadFourthGen",
                                                       "iPadFourthGen4G-iPadFourthGen4G",
                                                       "iPadMini-iPadMini",
                                                       "iPadMini4G-iPadMini4G",
                                                       "iPhone5c-iPhone5c",
                                                       "iPhone5s-iPhone5s",
                                                       "iPadAir-iPadAir",
                                                       "iPadAirCellular-iPadAirCellular",
                                                       "iPadMiniRetina-iPadMiniRetina",
                                                       "iPadMiniRetinaCellular-iPadMiniRetinaCellular",
                                                       "iPhone6-iPhone6",
                                                       "iPhone6Plus-iPhone6Plus",
                                                       "iPadAir2-iPadAir2",
                                                       "iPadAir2Cellular-iPadAir2Cellular",
                                                       "iPadMini3-iPadMini3",
                                                       "iPadMini3Cellular-iPadMini3Cellular",
                                                       "iPodTouchSixthGen-iPodTouchSixthGen",
                                                       "iPhone6s-iPhone6s",
                                                       "iPhone6sPlus-iPhone6sPlus",
                                                       "iPadMini4-iPadMini4",
                                                       "iPadMini4Cellular-iPadMini4Cellular",
                                                       "iPadPro-iPadPro",
                                                       "iPadProCellular-iPadProCellular",
                                                       "iPadPro97-iPadPro97",
                                                       "iPadPro97Cellular-iPadPro97Cellular",
                                                       "iPhoneSE-iPhoneSE",
                                                       "iPhone7-iPhone7",
                                                       "iPhone7Plus-iPhone7Plus",
                                                       "iPad611-iPad611",
                                                       "iPad612-iPad612",
                                                       "iPad71-iPad71",
                                                       "iPad72-iPad72",
                                                       "iPad73-iPad73",
                                                       "iPad74-iPad74",
                                                       "iPhone8-iPhone8",
                                                       "iPhone8Plus-iPhone8Plus",
                                                       "iPhoneX-iPhoneX"
                                                       );
                       trackCensoredName = "\U5171\U4eab\U8857-\U5171\U4eab\U901b\U8857\U7684\U5feb\U4e50";
                       trackContentRating = "4+";
                       trackId = 1268925097;
                       trackName = "\U5171\U4eab\U8857-\U5171\U4eab\U901b\U8857\U7684\U5feb\U4e50";
                       trackViewUrl = "https://itunes.apple.com/us/app/%E5%85%B1%E4%BA%AB%E8%A1%97-%E5%85%B1%E4%BA%AB%E9%80%9B%E8%A1%97%E7%9A%84%E5%BF%AB%E4%B9%90/id1268925097?mt=8&uo=4";
                       version = "1.0.2";
                       wrapperType = software;
                   }
                   );
}
*/

@end
