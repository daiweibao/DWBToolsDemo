//
//  BlankPagesView.h
//  AiHenDeChaoXi
//
//  Created by 戴维保 on 2018/4/17.
//  Copyright © 2018年 潮汐科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BlankPagesView : UIView

/**
 空白提示页面【项目通用】
 
 @param addViewSub 添加到那个控件上，是self.view 还是tableview
 @param scrollerView 滚动视图
 @param array 数组，数组为0才会显示空白页
 @param info 提示消息1
 @param info2 提示消息2
 @param imageName 空白图片名字
 @param BkMinY 相对于父视图起始坐标 -1代表默认起始坐标
 */
+(void)createAndRemoveBlankUIWithaddSubview:(UIView*)addViewSub  AndScroller:(UIScrollView *)scrollerView AndArray:(NSArray *)array AndInfo:(NSString *)info AndInfoTwo:(NSString *)info2 AndImageName:(NSString *)imageName AndMinY:(CGFloat )BkMinY;

///**
// 移除空白页
// 
// @param addViewSub 父视图
// */
//+(void)removeBlankUIWithaddSubview:(UIView*)addViewSub;

/*
 用法：
  [BlankPagesView createAndRemoveBlankUIWithaddSubview:self.view AndScroller:nil AndArray:@[] AndInfo:@"暂无数据" AndInfoTwo:@"" AndImageName:@"空白页-暂无消息" AndMinY:-1];
 */

@end

