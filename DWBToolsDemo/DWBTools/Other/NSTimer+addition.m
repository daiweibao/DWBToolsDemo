//
//  NSTimer+addition.m
//  WYHomeLoopView
//
//  Created by chaoxi on 2020/1/5.
//  Copyright © 2020年 chaoxi科技有限公司. All rights reserved.
//

#import "NSTimer+addition.h"

@implementation NSTimer (addition)

- (void)pause {
    if (!self.isValid) return;
    [self setFireDate:[NSDate distantFuture]];
}

- (void)resume {
    if (!self.isValid) return;
    [self setFireDate:[NSDate date]];
}

- (void)resumeWithTimeInterval:(NSTimeInterval)time {
    if (!self.isValid) return;
    [self setFireDate:[NSDate dateWithTimeIntervalSinceNow:time]];
}

+ (NSTimer *)wy_scheduledTimerWithTimeInterval:(NSTimeInterval)ti repeats:(BOOL)yesOrNo block:(void(^)(NSTimer *timer))block {
    
    return [self scheduledTimerWithTimeInterval:ti target:self selector:@selector(timeFired:) userInfo:block repeats:yesOrNo];
}

+ (void)timeFired:(NSTimer *)timer {
    void(^block)(NSTimer *timer) = timer.userInfo;
    
    if (block) {
        block(timer);
    }
}


//       //启动一个定时器
//       _timer = [NSTimer wy_scheduledTimerWithTimeInterval:self.timeInterval repeats:YES block:^(NSTimer *timer) {
//           [self everTime];
//       }];
//       [_timer pause];//定时器暂停

@end
