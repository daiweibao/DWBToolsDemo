//
//  MJDIYHeader.h
//  AiHenDeChaoXi
//
//  Created by 爱恨的潮汐 on 2018/4/22.
//  Copyright © 2018年 潮汐科技有限公司. All rights reserved.
//
//为了解决iphoneX偏移问题，自定义明杰刷新头部控件
#import <MJRefresh/MJRefresh.h>
@interface MJDIYHeader : MJRefreshHeader
@property(nonatomic,copy)NSString * typeStr;
@end
