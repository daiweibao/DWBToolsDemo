//
//  DWB_refreshFooter.m
//  XiaoYuanSheQu
//
//  Created by chaoxi on 16/9/12.
//  Copyright © 2016年 chaoxi科技有限公司. All rights reserved.
//

#import "DWB_refreshFooter.h"
#import "MJChiBaoZiFooter.h"
#import "MJDIYAutoFooter.h"
@interface DWB_refreshFooter()

@end

@implementation DWB_refreshFooter
//加载
+(void)DWB_RefreshFooterAddview:(UIScrollView *)tableview refreshFooter:(void (^)(void))refresh{
//    //(1)普通菊花的加载
//    MJRefreshAutoNormalFooter * footer=[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//        //加载回调 loading
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (refresh) {
//                refresh();
//            }
//        });
//
//    }];
 
//    //(2)gif动画的加载
//    MJChiBaoZiFooter *footer = [MJChiBaoZiFooter footerWithRefreshingBlock:^{
//        //加载回调 loading
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (refresh) {
//                refresh();
//            }
//        });
//    }];
//
//    // 设置字体
//    footer.stateLabel.font = [UIFont systemFontOfSize:12];
//    // 设置颜色
//    footer.stateLabel.textColor =  [UIColor colorWithHexString:@"#aaaaaa"];
//    //已经加载完全部 亲，没有更多内容了！,去UIScrollView+EndRefresh里面设置
//     [footer setTitle:@"亲，没有更多内容了！" forState:MJRefreshStateNoMoreData];
//    
//    // 隐藏刷新状态的文字
////    footer.refreshingTitleHidden = YES;
//    
//    // 设置footer
//    tableview.mj_footer = footer;
//    //不设置背景色，跟随控制器设置
//    footer.backgroundColor = [UIColor clearColor];
    
//    MJDIYAutoFooter//自定义上拉加载控制器
    
    
    //（3）自定义刷新控件,属性去MJDIYAutoFooter里面设置
    MJDIYAutoFooter * footCustomMy = [MJDIYAutoFooter footerWithRefreshingBlock:^{
        //刷新回调
        dispatch_async(dispatch_get_main_queue(), ^{
            if (refresh) {
                refresh();
            }
        });
    }];
    tableview.mj_footer = footCustomMy;
    footCustomMy.backgroundColor = [UIColor clearColor];
    
}


@end
