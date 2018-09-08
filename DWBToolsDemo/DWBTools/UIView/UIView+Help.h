//
//  UIView+Help.h
//  GongXiangJie
//
//  Created by 戴维保 on 2017/6/27.
//  Copyright © 2017年 北京嗅美科技有限公司. All rights reserved.
//-

#import <UIKit/UIKit.h>

@interface UIView (Help)

/**
 *  移除父视图里面的所有子控件
 */
- (void)removeAllSubviews;

/** 这个方法通过响应者链条获取view所在的控制器 */
- (UIViewController *)parentController;
/** 这个方法通过响应者链条获取view所在的控制器 */
+ (UIViewController *)currentViewController;

/**
 获取Window当前显示的ViewController
 
 @return 结果
 */
+ (UIViewController*)getTopWindowController;

/**
 tableview滑到最底部

 @return
 */

#pragma mark ===========滑到最底部===
+ (void)scrollTableToFoot:(UITableView*)table Animated:(BOOL)animated;
/**
 判断一块view是否在屏幕中
 
 @param myView yes:在屏幕中 no：不在屏幕中
 */
+ (BOOL)isViewAddWindowUp:(UIView*)myView;


/**
 tableviewIOS11、iPhoneX适配，明杰刷新跳动和组头组脚有空白

 @param tableView tablevew
 @param ishaveTabbar 当前界面是否有tabbar
 */
+(void)tablevieiOS11:(UITableView*)tableView isHaveTabbar:(BOOL)ishaveTabbar;
/**
 collectionViewIOS11适配，明杰刷新跳动和组头组脚有空白
 
 @param collectionView 滚动视图
 @param ishaveTabbar 底部是否有工具条，有工具条传入YES，没有传入NO
 */
+(void)collectionViewiOS11:(UICollectionView *)collectionView isHaveTabbar:(BOOL)ishaveTabbar;


/**
 获取控件在屏幕中的位置

 @param myView 控件
 @return size rect.origin.x, rect.origin.y
 */
+(CGRect)getViewIntWindowFrom:(UIView*)myView;

/**
 给控件设置阴影
 
 @param myView 控件
 */
+(void)setupShadowView:(UIView*)myView;



@end
