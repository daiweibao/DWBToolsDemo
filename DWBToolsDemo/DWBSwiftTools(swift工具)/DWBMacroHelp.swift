//
//  DWBMacroHelp.swift
//  DWBToolsDemo
//
//  Created by chaoxi on 2019/3/6.
//  Copyright © 2019 chaoxi科技有限公司. All rights reserved.
//

import UIKit

///MARK-----Swift头文件----------
///自动布局
import SnapKit

import ObjectMapper



///MARK-----宏定义----------

/// 宏定义屏幕宽高（相当于OC-Pch文件,注意变量函数必须用函数方式）
let SCREEN_WIDTH = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height

//屏幕宽度的封面9/16
let ImageHeight = SCREEN_WIDTH*9/16   //图片比例宽度


//iPhone6的界面布局是：屏幕是4.7英寸的，设计稿的大小为750x1334px。1被图为：375 * 667
//以iphone为设计稿：375 * 667 是UI设计稿的宽高，可自行根据UI修改【一般用在弹窗适配，比如签到弹窗必须在一个界面显示全，此方法不适合ipad】
//#define dwb_pt(l) l * [UIScreen mainScreen].bounds.size.width / 375.0 //做适配的界面的宽、高、字号都用它。

func dwb_pt(l:CGFloat) -> CGFloat {
    
    return 12
}



//获取系统版本号（是iOS9还是10）并判断系统版本号（函数）
func ios7orLater() ->Bool { return (UIDevice.current.systemVersion as NSString).doubleValue >= 7.0 }
func ios8orLater() -> Bool { return (UIDevice.current.systemVersion as NSString).doubleValue >= 8.0 }
func ios9orLater() -> Bool { return (UIDevice.current.systemVersion as NSString).doubleValue >= 9.0 }
func ios9_1orLater() -> Bool { return (UIDevice.current.systemVersion as NSString).doubleValue >= 9.1 }
func ios10_0orLater() -> Bool { return (UIDevice.current.systemVersion as NSString).doubleValue >= 10.0 }
//转换成swift的写法（三目）
let kIOS7 = (UIDevice.current.systemVersion as NSString).doubleValue >= 7.0 ? true :false
let kIOS8 = (UIDevice.current.systemVersion as NSString).doubleValue >= 8.0 ? true :false
func ios11_0orLater() -> Bool {
    if #available(iOS 11.0, *) {
        return true
    } else {
        return false
    }
}

//iPhone X 宏定义
func iPhoneX() ->Bool {
    let screenHeight = UIScreen.main.nativeBounds.size.height;//nativeBounds与bounds不同
    //iphoneX：2436  iphoneXR：1792  iphoneXS：2436 iphoneXS Max：2688
    if screenHeight == 2436 || screenHeight == 1792 || screenHeight == 2688 || screenHeight == 1624 {
        return true
    }
    return false
}

// 适配iPhone X 状态栏高度
func MC_StatusBarHeight() -> CGFloat {
    return iPhoneX() ? 44.0 : 20.0
}

// 适配iPhone X Tabbar高度
func MC_TabbarHeight() -> CGFloat {
    return iPhoneX() ? (44.0 + 34.0) : 39.0
}
// 适配iPhone X Tabbar距离底部的距离
func MC_TabbarSafeBottomMargin() -> CGFloat {
    return iPhoneX() ? 34.0 : 0.0
}

// 适配iPhone X 导航栏高度
func MC_NavHeight() -> CGFloat {
    return iPhoneX() ? 88.0 : 64.0
}

//宏定义适配滚动视图偏移
func contentInsetAdjus(scroller:UIScrollView){
    if #available(iOS 11.0, *) {
        scroller.contentInsetAdjustmentBehavior = .never
    } else {
        scroller.parentController().automaticallyAdjustsScrollViewInsets = false
    }
}


///取出sessionId
func SESSIONID() ->String {
    
    if NSString.isNULL(UserDefaults.standard.string(forKey: "sessionId")) {
        //值不存在,返回空
        return ""
        
    }else{
        //有值
        let sessionIdStr = UserDefaults.standard.string(forKey: "sessionId")!
        return sessionIdStr
    }
}

//取出用户类型（1是普通用户，2是设计师，3是主播用户）
func USER_type() ->String {
    if NSString.isNULL(UserDefaults.standard.string(forKey: "userType")) {
        //值不存在,返回空
        return ""
        
    }else{
        //有值
        return UserDefaults.standard.string(forKey: "userType")!
    }
}

//取出用户ID
func USERID() ->String {
    if NSString.isNULL(UserDefaults.standard.string(forKey: "userId")) {
        //值不存在,返回空
        return ""
        
    }else{
        //有值
        return UserDefaults.standard.string(forKey: "userId")!
    }
}

//取出用户名字
func USER_name() ->String {
    if NSString.isNULL(UserDefaults.standard.string(forKey: "userName")) {
        //值不存在,返回空
        return ""
        
    }else{
        //有值
        return UserDefaults.standard.string(forKey: "userName")!
    }
}

//用户观看直播中，用来判断直播中游客转用户登录的操作
func userjoinChatroom() ->String {
    if NSString.isNULL(UserDefaults.standard.string(forKey: "userjoinChatroom")) {
        //值不存在,返回空
        return ""
        
    }else{
        //有值
        return UserDefaults.standard.string(forKey: "userjoinChatroom")!
    }
}



//1.2版本主题色
let COLOR_Main = UIColor.colorWithHexString(hex: "#eb4c97")

/**
 *  RGB 随机颜色
 */
let Color_Random = UIColor.init(red:CGFloat(arc4random_uniform(255))/CGFloat(255.0), green:CGFloat( arc4random_uniform(255))/CGFloat(255.0), blue:CGFloat( arc4random_uniform(255))/CGFloat(255.0) , alpha: 1.0)

// 获取App的版本号
let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"]

// 获取App的build版本
let appBuildVersion = Bundle.main.infoDictionary?["CFBundleVersion"]

// 获取App的名称
let appName = Bundle.main.infoDictionary?["CFBundleDisplayName"]


//获取设备唯一标示，卸载后也不会变
let UUIDPhone = getUUID.getUUID()

