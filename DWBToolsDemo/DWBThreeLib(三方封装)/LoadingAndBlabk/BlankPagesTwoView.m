//
//  BlankPagesTwoView.m
//  miniVideo
//
//  Created by chaoxi on 2020/2/12.
//  Copyright © 2020 北京chaoxi科技有限公司. All rights reserved.
//

#import "BlankPagesTwoView.h"
#import <MJRefresh/MJRefresh.h>
@interface BlankPagesTwoView()

@end

@implementation BlankPagesTwoView


+(void)createAndRemoveBlankUIWithaddSubview:(UIView*)addViewSub  AndScroller:(UIScrollView *)scrollerView AndArray:(NSArray *)array AndInfo1:(NSString *)info AndInfo2:(NSString *)info2 AndImageName:(NSString *)imageName AndButtonName:(NSString *)buttonName AndMinY:(CGFloat )BkMinY ActionButtonBlock:(void(^)(void))actionButtonBlock{
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
        labelInfo.textColor = [UIColor colorWithHexString:@"#272030"];
        labelInfo.font = [UIFont boldSystemFontOfSize:16];
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
            labelInfo2.textColor = [UIColor colorWithHexString:@"#A2A2A2"];
            labelInfo2.font = [UIFont systemFontOfSize:12];
            labelInfo2.userInteractionEnabled = YES;
            labelInfo2.numberOfLines = 0;
            labelInfo2.textAlignment = NSTextAlignmentCenter;
            [labelInfo2 sizeToFit];
            [viewBlackBk addSubview:labelInfo2];
            labelInfo2.frame = CGRectMake(16, labelInfo.bottomY+dwb_pt(5), SCREEN_WIDTH-40, 20);
        }
        
        if ([NSString isNULL:imageName]==NO) {//判空
            //按钮
            UILabel *retryBtn = [[UILabel alloc]init];
            retryBtn.frame = CGRectMake((viewBlackBk.width-dwb_pt(300))/2, labelInfo.bottomY + dwb_pt(74), dwb_pt(300), dwb_pt(44));
            retryBtn.font = [UIFont boldSystemFontOfSize:16];
            retryBtn.text = buttonName;
            retryBtn.textColor =DWBColorHex(@"#FFFFFF");
            retryBtn.textAlignment = NSTextAlignmentCenter;
            [viewBlackBk addSubview:retryBtn];
            //设置圆角阴影
            //圆角
            retryBtn.layer.backgroundColor = [UIColor redColor].CGColor;
            retryBtn.layer.cornerRadius = 22;
            //阴影
            retryBtn.layer.shadowColor = [UIColor colorWithRed:255/255.0 green:200/255.0 blue:215/255.0 alpha:1.0].CGColor;
            retryBtn.layer.shadowOffset = CGSizeMake(0,5);
            retryBtn.layer.shadowOpacity = 1;
            retryBtn.layer.shadowRadius = 20;
            //点击
            [retryBtn addTapActionTouch:^{
                if (actionButtonBlock) {
                    actionButtonBlock();
                }
            }];
        }
    }
}


@end




