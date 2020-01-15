//
//  BlankPagesView.m
//  AiHenDeChaoXi
//
//  Created by 戴维保 on 2018/4/17.
//  Copyright © 2018年 潮汐科技有限公司. All rights reserved.
//

#import "BlankPagesView.h"
#import "MJRefresh.h"
@interface BlankPagesView()

@end

@implementation BlankPagesView



/**
 空白提示页面
 
 @param addViewSub 添加到那个控件上，是self.view 还是tableview
 @param scrollerView 滚动视图
 @param array 数组，数组为0才会显示空白页
 @param info 提示消息
 @param BkMinY 相对于父视图起始坐标
 */
+(void)createAndRemoveBlankUIWithaddSubview:(UIView*)addViewSub  AndScroller:(UIScrollView *)scrollerView AndArray:(NSArray *)array AndInfo:(NSString *)info AndMinY:(CGFloat )BkMinY{
    //（1）找到view
    UIView * blankPagesFind = (UIView*)[addViewSub viewWithTag:19921125];
    //移除
    [blankPagesFind removeFromSuperview];
    //打开刷新脚步
    scrollerView.mj_footer.hidden = NO;
    //（2）判断如果数据为空才创建空白页
    if (array.count==0) {
        //设置背景颜色
        UIView * viewBlackBk = [[UIView alloc]init];
        viewBlackBk.backgroundColor = [UIColor groupTableViewBackgroundColor];
        viewBlackBk.tag = 19921125;
        [addViewSub addSubview:viewBlackBk];
        viewBlackBk.frame = CGRectMake(0, BkMinY, SCREEN_WIDTH, addViewSub.height-BkMinY);
        
        //影藏刷新脚部
        scrollerView.mj_footer.hidden = YES;
        
        //空白icon 336 202
        UIImageView * imageBackIcon = [[UIImageView alloc]init];
        imageBackIcon.image = [UIImage imageNamed:@"空白页icon"];
        [viewBlackBk addSubview:imageBackIcon];
        CGFloat imageHeight = GetImageHeight(192, 384, 276);
        imageBackIcon.frame = CGRectMake((SCREEN_WIDTH-192)/2, 80, 192, imageHeight);
        
        if ([NSString isNULL:info]) {
            info = @"暂无数据";
        }
        //提示消息
        UILabel *labelInfo = [[UILabel alloc]init];
        labelInfo.attributedText = [NSString getLabelLineSpace:info LineSpacing:8];
        labelInfo.textColor = [UIColor colorWithHexString:@"#666666"];
        labelInfo.font = [UIFont systemFontOfSize:12];
        labelInfo.userInteractionEnabled = YES;
        labelInfo.numberOfLines = 0;
        labelInfo.textAlignment = NSTextAlignmentCenter;
        [labelInfo sizeToFit];
        [viewBlackBk addSubview:labelInfo];
        labelInfo.frame = CGRectMake(16, imageBackIcon.bottomY+20, SCREEN_WIDTH-40, 20);
        
    }
}

@end



