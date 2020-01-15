//
//  DWB_refreshHeader.h
//  XiaoYuanSheQu
//
//  Created by 戴维保 on 16/9/12.
//  Copyright © 2016年 潮汐科技有限公司. All rights reserved.
//

//#import "MJRefreshNormalHeader.h"

@interface DWB_refreshHeader : MJRefreshNormalHeader

/**
 自己封装的MJ刷新 + tableview 要添加到那个滚动视图上

 @param tableview 要添加到那个滚动视图上
 @param refrestType 刷新的类型判断是否从屏幕顶部开始刷新，用来适配iPhoneX，有值代表是，为空代表默认不是
 @param refresh 返回刷新事件
 */
+(void)DWB_RefreshHeaderAddview:(UIScrollView *)tableview RefreshType:(NSString *)refrestType refreshHeader:(void (^)(void))refresh;



/**
 下拉加载，头部仅有转圈

 @param tableview 要添加到那个滚动视图上
 @param refresh 返回刷新事件
 */
+(void)DWB_RefreshHeaderOnlyHaveIconAddview:(UIScrollView *)tableview refreshHeader:(void (^)(void))refresh;


@end
