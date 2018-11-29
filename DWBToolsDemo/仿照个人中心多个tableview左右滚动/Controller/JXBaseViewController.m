//
//  JXBaseViewController.m
//  DWBToolsDemo
//
//  Created by 戴维保 on 2018/11/28.
//  Copyright © 2018 潮汐科技有限公司. All rights reserved.
//

#import "JXBaseViewController.h"
@interface JXBaseViewController () <JXCategoryViewDelegate, UIScrollViewDelegate>
@property (nonatomic, assign) NSInteger currentIndex;
@end

@implementation JXBaseViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _shouldHandleScreenEdgeGesture = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    

    NSUInteger count = [self preferredListViewCount];//默认控制器个数
    CGFloat categoryViewHeight = [self preferredCategoryViewHeight];//默认组头高50
    CGFloat width = SCREEN_WIDTH;//默认宽度
    CGFloat height = WindowsSize.height - MC_NavHeight - categoryViewHeight;//默认控制器高度，在导航栏下面
    
    //控制器父视图滚动视图
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,MC_NavHeight +categoryViewHeight, width, height)];
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.contentSize = CGSizeMake(width*count, height);
    self.scrollView.bounces = NO;
    [self.view addSubview:self.scrollView];
    
    if (@available(iOS 11.0, *)) {
        self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else{
        
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    for (int i = 0; i < count; i ++) {
        UIViewController *listVC = [[[self preferredListViewControllerClass] alloc] init];
        [self configListViewController:listVC index:i];
        [self addChildViewController:listVC];
        listVC.view.frame = CGRectMake(i*width, 0, width, height);
        [self.scrollView addSubview:listVC.view];
    }
    
    self.categoryView.frame = CGRectMake(0, MC_NavHeight,SCREEN_WIDTH, categoryViewHeight);
    self.categoryView.delegate = self;
    self.categoryView.contentScrollView = self.scrollView;
    [self.view addSubview:self.categoryView];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //双层联动，暂时不处理
    //    if ([self isKindOfClass:[NestViewController class]]) {
    //        CGFloat index = scrollView.contentOffset.x/scrollView.bounds.size.width;
    //        CGFloat absIndex = fabs(index - self.currentIndex);
    //        if (absIndex >= 1) {
    //            //嵌套使用的时候，最外层的VC持有的scrollView在翻页之后，就断掉一次手势。解决快速滑动的时候，只响应最外层VC持有的scrollView。子VC持有的scrollView却没有响应
    //            self.scrollView.panGestureRecognizer.enabled = NO;
    //            self.scrollView.panGestureRecognizer.enabled = YES;
    //            _currentIndex = floor(index);
    //        }
    //    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.navigationController.interactivePopGestureRecognizer.enabled = (self.categoryView.selectedIndex == 0);
}

- (Class)preferredCategoryViewClass {
    return [JXCategoryBaseView class];
}

- (NSUInteger)preferredListViewCount {
    return 0;
}

- (CGFloat)preferredCategoryViewHeight {
    return 50;
}

- (Class)preferredListViewControllerClass {
    return [UIViewController class];
}

- (void)configListViewController:(UIViewController *)controller index:(NSUInteger)index {
    
}

- (JXCategoryBaseView *)categoryView {
    if (_categoryView == nil) {
        _categoryView = [[[self preferredCategoryViewClass] alloc] init];
    }
    return _categoryView;
}

- (void)rightItemClicked {
    JXCategoryIndicatorView *componentView = (JXCategoryIndicatorView *)self.categoryView;
    for (JXCategoryIndicatorComponentView *view in componentView.indicators) {
        if (view.componentPosition == JXCategoryComponentPosition_Top) {
            view.componentPosition = JXCategoryComponentPosition_Bottom;
        }else {
            view.componentPosition = JXCategoryComponentPosition_Top;
        }
    }
    [componentView reloadData];
}

#pragma mark - JXCategoryViewDelegate

- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    //侧滑手势处理
    if (_shouldHandleScreenEdgeGesture) {
        self.navigationController.interactivePopGestureRecognizer.enabled = (index == 0);
    }
    
}


@end
