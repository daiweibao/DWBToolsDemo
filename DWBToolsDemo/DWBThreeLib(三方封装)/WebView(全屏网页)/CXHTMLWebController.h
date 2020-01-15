//
//  CXHTMLWebController.h
//  AiHenDeChaoXi
//
//  Created by 戴维保 on 2018/4/17.
//  Copyright © 2018年 潮汐科技有限公司. All rights reserved.
//
//项目公用无交互全屏网页。传入的是HTML代码
#import <UIKit/UIKit.h>

@interface CXHTMLWebController : UIViewController
//标题
@property(nonatomic,strong)NSString * titleNavStr;
//HTML代码
@property(nonatomic,strong)NSString * htmlString;
@end
