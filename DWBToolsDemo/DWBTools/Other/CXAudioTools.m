//
//  CXAudioTools.m
//  AiHenDeChaoXi
//
//  Created by 爱恨的潮汐 on 2018/4/9.
//  Copyright © 2018年 潮汐科技有限公司. All rights reserved.
//
  //必须导入这个框架，否则真机上无效：AudioToolBox.framework
#import "CXAudioTools.h"
#import <AudioToolbox/AudioToolbox.h>//震动
/** 缓存字典*/
static NSMutableDictionary *_soundIDDict;

@implementation CXAudioTools
// 只要头文件参与了编译调用
//+ (void)load

/** 缓存字典初始化*/
+ (void)initialize
{
    _soundIDDict = [NSMutableDictionary dictionary];
}
//@"xxx.wav"
+ (void)playSystemSoundWithAudioName:(NSString *)audioName
{
    // 不带震动的播放
    AudioServicesPlaySystemSound([self loadSoundIDWithAudioName:audioName]);
}

/** 播放震动音效*/
+ (void)playAlertSoundWithAudioName:(NSString *)audioName
{
    // 带震动的播放
    AudioServicesPlayAlertSound([self loadSoundIDWithAudioName:audioName]);//振动效果 需要#import <AudioToolbox/AudioToolbox.h>
    
}

#pragma mark 播放音效的公用方法
+ (SystemSoundID)loadSoundIDWithAudioName:(NSString *)audioName
{
//    @"xxx.wav"
    //1. 获取URL地址
    NSURL *url = [[NSBundle mainBundle] URLForResource:audioName withExtension:nil];

    // 思路思路
    // soundID重复创建 --> soundID每次创建, 就会有对应的URL地址产生
    // 可以将创建后的soundID 及 对应的URL 进行缓存处理
    
    //1. 获取URL的字符串
    NSString *urlStr = url.absoluteString;
    
    //2. 从缓存字典中根据URL来取soundID 系统音效文件，SystemSoundID==UInt32
    SystemSoundID soundID = [_soundIDDict[urlStr] intValue];
    
    //需要在刚进入的时候, 判断缓存字典是否有url对应的soundID
    
    //3. 判断soundID是否为0, 如果为0, 说明没有找到, 需要创建
    if (soundID == 0) {
        //3.1 创建音效文件
        AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &soundID);
        
        //3.2 缓存字典的添加键值
        _soundIDDict[urlStr] = @(soundID);
    }
    
    return soundID;
}


/** 清空音效文件的内存*/
+ (void)clearMemory
{
    //1. 遍历字典
    [_soundIDDict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
        //2. 清空音效文件的内存
        SystemSoundID soundID = [obj intValue];
        AudioServicesDisposeSystemSoundID(soundID);
    }];
}



#pragma mark =================完美分割线========================

/**
 系统震动,什么模式下都只震动，每点击一次就震动一次
 */
+(void)playAlertZhenDong{
    //必须导入这个框架，否则真机上无效：AudioToolBox.framework，====>>他妈的必须在手机铃声设置里打开震动才有效果。
    //系统震动
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);//振动效果 需要#import <AudioToolbox/AudioToolbox.h>
    
    
    //短震  3D Touch中的peek震动反馈
//    AudioServicesPlaySystemSound(1519);
//    //短震  3D Touch中的pop震动反馈
//    AudioServicesPlaySystemSound(1520);
//    //3D Touch 连续三次短震动
//    AudioServicesPlaySystemSound(1521);
    
    
 /*
    
    //iOS 9.0 才有3D touch(需要这样判断的时候打开这段代码)
    if (ios9orLater) {
        //判断手机是否有3D touch功能
        if ([UIApplication sharedApplication].keyWindow.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
            //有3Dtouch功能
            //短震  3D Touch中的peek震动反馈
            AudioServicesPlaySystemSound(1519);
        }else{
            //没有3D touch
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);//振动效果 需要#import <AudioToolbox/AudioToolbox.h>
        }
    }else{
        //没有3D touch
          AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);//振动效果 需要#import <AudioToolbox/AudioToolbox.h>
        
    }
  
  */
}


@end
