//
//  CXDinDinEventMessageHelp.m
//  cx
//
//  Created by 潮汐 on 2020/10/16.
//  Copyright © 2020 潮汐科技有限公司. All rights reserved.
//
//钉钉消息通知
#import "CXDinDinEventMessageHelp.h"
#import <RSSwizzle/RSSwizzle.h>

@interface CXDinDinEventMessageHelp()
/** 上报队列 */
@property (nonatomic, strong) NSMutableArray *textMArr;
@property (nonatomic, strong) dispatch_source_t gcdTimer;
@property (nonatomic, assign) NSInteger takeTime;// 花费时长
@property(nonatomic, copy) NSString *bundleShortVersionString;
@property(nonatomic, copy) NSString *bundleVersion;

+ (instancetype)sharedInstance;
@end

@implementation CXDinDinEventMessageHelp

+ (instancetype)sharedInstance {
    static CXDinDinEventMessageHelp *_sharedInstance = nil;

    if (_sharedInstance == nil) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _sharedInstance = [[[self class] alloc] init];
        });
    }

    return _sharedInstance;
}

- (instancetype)init {
    if (self = [super init]) {
        _textMArr = [NSMutableArray array];
    }
    return self;
}
//开始定时发送消息到钉钉
- (void)startTimer {
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    if (timer) {
        dispatch_source_set_timer(timer, dispatch_walltime(DISPATCH_TIME_NOW, NSEC_PER_SEC * 1), 3 *NSEC_PER_SEC, NSEC_PER_SEC * 1);
        dispatch_source_set_event_handler(timer, ^{
            [[CXDinDinEventMessageHelp sharedInstance] uploadTextQueue];
            self.takeTime += 3;
        });
        dispatch_resume(timer);
        self.gcdTimer = timer;
    }
}

///发起钉钉网络请求
- (void)uploadTextQueue {
    if (![CXDinDinEventMessageHelp isTom]) {
        return;
    }

    if ([CXDinDinEventMessageHelp sharedInstance].textMArr.count == 0) {
        return;
    }
    
    NSString *appName = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
    NSString *iosString = [NSString stringWithFormat:@"iOS %@",[[UIDevice currentDevice] systemVersion]];
    NSString *iosType;
    if ([DWBDeviceHelp isiPadDevice]==YES) {
        iosType = @"iPad";
    }else{
        iosType = @"iPhone";
    }
    
    NSString *content = [NSString stringWithFormat:@"App名字：%@ %@(%@)\n设备名字：%@（类型：%@，系统：%@）\n登录账号:%@\n---------下面是操作日志↓↓↓↓↓↓---------\n停留时长：%zds",
                         appName,//app名字
                         self.bundleShortVersionString,//版本号
                         self.bundleVersion,//build
                         [[UIDevice currentDevice] name],//设备名字
                         iosType,//手机类型
                         iosString,//系统号
                         self.takeTime];
    for (NSString *text in [CXDinDinEventMessageHelp sharedInstance].textMArr) {
        content = [NSString stringWithFormat:@"%@\n%@", content, text?:@""];
    }
    [[CXDinDinEventMessageHelp sharedInstance].textMArr removeAllObjects];

    NSString *atoken = @"ed24d557638cdf4e01144d1f4c986300503daae6bf65abbfc5c8ecd3684b0e52";
    if (atoken.length == 0) {
        return;
    }
    //关键词加密方式，内容必须包含：潮汐
    NSString *urStr = [NSString stringWithFormat:@"https://oapi.dingtalk.com/robot/send?access_token=%@", atoken];
    NSDictionary *data = @{@"msgtype":@"text",
                           @"text":@{@"content":[NSString stringWithFormat:@"%@\n(---来自潮汐自动)",content]}};
    NSURLSession *session = [NSURLSession sharedSession];
    NSURL *url = [NSURL URLWithString:urStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    request.HTTPBody = [NSJSONSerialization dataWithJSONObject:data options:NSJSONWritingPrettyPrinted error:nil];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
    }];
    [dataTask resume];
}

///是否开启统计
+ (BOOL)isTom {
    
#ifdef DEBUG
    //测试环境屏蔽
    if ([DWBDeviceHelp isiPadDevice]==YES) {
        //测试环境ipad--全部统计
        return YES;
    }else{
        //测试环境其他，屏蔽
        return NO;
    }
#else
    if ([DWBDeviceHelp isiPadDevice]==YES) {
        //ipad--全部统计
        return YES;
    }else{
//        //其他,判断符合测试账号才统计
//        if ([kUserName isEqual:@"13111111111"]) {
//            return YES;
//        }else{
//            return NO;
//        }
        return YES;
    }
#endif
    
}

+ (void)reportText:(NSString *)text {
    if (text.length == 0) {
        return;
    }
    [[CXDinDinEventMessageHelp sharedInstance].textMArr addObject:text];
}


- (NSString *)bundleShortVersionString {
    if (!_bundleShortVersionString) {
        _bundleShortVersionString = [[[NSBundle mainBundle]infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    }
    return _bundleShortVersionString;
}

- (NSString *)bundleVersion {
    if (!_bundleVersion) {
        _bundleVersion = [[[NSBundle mainBundle]infoDictionary] objectForKey:@"CFBundleVersion"];
    }
    return _bundleVersion;
}
@end

@implementation UIViewController (AlplpeRievew)

+ (void)load {
    [RSSwizzle swizzleInstanceMethod:@selector(viewDidAppear:) inClass:[UIViewController class] newImpFactory:^id(RSSwizzleInfo *swizzleInfo) {
        return ^void(__unsafe_unretained id self, BOOL animated) {
            if ([[self class] isKindOfClass:[UINavigationController class]]) {
                return;
            }
            else if ([NSStringFromClass([self class]) hasPrefix:@"UI"]) {
                return;
            }
            else if ([NSStringFromClass([self class]) hasPrefix:@"_UI"]) {
                return;
            }
            else if ([[self class] isSubclassOfClass:[UIViewController class]]) {
                NSString *text = [NSString stringWithFormat:@"e:%@", [self class]];
                [CXDinDinEventMessageHelp reportText:text];
            }

        };
    } mode:RSSwizzleModeAlways key:NULL];

    [RSSwizzle swizzleInstanceMethod:@selector(viewDidDisappear:) inClass:[UIViewController class] newImpFactory:^id(RSSwizzleInfo *swizzleInfo) {
        return ^void(__unsafe_unretained id self, BOOL animated) {
            if ([[self class] isKindOfClass:[UINavigationController class]]) {
                return;
            }
            else if ([NSStringFromClass([self class]) hasPrefix:@"UI"]) {
                return;
            }
            else if ([NSStringFromClass([self class]) hasPrefix:@"_UI"]) {
                return;
            }
            else if ([[self class] isSubclassOfClass:[UIViewController class]]) {
                NSString *text = [NSString stringWithFormat:@"l:%@", [self class]];
                [CXDinDinEventMessageHelp reportText:text];
            }
        };
    } mode:RSSwizzleModeAlways key:NULL];

    [RSSwizzle swizzleInstanceMethod:@selector(sendAction:to:from:forEvent:) inClass:[UIApplication class] newImpFactory:^id(RSSwizzleInfo *swizzleInfo) {
        return ^BOOL(__unsafe_unretained id self, SEL action, id target, id sender, UIEvent *event) {
            BOOL (*originalIMP)(__unsafe_unretained id, SEL, SEL, id, id, UIEvent*);
            originalIMP = (__typeof(originalIMP))[swizzleInfo getOriginalImplementation];
            BOOL res = originalIMP(self, @selector(sendAction:to:from:forEvent:), action, target, sender, event);

            __block BOOL isTouchEnd = NO;

            if (event && event.allTouches.count > 0) {
                [event.allTouches enumerateObjectsUsingBlock:^(UITouch * _Nonnull obj, BOOL * _Nonnull stop) {
                    if (obj.phase == UITouchPhaseEnded) {
                        isTouchEnd = YES;
                    }
                }];
            }

            if (isTouchEnd) {
                if ([sender isKindOfClass:[UIButton class]]) {
                    [CXDinDinEventMessageHelp reportText:[NSString stringWithFormat:@"c:%@", [sender currentTitle] ?  : @"其他"]];
                }
            }

            return res;
        };
    } mode:RSSwizzleModeAlways key:NULL];

    Class AppDelegate = NSClassFromString(@"AppDelegate");
    if (AppDelegate) {
        RSSwizzleInstanceMethod(AppDelegate,
                                @selector(applicationDidBecomeActive:),
                                RSSWReturnType(void),
                                RSSWArguments(UIApplication *application),
                                RSSWReplacement({
            RSSWCallOriginal(application);
            [CXDinDinEventMessageHelp reportText:@"B-A"];
        }), RSSwizzleModeAlways, NULL);
        RSSwizzleInstanceMethod(AppDelegate,
                                @selector(applicationDidEnterBackground:),
                                RSSWReturnType(void),
                                RSSWArguments(UIApplication *application),
                                RSSWReplacement({
            RSSWCallOriginal(application);
            [CXDinDinEventMessageHelp reportText:@"E-B"];
        }), RSSwizzleModeAlways, NULL);
    }
}

@end
