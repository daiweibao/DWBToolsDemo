//
//  NSTimer+addition.h
//  WYHomeLoopView
//
//  Created by 戴维保 on 2020/1/5.
//  Copyright © 2020年 潮汐科技有限公司. All rights reserved.
//
//定时器
#import <Foundation/Foundation.h>

@interface NSTimer (addition)

- (void)pause;
- (void)resume;
- (void)resumeWithTimeInterval:(NSTimeInterval)time;

+ (NSTimer *)wy_scheduledTimerWithTimeInterval:(NSTimeInterval)ti repeats:(BOOL)yesOrNo block:(void(^)(NSTimer *timer))block;

@end
