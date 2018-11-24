//
//  AllTableviewScrollerController.m
//  DWBToolsDemo
//
//  Created by 戴维保 on 2018/11/24.
//  Copyright © 2018 潮汐科技有限公司. All rights reserved.
//

#import "AllTableviewScrollerController.h"
#import "JXCategoryView.h"
#import "AllTableviewSonController.h"

@interface AllTableviewScrollerController ()<JXCategoryViewDelegate>
@property (nonatomic, strong) JXCategoryTitleView *categoryView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray <AllTableviewSonController *> *listVCArray;
@property (nonatomic, strong) JXCategoryListVCContainerView *listVCContainerView;

@end

@implementation AllTableviewScrollerController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.isNeedCategoryListContainerView = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    

    NSArray *titles = [self getTitleArray];
    
    NSUInteger count = titles.count;
    CGFloat categoryViewHeight = 44;
    CGFloat width = SCREEN_WIDTH;
    CGFloat height = SCREEN_HEIGHT-MC_NavHeight-categoryViewHeight;
    
    
    self.categoryView = [[JXCategoryTitleView alloc] init];
    self.categoryView.frame = CGRectMake(0, MC_NavHeight, SCREEN_WIDTH, categoryViewHeight);
    self.categoryView.delegate = self;
    self.categoryView.titles = titles;
//    self.categoryView.titleColorGradientEnabled = YES;
//    self.categoryView.titleLabelZoomEnabled = YES;
//    self.categoryView.titleLabelZoomEnabled = YES;
    
    JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
    lineView.lineStyle = JXCategoryIndicatorLineStyle_JD;
    self.categoryView.indicators = @[lineView];
    [self.view addSubview:self.categoryView];
    
    
    self.listVCArray = [NSMutableArray array];
    for (int i = 0; i < count; i ++) {
        AllTableviewSonController *listVC = [[AllTableviewSonController alloc] init];
        listVC.view.frame = CGRectMake(i*width, self.categoryView.bottomY, width, height);
        [self.listVCArray addObject:listVC];
    }
    
    if (self.isNeedCategoryListContainerView) {
        self.listVCContainerView = [[JXCategoryListVCContainerView alloc] initWithFrame:CGRectMake(0, self.categoryView.bottomY, width, height)];
        self.listVCContainerView.defaultSelectedIndex = 0;
        self.categoryView.defaultSelectedIndex = 0;
        self.listVCContainerView.listVCArray = self.listVCArray;
        [self.view addSubview:self.listVCContainerView];
        
        self.categoryView.contentScrollView = self.listVCContainerView.scrollView;
    }else {
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.categoryView.bottomY, width, height)];
        self.scrollView.pagingEnabled = YES;
        self.scrollView.contentSize = CGSizeMake(width*count, height);
        [self.view addSubview:self.scrollView];
        
        for (int i = 0; i < count; i ++) {
            AllTableviewSonController *listVC = self.listVCArray[i];
            [self.scrollView addSubview:listVC.view];
        }
        
        self.categoryView.contentScrollView = self.scrollView;
        [self.listVCArray.firstObject loadDataForFirst];
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //默认选中哪一个
        self.categoryView.defaultSelectedIndex = 0;
    });
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (self.isNeedCategoryListContainerView) {
        [self.listVCContainerView parentVCWillAppear:animated];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.navigationController.interactivePopGestureRecognizer.enabled = (self.categoryView.selectedIndex == 0);
    
    if (self.isNeedCategoryListContainerView) {
        [self.listVCContainerView parentVCDidAppear:animated];
    }
}

//这句代码必须加上
- (BOOL)shouldAutomaticallyForwardAppearanceMethods {
    return NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if (self.isNeedCategoryListContainerView) {
        [self.listVCContainerView parentVCWillDisappear:animated];
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    if (self.isNeedCategoryListContainerView) {
        [self.listVCContainerView parentVCDidDisappear:animated];
    }
}

-(NSArray *)getTitleArray{
    
    return @[@"红烧螃蟹", @"麻辣龙虾", @"美味苹果", @"胡萝卜",@"待收货"];
}

/**
 重载数据源：比如从服务器获取新的数据、否则用户对分类进行了排序等
 */
- (void)reloadData {
    NSArray *titles = [self getTitleArray];
    //先把之前的listView移除掉
    for (UIViewController *vc in self.listVCArray) {
        [vc.view removeFromSuperview];
    }
    [self.listVCArray removeAllObjects];
    
    for (int i = 0; i < titles.count; i ++) {
        AllTableviewSonController *listVC = [[AllTableviewSonController alloc] init];
        listVC.view.frame = CGRectMake(i*self.scrollView.bounds.size.width, self.categoryView.bottomY, self.scrollView.bounds.size.width, self.scrollView.bounds.size.height);
        [self.listVCArray addObject:listVC];
    }
    
    if (self.isNeedCategoryListContainerView) {
        self.listVCContainerView.listVCArray = self.listVCArray;
        self.listVCContainerView.defaultSelectedIndex = 0;
        [self.listVCContainerView reloadData];
    }else {
        //根据新的数据源重新添加listView
        for (int i = 0; i < titles.count; i ++) {
            AllTableviewSonController *listVC = self.listVCArray[i];
            [self.scrollView addSubview:listVC.view];
        }
        self.scrollView.contentSize = CGSizeMake(self.scrollView.bounds.size.width*titles.count, self.scrollView.bounds.size.height);
        
        //触发首次加载
        [self.listVCArray.firstObject loadDataForFirst];
    }
    
    //重载之后默认回到0，你也可以指定一个index
    self.categoryView.defaultSelectedIndex = 0;
    self.categoryView.titles = titles;
    [self.categoryView reloadData];
}


#pragma mark - JXCategoryViewDelegate

- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    //侧滑手势处理
    self.navigationController.interactivePopGestureRecognizer.enabled = (index == 0);
    if (!self.isNeedCategoryListContainerView) {
        [self.listVCArray[index] loadDataForFirst];
    }
}

- (void)categoryView:(JXCategoryBaseView *)categoryView didClickSelectedItemAtIndex:(NSInteger)index {
    if (self.isNeedCategoryListContainerView) {
        [self.listVCContainerView didClickSelectedItemAtIndex:index];
    }
}

- (void)categoryView:(JXCategoryBaseView *)categoryView didScrollSelectedItemAtIndex:(NSInteger)index {
    if (self.isNeedCategoryListContainerView) {
        [self.listVCContainerView didScrollSelectedItemAtIndex:index];
    }
}

- (void)categoryView:(JXCategoryBaseView *)categoryView scrollingFromLeftIndex:(NSInteger)leftIndex toRightIndex:(NSInteger)rightIndex ratio:(CGFloat)ratio {
    if (self.isNeedCategoryListContainerView) {
        [self.listVCContainerView scrollingFromLeftIndex:leftIndex toRightIndex:rightIndex ratio:ratio];
    }
}

@end
