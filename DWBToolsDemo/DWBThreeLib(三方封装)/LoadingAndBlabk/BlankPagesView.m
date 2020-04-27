//
//  BlankPagesView.m
//  AiHenDeChaoXi
//
//  Created by 戴维保 on 2018/4/17.
//  Copyright © 2018年 北京嗅美科技有限公司. All rights reserved.
//

#import "BlankPagesView.h"
#import <MJRefresh/MJRefresh.h>
@interface BlankPagesView()

@end

@implementation BlankPagesView



/**
 空白提示页面
 
 @param addViewSub 添加到那个控件上，是self.view 还是tableview
 @param scrollerView 滚动视图
 @param array 数组，数组为0才会显示空白页
 @param info 提示消息
 @param info2 提示消息2
 @param imageName 空白图片名字
 @param BkMinY 相对于父视图起始坐标，-1代表默认起始坐标
 */
+(void)createAndRemoveBlankUIWithaddSubview:(UIView*)addViewSub  AndScroller:(UIScrollView *)scrollerView AndArray:(NSArray *)array AndInfo:(NSString *)info AndInfoTwo:(NSString *)info2 AndImageName:(NSString *)imageName AndMinY:(CGFloat )BkMinY{
    //默认最小值
    if (BkMinY == -1) {
        BkMinY = dwb_pt(116);
    }
    
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
        viewBlackBk.backgroundColor = addViewSub.backgroundColor;
        viewBlackBk.tag = 19921125;
        [addViewSub addSubview:viewBlackBk];
        viewBlackBk.frame = CGRectMake(0, BkMinY, SCREEN_WIDTH, addViewSub.height-BkMinY);
        
        //影藏刷新脚部
        scrollerView.mj_footer.hidden = YES;
        
        //空白icon 202 144 暂无数据 EmptyData
        UIImage *imageKB;
        if ([NSString isNULL:imageName]) {
            imageKB = [UIImage imageNamed:@"暂无数据"];
        }else{
           imageKB = [UIImage imageNamed:imageName];
        }
        UIImageView * imageBackIcon = [[UIImageView alloc]init];
        imageBackIcon.image = imageKB;
        [viewBlackBk addSubview:imageBackIcon];
        imageBackIcon.frame = CGRectMake((SCREEN_WIDTH-imageKB.size.width)/2, 0, imageKB.size.width, imageKB.size.height);
        if ([NSString isNULL:info]) {
            info = @"暂无数据";
        }
        //提示消息1
        UILabel *labelInfo = [[UILabel alloc]init];
        labelInfo.attributedText = [NSString getLabelLineSpace:info LineSpacing:8];
        labelInfo.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
        labelInfo.font = [UIFont boldSystemFontOfSize:14];
        labelInfo.userInteractionEnabled = YES;
        labelInfo.numberOfLines = 0;
        labelInfo.textAlignment = NSTextAlignmentCenter;
        [labelInfo sizeToFit];
        [viewBlackBk addSubview:labelInfo];
        labelInfo.frame = CGRectMake(16, imageBackIcon.bottomY+dwb_pt(36), SCREEN_WIDTH-40, 20);
        
        //提示消息2
        if ([NSString isNULL:info2]==NO) {
            UILabel *labelInfo2 = [[UILabel alloc]init];
            labelInfo2.attributedText = [NSString getLabelLineSpace:info2 LineSpacing:8];
            labelInfo2.textColor = [UIColor colorWithHexString:@"#808C97"];
            labelInfo2.font = [UIFont systemFontOfSize:12];
            labelInfo2.userInteractionEnabled = YES;
            labelInfo2.numberOfLines = 0;
            labelInfo2.textAlignment = NSTextAlignmentCenter;
            [labelInfo2 sizeToFit];
            [viewBlackBk addSubview:labelInfo2];
            labelInfo2.frame = CGRectMake(16, labelInfo.bottomY+dwb_pt(5), SCREEN_WIDTH-40, 20);
        }
    }
}




/**
 移除空白页

 @param addViewSub 父视图
 */
+(void)removeBlankUIWithaddSubview:(UIView*)addViewSub{
    //（1）找到view
    UIView * blankPagesFind = (UIView*)[addViewSub viewWithTag:19921125];
    //移除
    [blankPagesFind removeFromSuperview];
}


#pragma mark ========用法
/*
 //空白页处理逻辑【封装】
 [BlankPagesView createAndRemoveBlankUIWithaddSubview:weakself.tableView AndScroller:weakself.tableView AndArray:weakself.dataSouce AndInfo:@"暂无数据" AndInfoTwo:@"" AndImageName:nil AndMinY:-1];
 
 */

@end



