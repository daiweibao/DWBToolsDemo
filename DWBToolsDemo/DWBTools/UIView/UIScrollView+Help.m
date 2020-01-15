//
//  UIScrollView+Help.m
//  DWBToolsDemo
//
//  Created by 戴维保 on 2018/9/12.
//  Copyright © 2018年 潮汐科技有限公司. All rights reserved.
//

#import "UIScrollView+Help.h"

@implementation UIScrollView (Help)

/**
 将UIScrollView内容滚动到【顶部】
 
 @param animated  是否显示动画
 */
- (void)scrollToTopAnimated:(BOOL)animated {
    CGPoint off = self.contentOffset;
    off.y = 0 - self.contentInset.top;
    [self setContentOffset:off animated:animated];
}
/**
 将UIScrollView内容滚动到【底部】
 
 @param animated  是否显示动画
 */
- (void)scrollToBottomAnimated:(BOOL)animated {
    CGPoint off = self.contentOffset;
    off.y = self.contentSize.height - self.bounds.size.height + self.contentInset.bottom;
    [self setContentOffset:off animated:animated];
}
/**
 将UIScrollView内容滚动到【左边】
 
 @param animated  是否显示动画
 */
- (void)scrollToLeftAnimated:(BOOL)animated {
    CGPoint off = self.contentOffset;
    off.x = 0 - self.contentInset.left;
    [self setContentOffset:off animated:animated];
}
/**
 将UIScrollView内容滚动到【右边】
 
 @param animated  是否显示动画
 */
- (void)scrollToRightAnimated:(BOOL)animated {
    CGPoint off = self.contentOffset;
    off.x = self.contentSize.width - self.bounds.size.width + self.contentInset.right;
    [self setContentOffset:off animated:animated];
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

@end
