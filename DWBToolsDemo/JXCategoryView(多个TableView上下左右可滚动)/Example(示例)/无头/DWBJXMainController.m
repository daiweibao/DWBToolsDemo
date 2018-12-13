//
//  DWBJXMainController.m
//  DWBToolsDemo
//
//  Created by 戴维保 on 2018/11/28.
//  Copyright © 2018 潮汐科技有限公司. All rights reserved.
//

#import "DWBJXMainController.h"

#import "JXCategoryTitleView.h"

#import "DWBJXCategoryMyView.h"//自定义分组
#import "DWBJXCategoryMyLineView.h"//自定义滑块

#import "AllTableviewSonController.h"//子控制器

@interface DWBJXMainController ()<JXCategoryViewDelegate>
//存放控制器的数组
@property (nonatomic, strong) NSMutableArray  *listVCArray;
//组头高度
@property (nonatomic,assign)CGFloat categoryHeight;

//自定义组头
@property (nonatomic, strong) DWBJXCategoryMyView *myCategoryView;

//标准标题组头
//@property (nonatomic, strong) JXCategoryTitleView *myCategoryView;


@end

@implementation DWBJXMainController

-(NSMutableArray *)listVCArray{
    if (!_listVCArray) {
        _listVCArray = [NSMutableArray array];
    }
    return _listVCArray;
}

- (void)viewDidLoad {

    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //组头高度
    self.categoryHeight = 50;

    //自定义组头UI
    [self initCategoryMySelftUI];
    
    //默认标题组头UI
//    [self initCategoryDefaultUI];

    
}


//初始化自定义分组头
-(void)initCategoryMySelftUI{

        //自定义样式头
        self.myCategoryView = [[DWBJXCategoryMyView alloc]init];
        //自定义UI
        [self.myCategoryView createMyUI];

        self.myCategoryView.frame = CGRectMake(0, MC_NavHeight, WindowsSize.width, self.categoryHeight);
        self.myCategoryView.delegate = self;
        self.myCategoryView.contentScrollView = self.scrollView;
        [self.view addSubview:self.myCategoryView];




        //设置左边距离
        self.myCategoryView.contentEdgeInsetLeft = 30;
        //设置右边距离
        self.myCategoryView.contentEdgeInsetRight = 30;

        //设置左边遮挡
        UILabel * categoryViewLeft = [[UILabel alloc]init];
        categoryViewLeft.backgroundColor = [UIColor orangeColor];
        categoryViewLeft.frame = CGRectMake(0, 0, self.myCategoryView.contentEdgeInsetLeft-15, self.myCategoryView.height);
        [self.myCategoryView addSubview:categoryViewLeft];

        //设置右边边遮挡
        UILabel * categoryViewRight = [[UILabel alloc]init];
        categoryViewRight.backgroundColor = [UIColor orangeColor];
        categoryViewRight.frame = CGRectMake(self.myCategoryView.width-self.myCategoryView.contentEdgeInsetRight+15, 0, self.myCategoryView.contentEdgeInsetRight-15, self.myCategoryView.height);
        [self.myCategoryView addSubview:categoryViewRight];


    //滑块
        DWBJXCategoryMyLineView *lineView = [[DWBJXCategoryMyLineView alloc] init];//自定义样式
        self.myCategoryView.indicators = @[lineView];
        [lineView createMyUI];//自定义滑块样式

        NSArray * array = @[@"螃蟹", @"麻辣小龙虾",@"第三个",@"第四个",@"第无个"];
        //添加子控制器
        [self addSonControllerWithArrayTitles:array];


//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            //默认选中哪一个
//            [self.myCategoryView selectItemAtIndex:1];
//
//        });


}




//初始化默认标题分组头
-(void)initCategoryDefaultUI{
    
    //标准标题样式头
    self.myCategoryView = [[JXCategoryTitleView alloc]init];
    self.myCategoryView.frame = CGRectMake(0, MC_NavHeight, SCREEN_WIDTH, self.categoryHeight);
    self.myCategoryView.delegate = self;
    self.myCategoryView.contentScrollView = self.scrollView;
    [self.view addSubview:self.myCategoryView];
    
    //动效
    self.myCategoryView.titleColorGradientEnabled = YES;//文字颜色渐变
    //    self.myCategoryView.titleLabelZoomEnabled = YES;//文字放大
    
    //标准小横线
    JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
    lineView.lineStyle = JXCategoryIndicatorLineStyle_JD;
    self.myCategoryView.indicators = @[lineView];
    
    NSArray * array = @[@"螃蟹", @"麻辣小龙虾",@"第三个",@"第四个",@"第无个"];
    //添加子控制器
    [self addSonControllerWithArrayTitles:array];
    
    
    
   
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
         //刷新数据，不刷新控制器位置
          NSArray * arrayNew = @[@"新数据", @"麻辣new",@"第三个",@"第四个",@"第无个"];
          self.myCategoryView.titles = arrayNew;
          [self.myCategoryView reloadData];
    });
    
    
    //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //        //默认选中哪一个
    //        [self.myCategoryView selectItemAtIndex:1];
    //
    //    });
    
    //
    //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //        //刷新组头数据
    //        [self reloadDataMy];
    //    });
    //
    
}


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
    //(3)添加子控制器
    CGFloat height = SCREEN_HEIGHT - MC_NavHeight - self.myCategoryView.height;
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * arrayTitles.count, height);
    self.scrollView.backgroundColor  = [UIColor whiteColor];
    
    for (int i = 0; i < arrayTitles.count; i ++) {
        AllTableviewSonController *listVC = [[AllTableviewSonController alloc] init];
        listVC.view.frame = CGRectMake(i* SCREEN_WIDTH, 0, SCREEN_WIDTH, height);
        [self.listVCArray addObject:listVC];//加入数组
        [self.scrollView addSubview:listVC.view];//添加子视图
    }
    
    //首次加载第一个控制器加载数据
    [self.listVCArray.firstObject loadDataForFirst];
    
    
    //    //重载之后默认回到0，你也可以指定一个index
    //    self.myCategoryView.defaultSelectedIndex = 0;
    //    self.myCategoryView.titles = titles;
    
        [self.myCategoryView reloadData];
    
}



#pragma mark - JXCategoryViewDelegate
//滚动和点击都会走这个代理
- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    //侧滑手势处理
    self.navigationController.interactivePopGestureRecognizer.enabled = (index == 0);
    
    //去请求数据
    [self.listVCArray[index] loadDataForFirst];
}




#pragma mark =========刷新组头数据==================
/**
 重载数据源：比如从服务器获取新的数据、否则用户对分类进行了排序等
 */
- (void)reloadDataMy{
    NSArray *titles =  @[@"刷新后的数据", @"数据2",@"第三3",@"第5个",@"第6个"];
    //添加子控制器
    [self addSonControllerWithArrayTitles:titles];
    
}


@end

