//
//  UIScrollView+Help.h
//  DWBToolsDemo
//
//  Created by 戴维保 on 2018/9/12.
//  Copyright © 2018年 北京嗅美科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (Help)
/**
 将UIScrollView内容滚动到【顶部】
 
 @param animated  是否显示动画
 */
- (void)scrollToTopAnimated:(BOOL)animated;

/**
 将UIScrollView内容滚动到【底部】
 
 @param animated  是否显示动画
 */
- (void)scrollToBottomAnimated:(BOOL)animated;

/**
 将UIScrollView内容滚动到【左边】
 
 @param animated  是否显示动画
 */
- (void)scrollToLeftAnimated:(BOOL)animated;

/**
 将UIScrollView内容滚动到【右边】
 
 @param animated  是否显示动画
 */
- (void)scrollToRightAnimated:(BOOL)animated;



/**
 UITableView滚动到最【底部】，效果好，只能传入UITableView

 @param table UITableView
 @param animated 是否展示滚动动画
 */
+ (void)scrollTableToFoot:(UITableView*)table Animated:(BOOL)animated;

@end
