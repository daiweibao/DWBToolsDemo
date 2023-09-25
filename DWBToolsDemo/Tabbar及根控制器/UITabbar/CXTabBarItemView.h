//
//  CXTabBarItemView.h
//  ProductInfoFlow
//
//  Created by Shen Yu on 16/4/8.
//  Copyright © 2016年 Shen Yu. All rights reserved.
//
//自定义TabBar视图，底部屏幕那么宽的。中间凸出的tabbar
#import <UIKit/UIKit.h>
@class CXTabBarItemView;
@protocol TienUITabBarDelegate <NSObject>
///点击或者选中tabbar的代理回调，去切换控制器
- (void)tabBar:(CXTabBarItemView *)tabBar didSelectedBtnTo:(int)desIndex;

@end
@interface CXTabBarItemView : UIView
@property (nonatomic, weak) id<TienUITabBarDelegate> delegate;


/// 选中一个指定tabbar：如登录成功后后选中首页等
/// - Parameter index: 选中的角标，从0开始
- (void)selectMyTabbarItemWithIndex:(NSInteger )index;

@end
