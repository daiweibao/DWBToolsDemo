//
//  UIView+Animation.h
//  DWBToolsDemo
//
//  Created by 戴维保 on 2018/9/6.
//  Copyright © 2018年 北京嗅美科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Animation)
/**
 *  带弹簧效果的点赞放大
 *
 *  @param aView 传入要变大的控件
 */
+ (void) shakeToShow:(UIView*)aView;


/**
 *  弹窗带弹簧抖动的view
 *
 *  @param viewbig 传入要抖动的View
 *  @return 空
 */

+ (void) animationAlert:(UIView *)viewbig;

/**
 *  移除父视图里面的所有子控件
 */
@end
