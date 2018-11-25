//
//  MyCenterMainController.m
//  DWBToolsDemo
//
//  Created by 戴维保 on 2018/11/24.
//  Copyright © 2018 潮汐科技有限公司. All rights reserved.
//

#import "MyCenterMainController.h"

#import "JXPagerView.h"
#import "JXCategoryView.h"
#import "MyCenterHeaderView.h"
#import "MyCenterSonView.h"
#import "JXPagerListRefreshView.h"

#import "DWBJXCategoryMyView.h"//自定义分组
#import "DWBJXCategoryMyLineView.h"//自定义滑块


@interface MyCenterMainController ()<JXPagerViewDelegate, JXCategoryViewDelegate>
@property (nonatomic, strong) JXPagerView *pagingView;
@property (nonatomic, strong) MyCenterHeaderView *userHeaderView;
@property (nonatomic, strong) JXCategoryTitleView *categoryView;
@property (nonatomic, strong) NSArray <MyCenterSonView *> *listViewArray;
@property (nonatomic, strong) NSArray <NSString *> *titles;

//高度
@property(nonatomic,assign)CGFloat JXTableHeaderViewHeight;
@property(nonatomic,assign)CGFloat JXheightForHeaderInSection;

@end

@implementation MyCenterMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //默认高度
    self.JXTableHeaderViewHeight = 200;
    self.JXheightForHeaderInSection = 50;
    
    
//    //动态改变头高
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//
//        self.JXTableHeaderViewHeight = 300;
//
//        _userHeaderView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.JXTableHeaderViewHeight);
//
//
//
//        [self.pagingView reloadData];
//    });
    
    
    //导航标题
    self.titleNavLabel.text = @"个人中心";
    
   //标题
    _titles = @[@"今日头条", @"腾讯视频", @"百度百科",@"今日头条", @"腾讯视频", @"百度百科"];
    
    
    //控制器
     MyCenterSonView *powerListView1 = [[MyCenterSonView alloc] init];
     MyCenterSonView *powerListView2 = [[MyCenterSonView alloc] init];
     MyCenterSonView *powerListView3 = [[MyCenterSonView alloc] init];
    
    MyCenterSonView *powerListView4 = [[MyCenterSonView alloc] init];
    MyCenterSonView *powerListView5 = [[MyCenterSonView alloc] init];
    MyCenterSonView *powerListView6 = [[MyCenterSonView alloc] init];
    
    _listViewArray = @[powerListView1, powerListView2, powerListView3,powerListView4, powerListView5, powerListView6];
    
    
    //头部
    _userHeaderView = [[MyCenterHeaderView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.JXTableHeaderViewHeight)];
    
    //分组头
    _categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.JXheightForHeaderInSection)];
    self.categoryView.titles = self.titles;
    self.categoryView.backgroundColor = [UIColor whiteColor];
    self.categoryView.delegate = self;
    self.categoryView.titleSelectedColor = [UIColor colorWithRed:105/255.0 green:144/255.0 blue:239/255.0 alpha:1];
    self.categoryView.titleColor = [UIColor blackColor];
    self.categoryView.titleColorGradientEnabled = YES;
    self.categoryView.titleLabelZoomEnabled = YES;
    self.categoryView.titleLabelZoomEnabled = YES;
    
    
    
//    //设置左边距离
//    self.categoryView.contentEdgeInsetLeft = 30;
//    //设置右边距离
//    self.categoryView.contentEdgeInsetRight = 30;
//
//    //设置左边遮挡
//    UILabel * categoryViewLeft = [[UILabel alloc]init];
//    categoryViewLeft.backgroundColor = [UIColor redColor];
//    categoryViewLeft.frame = CGRectMake(0, 0, self.categoryView.contentEdgeInsetLeft-15, self.categoryView.height);
//    [self.categoryView addSubview:categoryViewLeft];
//
//    //设置右边边遮挡
//    UILabel * categoryViewRight = [[UILabel alloc]init];
//    categoryViewRight.backgroundColor = [UIColor redColor];
//    categoryViewRight.frame = CGRectMake(self.categoryView.width-self.categoryView.contentEdgeInsetRight+15, 0, self.categoryView.contentEdgeInsetRight-15, self.categoryView.height);
//    [self.categoryView addSubview:categoryViewRight];
    
    
    //线
    JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
    lineView.indicatorLineViewColor = [UIColor colorWithRed:105/255.0 green:144/255.0 blue:239/255.0 alpha:1];
//    lineView.indicatorLineWidth = 30;
    self.categoryView.indicators = @[lineView];
    
    
//    //线--自定义滑块
//    DWBJXCategoryMyLineView *lineView = [[DWBJXCategoryMyLineView alloc] init];
//    lineView.indicatorLineViewColor = [UIColor colorWithRed:105/255.0 green:144/255.0 blue:239/255.0 alpha:1];
//    //    lineView.indicatorLineWidth = 30;
//    [lineView createMyUI];
//    self.categoryView.indicators = @[lineView];
    
    
#pragma mark ================ 下拉刷新类型 ==================
    //(1)从头部开始l下拉刷新
    _pagingView = [[JXPagerView alloc] initWithDelegate:self];
    
//    (2)从头部下面下拉刷新
//   _pagingView = [[JXPagerListRefreshView alloc] initWithDelegate:self];
    

    [self.view addSubview:self.pagingView];
    
    self.categoryView.contentScrollView = self.pagingView.listContainerView.collectionView;
    
    self.navigationController.interactivePopGestureRecognizer.enabled = (self.categoryView.selectedIndex == 0);
    
    
    //触发首次加载第一个控制器数据
    [self.listViewArray.firstObject loadDataForFirst];
    
    //刷新
    [self refresh];
    
    
    //扣边返回处理，下面的代码要加上
    [self.pagingView.listContainerView.collectionView.panGestureRecognizer requireGestureRecognizerToFail:self.navigationController.interactivePopGestureRecognizer];
    [self.pagingView.mainTableView.panGestureRecognizer requireGestureRecognizerToFail:self.navigationController.interactivePopGestureRecognizer];
    self.navigationController.interactivePopGestureRecognizer.enabled = (self.categoryView.selectedIndex == 0);
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    //坐标
    self.pagingView.frame = CGRectMake(0, MC_NavHeight, SCREEN_WIDTH, SCREEN_HEIGHT-MC_NavHeight);
}



#pragma mark - JXPagingViewDelegate

- (UIView *)tableHeaderViewInPagerView:(JXPagerView *)pagerView {
    return self.userHeaderView;
}

- (NSUInteger)tableHeaderViewHeightInPagerView:(JXPagerView *)pagerView {
    return self.JXTableHeaderViewHeight;
}

- (NSUInteger)heightForPinSectionHeaderInPagerView:(JXPagerView *)pagerView {
    return self.JXheightForHeaderInSection;
}

- (UIView *)viewForPinSectionHeaderInPagerView:(JXPagerView *)pagerView {
    return self.categoryView;
}

- (NSArray<UIView<JXPagerViewListViewDelegate> *> *)listViewsInPagerView:(JXPagerView *)pagerView {
    return self.listViewArray;
}

#pragma mark ===========打开支持头部下拉变大 ================
//打开头部下拉变大
//- (void)mainTableViewDidScroll:(UIScrollView *)scrollView {
//    [self.userHeaderView scrollViewDidScroll:scrollView.contentOffset.y];
//}

#pragma mark - JXCategoryViewDelegate
//处理侧滑返回
- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    //侧滑手势处理
    self.navigationController.interactivePopGestureRecognizer.enabled = (index == 0);
    [self.listViewArray[index] loadDataForFirst];
}



// 上拉下拉刷新
- (void)refresh {
    //自己封装的MJ刷新
    [DWB_refreshHeader DWB_RefreshHeaderAddview:self.pagingView.mainTableView RefreshType:nil refreshHeader:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self.pagingView.mainTableView endRefresh_DWB];
        });
    }];
    
}

@end
