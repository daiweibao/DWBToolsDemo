//
//  CXTabBarController.m
//  AiHenDeChaoXi
//
//  Created by 爱恨的潮汐 on 2023/8/19.
//  Copyright © 2023年 潮汐科技有限公司. All rights reserved.
//

#import "CXTabBarController.h"
#import "CXNavigationController.h"
//tabbar的item
#import "CXTabBarItemView.h"

//控制器
#import "HopmeViewController.h"

#import "CXAFNetworkingChange.h"


@interface CXTabBarController ()<TienUITabBarDelegate>
///自定义tabBar的item
@property (nonatomic ,strong) CXTabBarItemView *myTabBarView;
@property (nonatomic, strong) NSMutableArray *imagesArray;//存放图片
@property(nonatomic, strong) NSMutableArray *tabbarArray;//存放控制器
@property(nonatomic, strong) UIView *bottomView;//添加tabbar设置背景用的

@end

@implementation CXTabBarController

//初始化tabbar
+ (CXTabBarController *)shareTabBarController{
    static CXTabBarController *sharedSVC;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedSVC = [[CXTabBarController alloc] init];
    });
    return sharedSVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.delegate = self;
    self.view.backgroundColor = [UIColor whiteColor];
    
    //监听网络状态
    [CXAFNetworkingChange yz_currentNetStates];
    
}

///添加tabbar背景色用的
- (UIView *)bottomView{
    if (!_bottomView) {
        //普通手机高49，iPhoneX高83
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-MC_TabbarHeight, SCREEN_WIDTH, MC_TabbarHeight)];
        _bottomView.backgroundColor = [UIColor groupTableViewBackgroundColor];
       
    }
    return _bottomView;
}


//创建tabbar
- (void)createTabbar{
    //添加tabbar设置背景用的
    [self.view addSubview:self.bottomView];
    //隐藏系统的tababr的item
    self.tabBar.hidden = YES;
    
    //移除控制器，防止重复添加
    for (UIViewController *vc in self.childViewControllers) {
        [vc removeFromParentViewController];
    }
    //移除自定义的tabbar的子视图
    for (UIView *view in self.bottomView.subviews) {
        [view removeFromSuperview];
    }
    
    //初始化存放控制器的数组
    self.tabbarArray = [NSMutableArray array];
    //首页
    HopmeViewController *homeVC = [HopmeViewController new];
    CXNavigationController *nav1 = [[CXNavigationController alloc]initWithRootViewController:homeVC];
    
    //
    UIViewController *twoVC = [UIViewController new];
    CXNavigationController *nav2 = [[CXNavigationController alloc]initWithRootViewController:twoVC];

    //我的
    UIViewController *myVC = [UIViewController new];
    CXNavigationController *nav3 = [[CXNavigationController alloc]initWithRootViewController:myVC];
    
    [self.tabbarArray addObject:nav1];
    [self.tabbarArray addObject:nav2];
    [self.tabbarArray addObject:nav3];
    
    //tabbar背景图
    CGFloat imagebgH = GetImageHeight(SCREEN_WIDTH, 1500, 206);
    
    //底部白色背景
    UIView *viewSafeBottom = [[UIView alloc]init];
    viewSafeBottom.frame = CGRectMake(0, imagebgH-2, SCREEN_WIDTH, MC_TabbarHeight);
    viewSafeBottom.backgroundColor = [UIColor whiteColor];
    [self.bottomView addSubview:viewSafeBottom];
    //背景图片
    UIImageView *imageTabbarView = [[UIImageView alloc]init];
    imageTabbarView.frame = CGRectMake(0, 0, SCREEN_WIDTH, imagebgH);
    imageTabbarView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.bottomView addSubview:imageTabbarView];
   
    
    //最后添加自定义的tabbar的item，添加到self.view的最上层。
    //【⚠️⚠️⚠️注意：hitTest方法只能在添加到self.view的.m里实现才生效，如果hitTest方法所在view没有addSubview添加到self.view上，那么hitTest将无效。】所以self.myTabBarView添加到self.view上
    self.myTabBarView = [[CXTabBarItemView alloc] init];
    self.myTabBarView.delegate = self;
    self.myTabBarView.backgroundColor = [UIColor clearColor];//背景色
    self.myTabBarView.frame = CGRectMake(0, SCREEN_HEIGHT-MC_TabbarHeight, SCREEN_WIDTH, MC_TabbarHeight);
    [self.view addSubview:self.myTabBarView];
    
    
    //tabbar默认图片
    NSArray *images = @[@"tab_headlines_normal",@"tab_mall_normal",@"tab_personal_normal"];
    //tabbar选中图片
    NSArray *selectImages = @[@"tabbarTest",@"tabbarTest",@"tabbarTest"];
//    NSArray *selectImages = @[@"tab_headlines_select",@"tab_mall_select",@"tab_personal_select"];
    //tabbar标题
    NSArray *titles = @[@"首页", @"商城",@"我的"];
    for (int i = 0 ; i < self.tabbarArray.count; i++) {
        CXNavigationController *nav = self.tabbarArray[i];
        [self addChildViewController:nav];//添加控制器到系统tabbar里
        //设置每一个item
        [self.myTabBarView addTabBarBtnWithImage:images[i] selectedImage:selectImages[i] atIndex:i withTitle:titles[i] withTabbarArray:self.tabbarArray];
    }
    
    //tabbar底部黑线
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 1)];
    lineView.backgroundColor = UIColorFromRGB(0xEBEBEB);
    [self.bottomView addSubview:lineView];

}

//点击或者选中tabbar的代理回调，去切换控制器
- (void)tabBar:(CXTabBarItemView *)tabBar didSelectedBtnTo:(int)desIndex{
    self.selectedIndex = desIndex;//手动设置当前根视图控制器，不然控制器不会切换
    
    //记录当前根视图控制器，后面控制器跳转用
     UIViewController *viewController = self.viewControllers[desIndex];
     RootNavController = viewController.navigationController;//rootNavigationController走set方法
     NSLog(@"--切换tabBar--当前选中：%d",desIndex);
}

///选中一个指定tabbar：如登录成功后后选中首页等
- (void)selectmyTabBarViewWithIndex:(NSInteger )index{
    [self.myTabBarView selectMyTabbarItemWithIndex:index];
}

//手动调用隐藏tabbar
- (void)hideTheTabbar{
    self.bottomView.hidden = YES;
}

//手动调用显示tabbar
- (void)showTheTabbar{
    self.bottomView.hidden = NO;
}

-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{

}

//mPaaS自带的-无效
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    self.title = viewController.title;
    self.navigationItem.leftBarButtonItem = viewController.navigationItem.leftBarButtonItem;
    self.navigationItem.leftBarButtonItems = viewController.navigationItem.leftBarButtonItems;
    self.navigationItem.rightBarButtonItem = viewController.navigationItem.rightBarButtonItem;
    self.navigationItem.rightBarButtonItems = viewController.navigationItem.rightBarButtonItems;
    
    NSLog(@"系统代理当前选择   %lu",(unsigned long)tabBarController.selectedIndex);
    if (tabBarController.selectedIndex == 1) {
        
    }
    
}

#pragma mark ====================== 处理屏幕旋转--UITabBarController+导航控制器里也设置了（在用，请不要删）=========================
-(BOOL)shouldAutorotate{
    return [self.selectedViewController shouldAutorotate];
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return [self.selectedViewController supportedInterfaceOrientations];
}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return [self.selectedViewController preferredInterfaceOrientationForPresentation];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
