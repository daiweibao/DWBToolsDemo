//
//  CXRootViewController.h
//  AiHenDeChaoXi
//
//  Created by 戴维保 on 2018/3/19.
//  Copyright © 2018年 潮汐科技有限公司. All rights reserved.
//
//根控制器，在里面设置导航栏，让每个控制器都有自己的导航栏,方便修改【如：全民K歌APP用的就是这种方式的导航栏】
#import <UIKit/UIKit.h>

@interface CXRootViewController : UIViewController
/**
 导航栏父视图
 */
@property(nonatomic,weak)UIView * navigationCXView;

/**
 返回按钮
 */
@property (nonatomic,weak)UIButton *backButton;

/**
 导航标题
 */
@property (nonatomic,weak)UILabel *titleNavLabel;


/**
 右边导航按钮
 */
@property (nonatomic,weak) UIButton *rightButton;

/**
 导航下面的线
 */
@property(nonatomic,weak)UIView *lineNav;

/**
 控制器内容View，用来添加加载中，如果不能挡住导航栏的情况下就添加到上面，其他空间添加发哦self.view上即可
 */
@property(nonatomic,weak)UIView * contentCXView;

/**
 导航返回按钮点击事件
 
 @param button 按钮
 */
- (void)pressButtonLeft:(UIButton*)button;


/**
 导航右边按钮点击事件

 @param button 按钮
 */
-(void)pressButtonRight:(UIButton*)button;


@end

