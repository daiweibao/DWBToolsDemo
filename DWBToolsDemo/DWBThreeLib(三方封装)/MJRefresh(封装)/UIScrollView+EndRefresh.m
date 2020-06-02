//
//  UIScrollView+EndRefresh.m
//  XiaoYuanSheQu
//
//  Created by 戴维保 on 16/9/12.
//  Copyright © 2016年 潮汐科技有限公司. All rights reserved.
//

#import "UIScrollView+EndRefresh.h"
#import <MJRefresh/MJRefresh.h>
@implementation UIScrollView (EndRefresh)
//结束刷新和加载
-(void)endRefresh_DWB{
    if (self.mj_header.isRefreshing) {
        [self.mj_header endRefreshing];
        [self.mj_footer resetNoMoreData];
    }
    if (self.mj_footer.isRefreshing) {
        [self.mj_footer endRefreshing];
    }
    
//先放在这里，用到再打开
//    if (self.mj_header.state==3||self.mj_footer.state==3) {
//      //这个状态刷新或者加载才有声音
//        NSLog(@"有刷新声音");
//    }else{
//      //其他状态刷新无声
//    }
//
//    NSLog(@"刷新头部状态：%ld",(long)self.mj_header.state);
//    NSLog(@"刷新脚部状态：%ld",(long)self.mj_footer.state);
    }

//已经加载完全部
-(void)showMJLoadedAllData_DWB:(NSString *)noMoreTips{
    //已经去全部加载完毕，必须套两层主线程
    dispatch_async(dispatch_get_main_queue(), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.mj_footer endRefreshingWithNoMoreData];
            self.mj_footer.hidden = NO;
            //设置没有更多数据了文字
            MJRefreshBackStateFooter *footer = (MJRefreshBackStateFooter*)self.mj_footer;
            if ([NSString isNULL:noMoreTips]) {
                [footer setTitle:@"别拉了 我已经到底了" forState:MJRefreshStateNoMoreData];
            }else if ([noMoreTips isEqual:@"-1"]){
                [footer setTitle:@"  " forState:MJRefreshStateNoMoreData];
            } else{
                [footer setTitle:noMoreTips forState:MJRefreshStateNoMoreData];
            }
        });
    });
    
    
    /*
     案例
     
     if (_currentPage > 1 && arrayInfo.count == 0) {
     
     [weakself.collectionView showMJLoadedAllData_DWB];
     //已经去全部加载完毕
     dispatch_async(dispatch_get_main_queue(), ^{
     dispatch_async(dispatch_get_main_queue(), ^{
     [self.collectionView.mj_footer endRefreshingWithNoMoreData];
     self.collectionView.mj_footer.hidden = NO;
     });
     });
     }
     
     */
    
}

@end

