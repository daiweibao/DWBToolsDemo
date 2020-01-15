//
//  DWB_refreshFooter.h
//  XiaoYuanSheQu
//
//  Created by 戴维保 on 16/9/12.
//  Copyright © 2016年 潮汐科技有限公司. All rights reserved.
//

//#import "MJRefreshAutoNormalFooter.h"

@interface DWB_refreshFooter : MJRefreshAutoNormalFooter
/**
 *  自己封装的MJ加载 + tableview 要添加到那个滚动视图上
 *
 *  @param tableview 要添加到那个滚动视图上
 *  @param refresh   回调加载事件
 */
+(void)DWB_RefreshFooterAddview:(UIScrollView *)tableview refreshFooter:(void (^)(void))refresh;



/**
 聊天界面下拉加载更多消息--放在头部

 @param tableview tableview
 @param refresh 回调
 */
+(void)DWB_RefreshHeaderAddview:(UIScrollView *)tableview refreshHeader:(void (^)(void))refresh;

@end
