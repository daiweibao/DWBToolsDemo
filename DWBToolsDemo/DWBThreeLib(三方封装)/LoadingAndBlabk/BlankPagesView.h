//
//  BlankPagesView.h
//  AiHenDeChaoXi
//
//  Created by 戴维保 on 2018/4/17.
//  Copyright © 2018年 北京嗅美科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BlankPagesView : UIView

/**
 空白提示页面
 
 @param addViewSub 添加到那个控件上，是self.view 还是tableview
 @param scrollerView 滚动视图
 @param array 数组，数组为0才会显示空白页
 @param info 提示消息
 @param BkMinY 相对于父视图起始坐标
 */
+(void)createAndRemoveBlankUIWithaddSubview:(UIView*)addViewSub  AndScroller:(UIScrollView *)scrollerView AndArray:(NSArray *)array AndInfo:(NSString *)info AndMinY:(CGFloat )BkMinY;

@end

