//
//  BlankPagesTwoView.h
//  miniVideo
//
//  Created by 戴维保 on 2020/2/12.
//  Copyright © 2020 北京赢响国际科技有限公司. All rights reserved.
//
//空白页,带按钮
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BlankPagesTwoView : UIView

/**
空白提示页面【白色】

@param addViewSub 添加到那个控件上，是self.view 还是tableview
@param scrollerView 滚动视图
@param array 数组，数组为0才会显示空白页
@param info 提示消息
@param info2 提示消息
@param imageName 空白图片名字
@param BkMinY 相对于父视图起始坐标 -1代表默认起始坐标
@param actionButtonBlock 按钮点击事件回调
*/
+(void)createAndRemoveBlankUIWithaddSubview:(UIView*)addViewSub  AndScroller:(UIScrollView *)scrollerView AndArray:(NSArray *)array AndInfo1:(NSString *)info AndInfo2:(NSString *)info2 AndImageName:(NSString *)imageName AndButtonName:(NSString *)buttonName AndMinY:(CGFloat )BkMinY ActionButtonBlock:(void(^)(void))actionButtonBlock;

/*
 用法
 [BlankPagesTwoView createAndRemoveBlankUIWithaddSubview:self.view AndScroller:self.tableview AndArray:@[] AndInfo1:@"暂无数据" AndInfo2:@"" AndImageName:@"空白页-暂无消息" AndButtonName:@"去提现" AndMinY:-1 ActionButtonBlock:^{
     //按钮点击回调
 }];
 
 */

@end

NS_ASSUME_NONNULL_END
