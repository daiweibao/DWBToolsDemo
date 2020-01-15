//
//  CXWebViewController.h
//  AiHenDeChaoXi
//
//  Created by 戴维保 on 2018/4/2.
//  Copyright © 2018年 潮汐科技有限公司. All rights reserved.
//
//项目公用无交互全屏网页。传入的是网址
#import <UIKit/UIKit.h>

@interface CXWebViewController : UIViewController
//标题
@property(nonatomic,strong)NSString * titleNavStr;
//网址
@property(nonatomic,strong)NSString * urlWebStr;

@end
