//
//  CXBaseViewController.h
//  AiHenDeChaoXi
//
//  Created by 戴维保 on 2023/8/18.
//  Copyright © 2023年 北京嗅美科技有限公司. All rights reserved.
//
//根控制器，在里面设置导航栏，让每个控制器都有自己的导航栏,方便修改【如：全民K歌APP用的就是这种方式的导航栏】
#import <UIKit/UIKit.h>

@interface CXBaseViewController : UIViewController
/**
 导航栏父视图
 */
@property(nonatomic,weak)UIView * navigationCXView;
/**
 导航标题
 */
@property (nonatomic,weak)UILabel *titleNavLabel;

/**
 返回按钮
 */
@property (nonatomic,weak)UIButton *backNavButton;


///导航栏返回点击事件
-(void)pressButtonLeft;


@end

