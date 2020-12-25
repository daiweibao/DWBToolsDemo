//
//  UIScrollView+EndRefresh.h
//  XiaoYuanSheQu
//
//  Created by chaoxi on 16/9/12.
//  Copyright © 2016年 chaoxi科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

//#import "UIScrollView+MJRefresh.h"

@interface UIScrollView (EndRefresh)


/**
 结束刷新
 */
-(void)endRefresh_DWB;


/// 已经加载完全部
/// @param noMoreTips 没有更多数据提示语：传入nil显示默认提示语，传@"-1"不显示文字，传入内容就显示内容
-(void)showMJLoadedAllData_DWB:(NSString *)noMoreTips;


@end
