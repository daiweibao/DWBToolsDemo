//
//  DWB_refreshHeader.m
//  XiaoYuanSheQu
//
//  Created by 戴维保 on 16/9/12.
//  Copyright © 2016年 潮汐科技有限公司. All rights reserved.
//

#import "DWB_refreshHeader.h"
#import "MJChiBaoZiHeader.h"
#import "MJDIYHeader.h"//自定义头部刷新控件，为了解决iPhone X头部遮挡问题
#import "MJDIYLoadingHeader.h"//自定义头部只有转圈没有汉字
@interface DWB_refreshHeader()

@end

@implementation DWB_refreshHeader
//加载
+(void)DWB_RefreshHeaderAddview:(UIScrollView *)tableview RefreshType:(NSString *)refrestType refreshHeader:(void (^)(void))refresh{
//    //（1）普通刷新
//    MJRefreshNormalHeader * Header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        //刷新回调
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (refresh) {
//                refresh();
//            }
//        });
//    }];
//


//    //（2）gif动画刷新
//    MJChiBaoZiHeader * Header = [MJChiBaoZiHeader headerWithRefreshingBlock:^{
//        //刷新回调
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (refresh) {
//                refresh();
//            }
//        });
//
//    }];
//

//    //上面那排字（不能放到回调里设置）
//    // 设置文字（三句都设置）
//    [Header setTitle:@"别弯腰，王冠会掉，别急躁，好物不少" forState:MJRefreshStateIdle];
//    [Header setTitle:@"别弯腰，王冠会掉，别急躁，好物不少" forState:MJRefreshStatePulling];
//    [Header setTitle:@"知识改变命运, 美文改变心情               ." forState:MJRefreshStateRefreshing];
//
    
//    // 设置字体
//    Header.stateLabel.font = [UIFont systemFontOfSize:12];
//    // 设置颜色
//    Header.stateLabel.textColor = [UIColor colorWithHexString:@"#aaaaaa"];
//    
//    //设置时间的label
//    Header.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:12];
//    Header.lastUpdatedTimeLabel.textColor = [UIColor colorWithHexString:@"#aaaaaa"];
    
//     tableview.mj_header = Header;
//    //背景色,删除背景色，可以让背景色跟随tableview的背景色
//    Header.backgroundColor = [UIColor clearColor];
    

    
    
    
    //（3）自定义刷新控件,属性去MJDIYHeader里面设置
    MJDIYHeader * headerCustomMy = [MJDIYHeader headerWithRefreshingBlock:^{
        //刷新回调
        dispatch_async(dispatch_get_main_queue(), ^{
            if (refresh) {
                refresh();
            }
        });
    }];
    //自定义控件类型
    if (refrestType.length > 0 && iPhoneX) {
        //没有导航，并且是iphoneX才传入此参数
        headerCustomMy.typeStr = @"iPhoneXAndNONav";
    }
    tableview.mj_header = headerCustomMy;
    headerCustomMy.backgroundColor = [UIColor clearColor];

}


+(void)DWB_RefreshHeaderOnlyHaveIconAddview:(UIScrollView *)tableview refreshHeader:(void (^)(void))refresh{
    
    //自定义下拉刷新控件当下拉加载控件用
    MJDIYLoadingHeader * headerCustomMy = [MJDIYLoadingHeader headerWithRefreshingBlock:^{
        //刷新回调
        dispatch_async(dispatch_get_main_queue(), ^{
            if (refresh) {
                refresh();
            }
        });
    }];
    tableview.mj_header = headerCustomMy;
    headerCustomMy.backgroundColor = [UIColor clearColor];
}


@end



