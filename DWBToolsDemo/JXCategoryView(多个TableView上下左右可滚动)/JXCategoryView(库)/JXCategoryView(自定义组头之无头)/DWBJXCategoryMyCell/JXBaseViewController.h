//
//  JXBaseViewController.h
//  DWBToolsDemo
//
//  Created by 戴维保 on 2018/11/28.
//  Copyright © 2018 潮汐科技有限公司. All rights reserved.
//
//无组头父类
#import <UIKit/UIKit.h>
#import "JXCategoryView.h"
#import "CXRootViewController.h"
NS_ASSUME_NONNULL_BEGIN

#define WindowsSize [UIScreen mainScreen].bounds.size
//这里继承自项目中的控制器基类
@interface JXBaseViewController : CXRootViewController


@property (nonatomic, assign) BOOL isNeedIndicatorPositionChangeItem;

@property (nonatomic, strong) JXCategoryBaseView *categoryView;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, assign) BOOL shouldHandleScreenEdgeGesture;


- (Class)preferredCategoryViewClass;

- (NSUInteger)preferredListViewCount;

- (CGFloat)preferredCategoryViewHeight;

- (Class)preferredListViewControllerClass;

- (void)configListViewController:(UIViewController *)controller index:(NSUInteger)index;

@end

NS_ASSUME_NONNULL_END
