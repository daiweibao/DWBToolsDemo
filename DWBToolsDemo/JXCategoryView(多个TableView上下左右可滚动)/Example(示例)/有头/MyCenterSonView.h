//
//  MyCenterSonView.h
//  DWBToolsDemo
//
//  Created by 爱恨的潮汐 on 2018/11/24.
//  Copyright © 2018 潮汐科技有限公司. All rights reserved.
//
//子控制器
#import <UIKit/UIKit.h>
#import "JXPagerView.h"
NS_ASSUME_NONNULL_BEGIN

@interface MyCenterSonView : UIView<JXPagerViewListViewDelegate>
@property (nonatomic, strong) NSArray <NSString *> *dataSource;

- (void)loadDataForFirst;

@end

NS_ASSUME_NONNULL_END
