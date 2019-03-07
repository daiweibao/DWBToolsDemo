//
//  DWBMacroHelp.swift
//  DWBToolsDemo
//
//  Created by 戴维保 on 2019/3/6.
//  Copyright © 2019 潮汐科技有限公司. All rights reserved.
//

import UIKit

///MARK-----Swift头文件----------
///自动布局
import SnapKit



///MARK-----宏定义----------

/// 宏定义屏幕宽高（相当于OC-Pch文件,注意变量函数必须用函数方式）
let SCREEN_WIDTH = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height

//比例
let px = SCREEN_WIDTH/750.0   //高度和屏幕高度的比例，为了适配iphoneX

//屏幕宽度的封面9/16
let ImageHeight = SCREEN_WIDTH*9/16   //图片比例宽度

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

// iPhone X 宏定义
func iPhoneX() -> Bool {
    if UIScreen.main.bounds.width == 375 && UIScreen.main.bounds.height == 812{
        return true
    }else{
        return false
    }
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
let MAIN_COLOR = UIColor.colorWithHexString(hex: "#eb4c97")

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

