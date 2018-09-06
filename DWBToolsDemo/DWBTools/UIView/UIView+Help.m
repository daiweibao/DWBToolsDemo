//
//  UIView+Help.m
//  GongXiangJie
//
//  Created by 戴维保 on 2017/6/27.
//  Copyright © 2017年 北京嗅美科技有限公司. All rights reserved.
//

#import "UIView+Help.h"

@implementation UIView (Help)

/**
 *  移除父视图里面的所有子控件
 */
- (void)removeAllSubviews {
    while (self.subviews.count) {
        UIView* child = self.subviews.lastObject;
        [child removeFromSuperview];
    }
}

//1.提供一个UIView的分类方法，这个方法通过响应者链条获取view所在的控制器
- (UIViewController *)parentController

{
    UIResponder *responder = [self nextResponder];
    while (responder) {
        
        if ([responder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)responder;
        }
        responder = [responder nextResponder];
    }
    return nil;
}

//2.通过控制器的布局视图可以获取到控制器实例对象(modal的展现方式需要取到控制器的根视图)
+ (UIViewController *)currentViewController {
    
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    
    // modal展现方式的底层视图不同
    
    // 取到第一层时，取到的是UITransitionView，通过这个view拿不到控制器
    UIView *firstView = [keyWindow.subviews firstObject];
    UIView *secondView = [firstView.subviews firstObject];
    UIViewController *vc = secondView.parentController;
    
    if ([vc isKindOfClass:[UITabBarController class]]) {
        
        UITabBarController *tab = (UITabBarController *)vc;
        
        if ([tab.selectedViewController isKindOfClass:[UINavigationController class]]) {
            
            UINavigationController *nav = (UINavigationController *)tab.selectedViewController;
            
            return [nav.viewControllers lastObject];
            
        } else {
            
            return tab.selectedViewController;
            
        }
        
    } else if([vc isKindOfClass:[UINavigationController class]]) {
        
        UINavigationController *nav = (UINavigationController *)vc;
        
        return [nav.viewControllers lastObject];
        
    } else {
        
        return vc;
        
    }
    
    return nil;
}



//获取Window当前显示的ViewController
+ (UIViewController*)getTopWindowController{
    //获得当前活动窗口的根视图
    UIViewController* vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (1)
    {
        //根据不同的页面切换方式，逐步取得最上层的viewController
        if ([vc isKindOfClass:[UITabBarController class]]) {
            vc = ((UITabBarController*)vc).selectedViewController;
        }
        if ([vc isKindOfClass:[UINavigationController class]]) {
            vc = ((UINavigationController*)vc).visibleViewController;
        }
        if (vc.presentedViewController) {
            vc = vc.presentedViewController;
        }else{
            break;
        }
    }
    return vc;
}




#pragma mark  - tableview滑到最底部
+ (void)scrollTableToFoot:(UITableView*)table Animated:(BOOL)animated
{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSInteger s = [table numberOfSections];  //有多少组
        if (s<1) return;  //无数据时不执行 要不会crash
        NSInteger r = [table numberOfRowsInSection:s-1]; //最后一组有多少行
        if (r<1) return;
        NSIndexPath *ip = [NSIndexPath indexPathForRow:r-1 inSection:s-1];  //取最后一行数据
        [table scrollToRowAtIndexPath:ip atScrollPosition:UITableViewScrollPositionBottom animated:animated]; //滚动到最后一行
    });
}


/**
 判断一块view是否在屏幕中
 
 @param myView  yes:在屏幕中 no：不在屏幕中
 */
+ (BOOL)isViewAddWindowUp:(UIView*)myView{
    // 如果本控制器的view显示在最前面，就下拉刷新（必须要判断，否点击其他tabbar也会触发刷新）
    // 判断一个view是否显示在根窗口上，该方法在UIView的分类中实现
    // 把这个view在它的父控件中的frame(即默认的frame)转换成在window的frame
    CGRect convertFrame = [myView.superview convertRect:myView.frame toView: [UIApplication sharedApplication].keyWindow];
    CGRect windowBounds = [UIApplication sharedApplication].keyWindow.bounds;
    // 判断这个控件是否在主窗口上（即该控件和keyWindow有没有交叉）
    BOOL isOnWindow = CGRectIntersectsRect(convertFrame, windowBounds);
    // 再判断这个控件是否真正显示在窗口范围内（是否在窗口上，是否为隐藏，是否透明）
    BOOL isShowingOnWindow = (myView.window == [UIApplication sharedApplication].keyWindow) && !myView.isHidden && (myView.alpha > 0.01) && isOnWindow;
    
    return isShowingOnWindow;
}



/**
 tableviewIOS11适配，明杰刷新跳动和组头组脚有空白

 @param tableView 滚动视图
 @param ishaveTabbar 底部是否有工具条，有工具条传入YES，没有传入NO
 */
+(void)tablevieiOS11:(UITableView*)tableView isHaveTabbar:(BOOL)ishaveTabbar{
#pragma mark =====继承：XMRootViewController用【系统导航栏的】的 iOS11 tableview偏移适配（放到tableview初始化里面）S==============
    if (@available(iOS 11.0, *)) {
        //1、tableView的section之间间距变大问题,解决办法：初始化的时候增加以下代码
        //tableView 头部视图和尾部视图出现一块留白问题
        //iOS11下tableview默认开启了self-Sizing，Headers, footers, and cells都默认开启Self-Sizing，所有estimated 高度默认值从iOS11之前的 0 改变为
        tableView.estimatedRowHeight =0;
        tableView.estimatedSectionHeaderHeight =0;
        tableView.estimatedSectionFooterHeight =0;
        //2、MJ刷新异常，上拉加载出现跳动刷新问题,解决办法：初始化的时候增加以下代码（tableView和collectionView类似）
        tableView.contentInsetAdjustmentBehavior =UIScrollViewContentInsetAdjustmentNever;
        if (ishaveTabbar==YES) {
            //底部有工具条
            tableView.contentInset =UIEdgeInsetsMake(0,0, 0, 0);//底部有tabbar或者工具条的不改变偏移
        }else{
            //底部无工具条
            tableView.contentInset =UIEdgeInsetsMake(0,0, MC_TabbarSafeBottomMargin, 0);//距离底部的距离，防止拉到最后被盖住
        }
        tableView.scrollIndicatorInsets =tableView.contentInset;
    }
    
    //其他默认要设置UITableView的组头组脚高度为0.01，否则默认都是20
    [tableView setSectionHeaderHeight:0.01f];
    [tableView setSectionFooterHeight:0.01f];

#pragma mark ======== iOS11 tableview偏移适配 E==============
}


/**
 collectionViewIOS11适配，明杰刷新跳动和组头组脚有空白
 
 @param collectionView 滚动视图
 @param ishaveTabbar 底部是否有工具条，有工具条传入YES，没有传入NO
 */
+(void)collectionViewiOS11:(UICollectionView *)collectionView isHaveTabbar:(BOOL)ishaveTabbar{
#pragma mark =====继承：XMRootViewController用【系统导航栏的】的 iOS11 tableview偏移适配（放到tableview初始化里面）S==============
    if (@available(iOS 11.0, *)) {
        //2、MJ刷新异常，上拉加载出现跳动刷新问题,解决办法：初始化的时候增加以下代码（tableView和collectionView类似）
        collectionView.contentInsetAdjustmentBehavior =UIScrollViewContentInsetAdjustmentNever;
        if (ishaveTabbar==YES) {
            //底部有工具条
            collectionView.contentInset =UIEdgeInsetsMake(0,0, 0, 0);//底部有tabbar或者工具条的不改变偏移
        }else{
            //底部无工具条
            collectionView.contentInset =UIEdgeInsetsMake(0,0, MC_TabbarSafeBottomMargin, 0);//距离底部的距离，防止拉到最后被盖住
        }
        collectionView.scrollIndicatorInsets =collectionView.contentInset;
    }
#pragma mark ======== iOS11 tableview偏移适配 E==============
}


/*
 
 //（1）iOS11适配
 if (@available(iOS 11.0, *)) {
 //MJ刷新异常，上拉加载出现跳动刷新问题,解决办法：初始化的时候增加以下代码（tableView和collectionView类似）
 [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIApplicationBackgroundFetchIntervalNever];
 //值从iOS11之后要设置的为0.01，否则默认都是20
 [[UITableView appearance] setEstimatedRowHeight:0.f];
 [[UITableView appearance] setEstimatedSectionHeaderHeight:0.f];
 [[UITableView appearance] setEstimatedSectionFooterHeight:0.f];
 }
 //iOS其他版本设置
 //其他默认要设置UITableView的组头组脚高度为0.01，否则默认都是20
 [[UITableView appearance] setSectionHeaderHeight:0.01f];
 [[UITableView appearance] setSectionFooterHeight:0.01f];
 
 //tableview的cell设置成默认不开启选中。若要开启请在指定tableview设置：cell.selectionStyle = UITableViewCellSelectionStyleGray;
 [[UITableViewCell appearance] setSelectionStyle:UITableViewCellSelectionStyleNone];
 
 */


/**
 获取控件在屏幕中的位置
 
 @param myView 控件
 @return size rect.origin.x, rect.origin.y
 */
+(CGRect)getViewIntWindowFrom:(UIView*)myView{
    UIWindow * window=[[[UIApplication sharedApplication] delegate] window];
    CGRect rect = [myView convertRect: myView.bounds toView:window];//在屏幕中的位置
    return rect;
}




/**
 给控件设置阴影

 @param myView 控件
 */
+(void)setupShadowView:(UIView*)myView{
    //    阴影的颜色
    myView.layer.shadowColor = [UIColor blackColor].CGColor;
    //    阴影的透明度
    myView.layer.shadowOpacity = 0.1f;
    //    阴影的圆角
    myView.layer.shadowRadius = 4.0f;//设置阴影半径能扩大阴影面积
    //    阴影的偏移量，设置成CGSizeMake(0,0);是4边都有阴影
    myView.layer.shadowOffset = CGSizeMake(0,0);
//    这里还要说明一点的是，当我们不设置阴影的偏移量的时候，默认值为(0,-3)，既阴影有3个点的向上偏移量。为什么是向上偏移呢？这好像有点不合常理，其实这是由‘历史原因’造成的，阴影最先是在MacOS平台上出现的，默认是向下偏移3个点，我们知道MacOS的坐标系统和iOS坐标系统y轴方向是相反的，所以在iOS系统中由于y轴方向的改变就变成了默认向上偏移3个点。
    
}


@end
