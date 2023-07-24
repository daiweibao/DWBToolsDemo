//
//  UIScrollView+EndRefresh.m
//  XiaoYuanSheQu
//
//  Created by 戴维保 on 16/9/12.
//  Copyright © 2016年 北京嗅美科技有限公司. All rights reserved.
//

#import "UIScrollView+EndRefresh.h"
#import <MJRefresh/MJRefresh.h>
@implementation UIScrollView (EndRefresh)
//结束刷新和加载
-(void)endRefresh_DWB{
    if (self.mj_header.isRefreshing) {
        [self.mj_header endRefreshing];
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

@end
