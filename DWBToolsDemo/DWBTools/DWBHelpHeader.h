//
//  DWBHelpHeader.h
//  ZuiMeiXinNiang
//
//  Created by 戴维保 on 2017/8/24.
//  Copyright © 2017年 潮汐科技有限公司. All rights reserved.
//

//这里是类别的头文件和和所有+宏定义

//警告：因为APP在启动的时候会加载所有的分类，全部添加可能会影响启动速度。
//三方依赖：pod 'AFNetworking'  pod 'FLAnimatedImage'  pod 'Masonry'

#ifndef DWBHelpHeader_h
#define DWBHelpHeader_h

#pragma mark ============ 系统头文件 S=====================
#import<Foundation/Foundation.h>//必须导入
#import <UIKit/UIKit.h>//必须导入

//iOS项目打包除去NSLog，Edit Scheme –>info—> Building Config ->release/debug 选择 release 时 （包括运行）所有的输出都不见了
#ifdef DEBUG
//NSLog格式化打印，打印出在那个l控制器，哪一行
#define NSLog(fmt, ...) NSLog((@"%s [第%d行] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define NSLog(...)
#endif

//DEBUG 设置方式：选择Product->Scheme->Edit Scheme ，App发布的时候,Build Configuration 这些全部都要改成release模式。
//iOS debug模式和release模式
#ifdef DEBUG
//开发环境
#else
//发布环境
#endif



#pragma mark ============ 系统头文件 E=====================


//// 如果定义了macro_name宏就编译代码段1
//#ifdef macro_name
//代码段1
//#else
//代码段2
//#endif


#pragma mark ============ 工具类相互依赖的头文件 S=====================
//纯文字提示框--HUD
#import "DWBToast.h"
//HUD
#import "MBProgressHUD+MJ.h"
//字符串category
#import "NSString+DWBHelp.h"
//计算图片高度
#import "NSString+GetImageHeight.h"
//可以复制的label
#import "CopyLabel.h"
//悬浮拖拽的button
#import "DragEnableButton.h"
//得到UUID，卸载也不会变
#import "getUUID.h"
//字典类别（Category）
#import "NSDictionary+CXHelp.h"
//button图文展示
#import "UIButton+SSEdgeInsets.h"
//十六进制颜色
#import "UIColor+DWBHelp.h"
//点击手势
#import "UIView+ActionTap.h"
//UIView
#import "UIView+Help.h"
//动画
#import "UIView+Animation.h"
//UIView布局
#import "UIView+Extension.h"
//自己封装的弹窗
#import "DWBAlertView.h"
//图片
#import "UIImage+MyImage.h"
#import "UIImage+PlayGif.h"
#import "UIImage+Rotate.h"
//布局
#import "Masonry.h"
//svp
#import "SVProgressHUD+KZ.h"
//MBP
#import "MBProgressHUD+MJ.h"
//label点击指定汉子
#import "UILabel+Click.h"
//富文本
#import "NSString+DWBAttribute.h"
//钥匙串存储数据
#import "KeyChainManager.h"
//设备相关
#import "DWBDeviceHelp.h"
//网络
#import "DWBAFNetworking.h"
//
#import "UIViewController+CXHelp.h"
//数组
#import "NSArray+DWBHelp.h"
//控制器
#import "UIViewController+DWControllerHelp.h"


#pragma mark ============ 工具类相互依赖的头文件 E=====================



#pragma mark ============ 三方库封装头文件 S=====================
#import "DWB_refresh.h"
#import "DWBAPPManager.h"//项目配置

#pragma mark ============ 三方库封装头文件 E=====================


//=================判断如果是模拟器===========
#if TARGET_IPHONE_SIMULATOR
//走这里是模拟器
#else
//否则是真机
#endif

//Appstore地址==1404123635(王府管家)  //只需要修改后面的App-Id即可
#define AppstoreId  @"1404123635"
#define AppstoreUrl  [NSString stringWithFormat:@"https://itunes.apple.com/cn/app/id%@",AppstoreId]


#pragma mark ========内联函数 inline替代宏定义 ===============
/*
 为什么inline能取代宏？
 
 优点相比于函数:
 
 inline函数避免了普通函数的,在汇编时必须调用call的缺点:取消了函数的参数压栈，减少了调用的开销,提高效率.所以执行速度确比一般函数的执行速度要快.
 2)集成了宏的优点,使用时直接用代码替换(像宏一样);
 
 优点相比于宏:
 
 1)避免了宏的缺点:需要预编译.因为inline内联函数也是函数,不需要预编译.
 
 2)编译器在调用一个内联函数时，会首先检查它的参数的类型，保证调用正确。然后进行一系列的相关检查，就像对待任何一个真正的函数一样。这样就消除了它的隐患和局限性。
 
 3)可以使用所在类的保护成员及私有成员。
 
 inline内联函数的说明
 
 1.内联函数只是我们向编译器提供的申请,编译器不一定采取inline形式调用函数.
 2.内联函数不能承载大量的代码.如果内联函数的函数体过大,编译器会自动放弃内联.
 3.内联函数内不允许使用循环语句或开关语句.
 4.内联函数的定义须在调用之前.

 调用：RGBA_COLOR_inline(12, 12, 12, 1.0);
 */

//内联函数定义颜色RGB
static inline UIColor * RGBA_COLOR_inline(CGFloat R,CGFloat G,CGFloat B,CGFloat A) {
    return [UIColor colorWithRed:((R) / 255.0f) green:((G) / 255.0f) blue:((B) / 255.0f) alpha:A];
}

static inline NSString * myMane(){
    return @"潮汐";
}

#pragma mark ============ 宏定义=====================


//屏幕宽度
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
//屏幕高度
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

//屏幕宽度的封面9/16
#define ImageHeight  SCREEN_WIDTH*9/16   //图片比例宽度

//iPhone6的界面布局是：屏幕是4.7英寸的，设计稿的大小为750x1334px。1被图为：375 * 667
//以iphone为设计稿：375 * 667 是UI设计稿的宽高，可自行根据UI修改【一般用在弹窗适配，比如签到弹窗必须在一个界面显示全，此方法不适合ipad】
#define dwb_pt(l) l * [UIScreen mainScreen].bounds.size.width / 375.0 //做适配的界面的宽、高、字号都用它。


//【iphoneX宏定义】判断是否为 iPhoneXS Max，iPhoneXS，iPhoneXR，iPhoneX
//iPhoneX和iPhoneXS
#define XH_IPHONEX  ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
//iPhoneXR
#define XH_IPHONEXR ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) : NO)
//iPhoneXR-模拟器（特殊）
#define XH_IPHONEXR_Simulator [[UIScreen mainScreen] bounds].size.width == 375.0f && [[UIScreen mainScreen] bounds].size.height == 812.0f
// iPhoneXS Max
#define XH_IPHONEXSMAX    ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) : NO)
//最终判断，依赖上面宏定义
#define iPhoneX ((XH_IPHONEX || XH_IPHONEXR || XH_IPHONEXSMAX || XH_IPHONEXR_Simulator) ? YES : NO)

//static inline BOOL isIPhoneXSeries() {
//    if (@available(iOS 11.0, *)) {
//        UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
//        if (mainWindow.safeAreaInsets.bottom > 0.0) {
//            return YES;
//        }
//    }
//    return NO;
//}


// 适配iPhone X 状态栏高度
#define  MC_StatusBarHeight      (iPhoneX ? 44.f : 20.f)
// 适配iPhone X Tabbar高度
#define  MC_TabbarHeight         (iPhoneX ? (49.f+34.f) : 49.f)
// 适配iPhone X Tabbar距离底部的距离
#define  MC_TabbarSafeBottomMargin         (iPhoneX ? 34.f : 0.f)
// 适配iPhone X 导航栏高度
#define  MC_NavHeight  (iPhoneX ? 88.f : 64.f)


//对于大量页面需要设置 contentInsetAdjustmentBehavior属性 仅需在appdelegate 里边设置就可 全局适配
//iOS11安全边距适配，防止tableview偏移。automaticallyAdjustsScrollViewInsets = NO
#define  adjustsScrollViewInsets_NO(scrollView,vc)\
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
if ([UIScrollView instancesRespondToSelector:NSSelectorFromString(@"setContentInsetAdjustmentBehavior:")]) {\
[scrollView   performSelector:NSSelectorFromString(@"setContentInsetAdjustmentBehavior:") withObject:@(2)];\
} else {\
vc.automaticallyAdjustsScrollViewInsets = NO;\
}\
_Pragma("clang diagnostic pop") \
} while (0)
// adjustsScrollViewInsets_NO(self.tableView, self);//用法
/*
 if (@available(iOS 11.0, *)) {
 self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
 } else {
 self.automaticallyAdjustsScrollViewInsets = NO;
 }
 */

//声明一个弱引用,##是连接的作用, 即当使用上面的宏会把weak与输入的type值连接起来如下图:
#define WeakSelf(type)  __weak typeof(type) weak##type = type;
//强引用
#define StrongSelf(type)  __strong typeof(type) Strong##type = type;


//生成手机唯一标识UUID--UDID，卸载后也不会变
#define UUIDPhone  [getUUID getUUID]

/**
 给出自己想要的图片宽度，知道UI给的图片的宽、高用比例计算出图片的【高度】。

 @param My_W 自己根据屏幕款算算出的宽度，为了不超过屏幕宽度
 @param W UI给的图片宽度
 @param H UI给的图片高度
 @return 返回计算出来的图片高度
 */
#define GetImageHeight(My_W, W, H) [NSString getHieghtWithMyWidth:My_W AndUIWidth:W AndUIHeight:H]

//十六进制颜色--带#号传入
#define DWBColorHex(hex)   [UIColor colorWithHexString:hex]
/**
 带#号的十六进制颜色转换,可以设置透明度，必须带#号

 @param coloHexStr 带#号的颜色字符串
 @param alpha 透明度
 @return 结果
 */
#define Color_HexStr(coloHexStr, alpha) [UIColor colorWithHexString:coloHexStr AndAlpha:alpha]

//颜色，可以设置透明度，默认为1
#define RGBA_COLOR(R, G, B, A) [UIColor colorWithRed:((R) / 255.0f) green:((G) / 255.0f) blue:((B) / 255.0f) alpha:A]
/**
 *  随机颜色
 */
#define RGBA_Random  [UIColor colorWithRed:random()%255/255.0 green:random()%255/255.0 blue:random()%255/255.0 alpha:1]

//宏定义颜色
#define MAIN_COLOR [UIColor colorWithHexString:@"#44617B"]//主题色(蓝紫色)--王府管家

#define MAIN_COLOR_AlertBJ [UIColor colorWithRed:129/255.0 green:129/255.0 blue:129/255.0 alpha:0.7]//蒙版半透明黑色背景

//十六进制颜色--带#号传入(依赖类：UIColor+DWBHelp)
#define UIColorHex(_hex_)   [UIColor colorWithHexString:((__bridge NSString *)CFSTR(_hex_))]


//获取app logo图片可以显示图片名字
#define appLogoName [[[[NSBundle mainBundle] infoDictionary] valueForKeyPath:@"CFBundleIcons.CFBundlePrimaryIcon.CFBundleIconFiles"] lastObject]

//获取版本号，带小数点
#define GET_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
//获取版本号纯数字(字符串格式，3.4.0版本修改，2017年9月17日)
#define GET_VERSION_Number  [GET_VERSION stringByReplacingOccurrencesOfString:@"." withString:@""]
//app build版本
#define GET_appBuild  [infoDictionary objectForKey:@"CFBundleVersion"]

//获取appBundleID
#define GET_BundleId [[NSBundle mainBundle] bundleIdentifier]
//获取APP名字
#define GET_APPName [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]
//手机别名：用户定义的名称（如爱恨的潮汐）
#define GET_userPhoneName [[UIDevice currentDevice] name]


//哦~我忘记说了[[UIDevice currentDevice] systemVersion].floatValue这个方法也是不靠谱的，好像在8.3版本输出的值是8.2，记不清楚了反正是不靠谱的，所以建议大家用[[UIDevice currentDevice] systemVersion]这个方法！
#define ios7orLater [UIDevice currentDevice].systemVersion.floatValue>=7.0

#define ios8orLater @available(iOS 8.0, *)

#define ios9orLater @available(iOS 9.0, *)

#define ios9_1orLater @available(iOS 9.1, *)

#define ios10_0orLater @available(iOS 10.0, *)

#define ios10_3orLater @available(iOS 10.3, *)

//判断ios11 系统的宏这样写 判断时候就不会报警告-主要用,代表大于iOS11
#define ios11_0orLater @available(iOS 11.0, *)
//下边的这种写法判断iOS11会报警高很烦-不用
//#define IOS11 ([[UIDevice currentDevice].systemVersion intValue] >= 11 ? YES : NO)

/** 设备是否为iPhone 4/4S 分辨率320x480，像素640x960，@2x */
#define iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

/** 设备是否为iPhone 5C/5/5S 分辨率320x568，像素640x1136，@2x */
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

/** 设备是否为iPhone 6 分辨率375x667，像素750x1334，@2x */
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)

/** 设备是否为iPhone 6 Plus 分辨率414x736，像素1242x2208，@3x */
#define iPhone6P ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)


/**
 简单Alert提示

 @param title 标题
 @return 结果
 */
#define DWBAlertShow(msg) \
UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:msg preferredStyle:UIAlertControllerStyleAlert]; \
UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]; \
[alertController addAction:okAction]; \
[[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];

//通知宏定义：接收、发送、移除
#define NOTIF_ADD(sele, n, obj)  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sele) name:n object:obj]
#define NOTIF_POST(n, obj)    [[NSNotificationCenter defaultCenter] postNotificationName:n object:obj]
#define NOTIF_REMV()        [[NSNotificationCenter defaultCenter] removeObserver:self]

//主题色
#define COLOR_Main [UIColor colorWithHexString:@"#f94747"]
//分割线颜色【细】
#define COLOR_Line_Small [UIColor colorWithHexString:@"#e6e6e6"]
//分割线颜色【粗】
#define COLOR_Line_Big [UIColor colorWithHexString:@"#f6f6f6"]


#pragma mark ===============项目相关 S ==================
//取出用户ID
#define USERID [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"member_uid"]]
//取出用户昵称
#define USER_name [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"alias"]]
//取出用户头像连接
#define USER_PhoneImage [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"headPortrait"]]
//取出用户登录状态
#define SESSIONID [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"sessionId"]]



//默认头像图片名字
#define default_HeaderImage @"person_head_default"
//默认图片（横向封面图）
#define default_CoverImage @"mall_banner_ default"

#pragma mark ===============项目相关 E ==================


#endif /* DWBHelpHeader_h */
