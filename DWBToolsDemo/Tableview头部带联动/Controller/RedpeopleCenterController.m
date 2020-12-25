//
//  RedpeopleCenterController.m
//  ZuiMeiXinNiang
//
//  Created by 爱恨的chaoxi on 2016/12/26.
//  Copyright © 2016年 chaoxi科技有限公司. All rights reserved.
//

#import "RedpeopleCenterController.h"
#import "MainTouchTableTableView.h"
#import "MYSegmentView.h"


//头部
#import "RedPeopleHeaderView.h"
//红人主题
#import "RedPeopleThemController.h"
//红人商品
#import "RedPeopleGoodsController.h"

#import "ThirdViewCollectionViewController.h"


#define Main_Screen_Height      [[UIScreen mainScreen] bounds].size.height
#define Main_Screen_Width       [[UIScreen mainScreen] bounds].size.width



@interface RedpeopleCenterController ()<UITableViewDelegate,UITableViewDataSource>{
    //头高
    CGFloat  headViewHeight;
    
}

@property(nonatomic ,strong)MainTouchTableTableView * mainTableView;
@property (nonatomic, strong) MYSegmentView * RCSegView;

@property(nonatomic,strong)RedPeopleHeaderView * headView;//头部控件
@property(nonatomic,strong)UIImageView * avatarImage;
@property(nonatomic,strong)UILabel *countentLabel;

@property (nonatomic, assign) BOOL canScroll;
@property (nonatomic, assign) BOOL isTopIsCanNotMoveTabView;
@property (nonatomic, assign) BOOL isTopIsCanNotMoveTabViewPre;

//创建导航
@property(nonatomic,strong)UIView * viewNav;
//导航标题
@property(nonatomic,strong)UILabel * labelNav;
@end

@implementation RedpeopleCenterController

@synthesize mainTableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //隐藏导航
    self.navigationCXView.hidden = YES;
    
    //头部高度==去掉小数点后的(必须用float类型保留一位小数)
    headViewHeight = 300;
    [self.view addSubview:self.mainTableView];
    //头部
    [self headView];
    
    /*
     *
     */
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(acceptMsg:) name:@"leaveTop" object:nil];
    
 }


//创建渐变导航
-(void)createNav{
    
    _viewNav = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, MC_NavHeight)];
    _viewNav.backgroundColor = [UIColor whiteColor];
    _viewNav.alpha = 0;
    [self.view addSubview:_viewNav];
    [self.view bringSubviewToFront:_viewNav];
  
    //创建返回键
    UIButton * buttonReturn = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonReturn.frame = CGRectMake(0, MC_StatusBarHeight-1, 44, 44);
    [buttonReturn setImage:[[UIImage imageNamed:@"返回"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [buttonReturn addTarget:self action:@selector(pressButtonLeft) forControlEvents:UIControlEventTouchUpInside];
    [_viewNav addSubview:buttonReturn];
        
    
    //标题
    _labelNav = [[UILabel alloc]init];
    _labelNav.userInteractionEnabled = NO;
    _labelNav.frame = CGRectMake(100, MC_StatusBarHeight, SCREEN_WIDTH-200, 44);
    _labelNav.backgroundColor = [UIColor whiteColor];
    _labelNav.text = @"红人";
    _labelNav.textAlignment = NSTextAlignmentCenter;
    _labelNav.font  =[UIFont systemFontOfSize:18];
    _labelNav.textColor = [UIColor blackColor];
    [_viewNav addSubview:_labelNav];
    
    //导航栏下面的线
    UIImageView *topLine=[[UIImageView alloc] initWithFrame:CGRectMake(0, MC_NavHeight-1, SCREEN_WIDTH,1)];
    topLine.backgroundColor=[UIColor groupTableViewBackgroundColor];
    [_viewNav addSubview:topLine];
    
    
}

//点击头像进来的返回
-(void)pressButtonLeft{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)acceptMsg : (NSNotification *)notification{
    
    NSDictionary *userInfo = notification.userInfo;
    NSString *canScroll = userInfo[@"canScroll"];
    if ([canScroll isEqualToString:@"1"]) {
        _canScroll = YES;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //导航栏逐渐变透明
    CGFloat offsetmyYCG = -scrollView.contentOffset.y-MC_NavHeight;
    //去掉小数点后的
    CGFloat offsetmyY = [[NSString stringWithFormat:@"%.6f",offsetmyYCG] integerValue];
    
    if (offsetmyY > 200) {
        
        self.viewNav.alpha = 0;
        
    } else if(offsetmyY >=0 && offsetmyY <=200){
        
        CGFloat alpha = (100-(offsetmyY-50)) * 0.01;
        
        self.viewNav.alpha = alpha;
        
    }else{
        
        self.viewNav.alpha = 1;
        
    }
    
    

    /**
     * 处理联动
     */
    
    //获取滚动视图y值的偏移量
    //    CGFloat yOffset  = scrollView.contentOffset.y;
    
    CGFloat tabOffsetY = [mainTableView rectForSection:0].origin.y;
    CGFloat offsetY = scrollView.contentOffset.y;
    
    _isTopIsCanNotMoveTabViewPre = _isTopIsCanNotMoveTabView;
    if (offsetY>=tabOffsetY-MC_NavHeight) {
        scrollView.contentOffset = CGPointMake(0, tabOffsetY-MC_NavHeight);
        _isTopIsCanNotMoveTabView = YES;
        
    }else{
        _isTopIsCanNotMoveTabView = NO;
        
    }
    if (_isTopIsCanNotMoveTabView != _isTopIsCanNotMoveTabViewPre) {
        if (!_isTopIsCanNotMoveTabViewPre && _isTopIsCanNotMoveTabView) {
            //            NSLog(@"滑动到顶端");
            _viewNav.alpha = 1;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"goTop" object:nil userInfo:@{@"canScroll":@"1"}];
            _canScroll = NO;
        }
        if(_isTopIsCanNotMoveTabViewPre && !_isTopIsCanNotMoveTabView){
            _viewNav.alpha = 0;
            //            NSLog(@"离开顶端");
            if (!_canScroll) {
                scrollView.contentOffset = CGPointMake(0, tabOffsetY+MC_NavHeight);
            }
        }
    }
    
}


-(RedPeopleHeaderView *)headView{
    if (!_headView) {
        _headView = [[RedPeopleHeaderView alloc]init];
        _headView.frame = CGRectMake(0, -headViewHeight ,Main_Screen_Width,headViewHeight);
        //添加头部
        [self.mainTableView addSubview:self.headView];
        [self.mainTableView sendSubviewToBack:self.headView];
        
        //创建导航(注意先后顺序)
        [self createNav];
    }
    return _headView;
}


-(UITableView *)mainTableView
{
    if (mainTableView == nil)
    {
        mainTableView= [[MainTouchTableTableView alloc]initWithFrame:CGRectMake(0,0,Main_Screen_Width,Main_Screen_Height)];
        //iOS11、iPhoneX适配
        [UIView tablevieiOS11:mainTableView isHaveTabbar:NO];
        mainTableView.delegate=self;
        mainTableView.dataSource=self;
//        mainTableView.showsVerticalScrollIndicator = NO;
        mainTableView.contentInset = UIEdgeInsetsMake(headViewHeight,0, 0, 0);
        mainTableView.backgroundColor = [UIColor clearColor];
    }
    return mainTableView;
}

#pragma marl -tableDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return Main_Screen_Height-MC_NavHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //添加pageView
    [cell.contentView addSubview:self.setPageViewControllers];
    
    return cell;
}

/*
 * 这里可以任意替换你喜欢的pageView
 */
-(UIView *)setPageViewControllers
{
    if (!_RCSegView) {
        //红人主题
        RedPeopleThemController *First=[[RedPeopleThemController alloc] init];
        
        //红人宝贝
        RedPeopleGoodsController *Second=[[RedPeopleGoodsController alloc] init];
        
        ThirdViewCollectionViewController * three =[[ThirdViewCollectionViewController alloc] init];
        
    
        NSArray *controllers=@[First,Second,three];
        
        NSArray *titleArray =@[@"主题",@"宝贝",@"点首歌嗯嗯"];
        
        
        
        MYSegmentView * rcs=[[MYSegmentView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height-MC_NavHeight) controllers:controllers titleArray:titleArray ParentController:self lineWidth:42 lineHeight:2 Type:@"红人个人中心"];
        
        _RCSegView = rcs;
    }
    return _RCSegView;
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
}



@end
