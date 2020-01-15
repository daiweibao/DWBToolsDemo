//
//  GetChatTime.h
//  GongXiangJie
//
//  Created by 戴维保 on 2017/7/26.
//  Copyright © 2017年 潮汐科技有限公司. All rights reserved.
//-

#import <Foundation/Foundation.h>
//聊天时间转换工具类（类似微信聊天界面）
@interface GetChatTime : NSObject

/**
 聊天时间转换器，非常好用

 @param TimeInterval 时间，传入毫秒，里面自动转为秒（double类型）
 @param needTime 是否显示昨天今天后面的时间
 @return 时间字符串
 */
+(NSString *)getMessageDateStringFromTimeInterval:(NSTimeInterval)TimeInterval andNeedTime:(BOOL)needTime;
@end
