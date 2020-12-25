//
//  UIButton+BigAction.h
//  DWBToolsDemo
//
//  Created by chaoxi on 2018/9/12.
//  Copyright © 2018年 chaoxi科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (BigAction)
/**
 *  扩大button点击范围--向按钮的四个方向延伸响应面积
 *
 *  @param top    上间距
 *  @param left   左间距
 *  @param bottom 下间距
 *  @param right  右间距
 */
- (void)setButtonBigActionEdgeWithTop:(CGFloat) top right:(CGFloat) right bottom:(CGFloat) bottom left:(CGFloat) left; 
@end
