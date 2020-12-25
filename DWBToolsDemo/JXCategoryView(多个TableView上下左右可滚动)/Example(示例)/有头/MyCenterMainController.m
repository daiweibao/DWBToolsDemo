//
//  MyCenterMainController.m
//  DWBToolsDemo
//
//  Created by chaoxi on 2018/11/24.
//  Copyright © 2018 chaoxi科技有限公司. All rights reserved.
//

#import "MyCenterMainController.h"

#import "JXPagerView.h"
#import "JXCategoryView.h"
//刷新类型
#import "JXPagerListRefreshView.h"
#import "DWBJXCategoryMyView.h"//自定义分组
#import "DWBJXCategoryMyLineView.h"//自定义滑块
//头部View
#import "MyCenterHeaderView.h"
//子控制器是控制器
#import "MyCenterSonVC.h"


@interface MyCenterMainController ()<JXPagerViewDelegate, JXCategoryViewDelegate>
@property (nonatomic, strong) JXPagerView *pagingView;
@property (nonatomic, strong) MyCenterHeaderView *userHeaderView;
//自定义组头
//@property (nonatomic, strong) DWBJXCategoryMyView *myCategoryView;

//标准标题组头
@property (nonatomic, strong) JXCategoryTitleView *myCategoryView;
//滑块
@property (nonatomic, strong) JXCategoryIndicatorLineView * lineView;

//存放控制器的数组
@property (nonatomic, strong) NSMutableArray  *listVCArray;

//头高
@property(nonatomic,assign)CGFloat JXTableHeaderViewHeight;
//组头高
@property(nonatomic,assign)CGFloat JXheightForHeaderInSection;

@end

@implementation MyCenterMainController
-(NSMutableArray *)listVCArray{
    if (!_listVCArray) {
        _listVCArray = [NSMutableArray array];
    }
    return _listVCArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //导航标题
    self.titleNavLabel.text = @"个人中心";
    
     self.JXTableHeaderViewHeight = 200;
    
    //初始化
    [self createCategoryUI];
    
    //首次加载默认数据
    [self setFirstLoadData];
    
    //刷新控件
    [self refresh];
    
    
//    //刷新数据
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//
//        [self reloadDataMy];
//    });

    
    //动态改变头高
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
       //调用
        
        [self changeHeaderViewHeight];
    });
}


//改变头高
-(void)changeHeaderViewHeight{
#pragma mark ============为了适配iOS9、10 必须这样刷新数据【3步，必须】===================
    //（1）高度
    self.JXTableHeaderViewHeight = 300;
    //（2）必须重新创建
    [self createCategoryUI];
    //（3）刷新组头
    NSArray*titles = @[@"今日头条", @"腾讯视频", @"百度百科",@"今日头条", @"腾讯视频", @"百度百科"];
    [self addSonControllerWithArrayTitles:titles];
}


//初始化框架
-(void)createCategoryUI{
    
#pragma mark ==============头部================
    //分组头高度
    self.JXheightForHeaderInSection = 50;
     //为了刷新,先设置为空
    [self.userHeaderView removeFromSuperview];
    self.userHeaderView = nil;
    //头部,必须懒加载
     _userHeaderView = [[MyCenterHeaderView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.JXTableHeaderViewHeight)];
  
#pragma mark ==============组头+控制器================
    //默认组头
    [self initCategoryDefaultUI];
    
    //自定义组头
//    [self initCategoryMySelftUI];
   
#pragma mark ================ 下拉刷新类型 ==================
    //为了刷新,先设置为空，清空代理
    [self.pagingView removeFromSuperview];
    self.pagingView = nil;
    self.pagingView.delegate = nil;
    //(1)从头部开始l下拉刷新
    _pagingView = [[JXPagerView alloc] initWithDelegate:self];
    //    (2)从头部下面下拉刷新
    //   _pagingView = [[JXPagerListRefreshView alloc] initWithDelegate:self];
    [self.view addSubview:self.pagingView];
    _myCategoryView.contentScrollView = self.pagingView.listContainerView.collectionView;
    //扣边返回处理，下面的代码要加上
    if (!_pagingView) {
        self.navigationController.interactivePopGestureRecognizer.enabled = (_myCategoryView.selectedIndex == 0);
        [self.pagingView.listContainerView.collectionView.panGestureRecognizer requireGestureRecognizerToFail:self.navigationController.interactivePopGestureRecognizer];
        [self.pagingView.mainTableView.panGestureRecognizer requireGestureRecognizerToFail:self.navigationController.interactivePopGestureRecognizer];
    }
    
}



//初始化默认标题分组头
-(void)initCategoryDefaultUI{
    //分组头--必须懒加载
    [_myCategoryView removeFromSuperview];
    _myCategoryView = nil;
    _myCategoryView.delegate = nil;
    
    _myCategoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.JXheightForHeaderInSection)];
    _myCategoryView.backgroundColor = [UIColor whiteColor];
    _myCategoryView.delegate = self;
    _myCategoryView.titleSelectedColor = [UIColor colorWithRed:105/255.0 green:144/255.0 blue:239/255.0 alpha:1];
    _myCategoryView.titleColor = [UIColor blackColor];
    _myCategoryView.titleColorGradientEnabled = YES;
    _myCategoryView.titleLabelZoomEnabled = YES;
    
    //滑块
    [_lineView removeFromSuperview];
    _lineView = nil;
    _lineView= [[JXCategoryIndicatorLineView alloc] init];
    _myCategoryView.indicators = @[_lineView];
    _lineView.indicatorLineViewColor = [UIColor colorWithRed:105/255.0 green:144/255.0 blue:239/255.0 alpha:1];
    //_lineView.indicatorLineWidth = 30;
    
}

//设置首次加载默认数据
-(void)setFirstLoadData{
    
    //控制器
    NSArray*titles = @[@"今日头条", @"腾讯视频", @"百度百科",@"今日头条", @"腾讯视频", @"百度百科"];
    [self addSonControllerWithArrayTitles:titles];
    //触发首次加载第一个控制器数据
    [self.listVCArray.firstObject loadDataForFirst];
    
    //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //        //默认选中哪一个
    //        [_myCategoryView selectItemAtIndex:1];
    //    });
}



////初始化自定义分组头
//-(void)initCategoryMySelftUI{
//    //自定义样式头
//    if (!self.myCategoryView) {
//        self.myCategoryView = [[DWBJXCategoryMyView alloc]init];
//        //自定义UI
//        [self.myCategoryView createMyUI];
//
//        self.myCategoryView.frame = CGRectMake(0, MC_NavHeight, SCREEN_WIDTH, self.JXheightForHeaderInSection);
//        self.myCategoryView.delegate = self;
//        [self.view addSubview:self.myCategoryView];
//        //设置左边距离
//        self.myCategoryView.contentEdgeInsetLeft = 30;
//        //设置右边距离
//        self.myCategoryView.contentEdgeInsetRight = 30;
//
//        //设置左边遮挡
//        UILabel * categoryViewLeft = [[UILabel alloc]init];
//        categoryViewLeft.backgroundColor = [UIColor orangeColor];
//        categoryViewLeft.frame = CGRectMake(0, 0, self.myCategoryView.contentEdgeInsetLeft-15, self.myCategoryView.height);
//        [self.myCategoryView addSubview:categoryViewLeft];
//
//        //设置右边边遮挡
//        UILabel * categoryViewRight = [[UILabel alloc]init];
//        categoryViewRight.backgroundColor = [UIColor orangeColor];
//        categoryViewRight.frame = CGRectMake(self.myCategoryView.width-self.myCategoryView.contentEdgeInsetRight+15, 0, self.myCategoryView.contentEdgeInsetRight-15, self.myCategoryView.height);
//        [self.myCategoryView addSubview:categoryViewRight];
//
//
//        //滑块
//        DWBJXCategoryMyLineView *lineView = [[DWBJXCategoryMyLineView alloc] init];//自定义样式
//        self.myCategoryView.indicators = @[lineView];
//        [lineView createMyUI];//自定义滑块样式
//
//
//        //控制器
//        NSArray*titles = @[@"今日头条", @"腾讯视频", @"百度百科",@"今日头条", @"腾讯视频", @"百度百科"];
//        [self addSonControllerWithArrayTitles:titles];
//        //触发首次加载第一个控制器数据
//        [self.listVCArray.firstObject loadDataForFirst];
//
//        //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        //        //默认选中哪一个
//        //        [_myCategoryView selectItemAtIndex:1];
//        //    });
//    }
//
//
//
//
//}



#pragma mark ===========添加子控制器,传入标题数组==========
-(void)addSonControllerWithArrayTitles:(NSArray *)arrayTitles{
    //（1）设置组标题
    self.myCategoryView.titles = arrayTitles;
    
    //(2)先把之前的listView移除掉
    for (UIViewController *vc in self.listVCArray) {
        [vc.view removeFromSuperview];
    }
    //(3)在移除所有标题数据
    [self.listVCArray removeAllObjects];
    
    for (int i =0; i < arrayTitles.count; i++) {
        MyCenterSonVC *powerListView1 = [[MyCenterSonVC alloc] init];
        [self.listVCArray addObject:powerListView1];
    }
    
    
    //重载之后默认回到0，你也可以指定一个index
    self.myCategoryView.defaultSelectedIndex = 0;
    //首次加载第一个控制器加载数据
    [self.listVCArray.firstObject loadDataForFirst];

    //【必须】刷新组头布局
    [self.myCategoryView reloadData];
    //【必须】刷新下面子控制器布局
    [self.pagingView reloadData];
    
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
    return self.myCategoryView;
}

- (NSArray<UIView<JXPagerViewListViewDelegate> *> *)listViewsInPagerView:(JXPagerView *)pagerView {
    return self.listVCArray;
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
    [self.listVCArray[index] loadDataForFirst];
}





#pragma mark =========刷新组头数据==================
/**
 重载数据源：比如从服务器获取新的数据、否则用户对分类进行了排序等
 */
- (void)reloadDataMy{
    NSArray *titles =  @[@"刷新后的数据", @"数据2",@"第三3"];
    //添加子控制器
    [self addSonControllerWithArrayTitles:titles];
    
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
