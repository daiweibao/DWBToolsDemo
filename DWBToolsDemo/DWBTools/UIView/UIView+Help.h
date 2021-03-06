//
//  UIView+Help.h
//  GongXiangJie
//
//  Created by chaoxi on 2017/6/27.
//  Copyright © 2017年 chaoxi科技有限公司. All rights reserved.
//-

#import <UIKit/UIKit.h>
//圆角设置方向
typedef NS_ENUM(NSInteger, DWBRadiusType) {
    RadiusType_All = 1,//四周都设置圆角
    RadiusType_Top = 2,//顶部设置圆角
    RadiusType_bottom = 3,//底部设置圆角
};
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

/**
 按钮设置指定圆角边角的圆角
 
 @param rectCorner UIRectCorner要切除的圆角
 @param borderColor 边框颜色
 @param borderWidth 边框宽度
 @param Radius 圆角大小
 */
-(void)setupRoundedCornersWithCutCorners:(UIRectCorner)rectCorner borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth AndRadius:(CGFloat )Radius;

/**
 用UIView创建一条虚线
 
 @param lineLength 虚线的宽度
 @param lineSpacing 虚线的间距
 @param lineColor  虚线的颜色
 */
-(void)drawXuXianWithlineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor;


/**
 高性能绘制圆角,省去clipsToBounds【UIBezierPath】
 
 @param radius 圆角大小
 */
-(void)drawCornerRadius:(CGFloat)radius;

/**
 高性能绘制圆角，包含边框，省去clipsToBounds【UIBezierPath】
 
 @param radius 圆角大小
 @param borderColor 边框颜色
 @param borderWidth 边框宽度
 */
-(void)drawCornerRadius:(CGFloat)radius borderColor:(UIColor *)borderColor AndBorderWidth:(CGFloat)borderWidth;


/**
 按钮设置指定j边角的圆角
 
 @param rectCorner UIRectCorner要切除的圆角
 @param borderColor 边框颜色
 @param borderWidth 边框宽度
 @param Radius 圆角大小
 */
- (void)setupRoundedCornersWithCutCorners:(UIRectCorner)rectCorner borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth AndRadius:(CGFloat )Radius;


/// 设置指定圆角【指定边角圆角】
/// @param radius 圆角大小
/// @param corner 圆角指定角
- (void)setup_Radius:(CGFloat)radius corner:(UIRectCorner)corner;



/// 绘制镂空的矩形、圆形等【周围半透明，中间一个圆】
/// @param view 父View
/// @param rect 镂空的坐标
/// @param radius 圆角
+ (void)drawShapeJXRectWith:(UIView *)view AndCGRect:(CGRect)rect AndCornerRadius:(CGFloat )radius;

@end
