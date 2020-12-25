//
//  DWB_URLHeader.h
//  DWBToolsDemo
//
//  Created by chaoxi on 2019/3/22.
//  Copyright © 2019 chaoxi科技有限公司. All rights reserved.
//
//OC接口头文件
#ifndef DWB_URLHeader_h
#define DWB_URLHeader_h

//dev
//#define OutInterent_IP @"http://jshop.dev.quanmin.top"

//线上
#define OutInterent_IP @"https://jshop.quanmin.top"


#pragma mark ===============接口地址 ===================

//首页商城
#define DWBPromotion [NSString stringWithFormat:@"%@/shop/promotion/get",OutInterent_IP]
//商品列表
#define GoodsList [NSString stringWithFormat:@"%@/shop/goods/list",OutInterent_IP]


#endif /* DWB_URLHeader_h */
