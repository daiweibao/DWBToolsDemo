//
//  CXAudioTools.h
//  AiHenDeChaoXi
//
//  Created by 爱恨的潮汐 on 2018/4/9.
//  Copyright © 2018年 潮汐科技有限公司. All rights reserved.
//
  //必须导入这个框架，否则真机上无效：AudioToolBox.framework
//播放自定义音效，系统音效等等
#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
@interface CXAudioTools : NSObject
/** 播放系统音效,不带震动（手机震动模式下无声音），文件名字：@"xxx.wav"*/
+ (void)playSystemSoundWithAudioName:(NSString *)audioName;

/** 播放震动音效,带震动（手机震动模式下无声音），文件名字：@"xxx.wav"*/
+ (void)playAlertSoundWithAudioName:(NSString *)audioName;

/** 清空音效文件的内存*/
+ (void)clearMemory;

#pragma mark =================完美分割线========================
/**
 系统震动，什么模式下都只震动，每点击一次就震动一次
 */
+(void)playAlertZhenDong;


@end
