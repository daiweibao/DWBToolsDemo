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


//创建tabbar
- (void)createTabbar{
    //隐藏系统的tababr的item
    self.tabBar.hidden = YES;
    [self.myTabBarView removeFromSuperview];//移除重新创建
    
    //移除控制器，防止重复添加
    for (UIViewController *vc in self.childViewControllers) {
        [vc removeFromParentViewController];
    }

    //首页
    HopmeViewController *homeVC = [HopmeViewController new];
    CXNavigationController *nav1 = [[CXNavigationController alloc]initWithRootViewController:homeVC];
    
    //
    UIViewController *twoVC = [UIViewController new];
    CXNavigationController *nav2 = [[CXNavigationController alloc]initWithRootViewController:twoVC];

    //我的
    UIViewController *myVC = [UIViewController new];
    CXNavigationController *nav3 = [[CXNavigationController alloc]initWithRootViewController:myVC];
    
    //添加控制器到系统tabbar里
    [self addChildViewController:nav1];
    [self addChildViewController:nav2];
    [self addChildViewController:nav3];
    
    //最后添加自定义的tabbar的item，添加到self.view的最上层。
    //【⚠️⚠️⚠️注意：hitTest方法只能在添加到self.view的.m里实现才生效，如果hitTest方法所在view没有addSubview添加到self.view上，那么hitTest将无效。】所以self.myTabBarView添加到self.view上
    self.myTabBarView = [[CXTabBarItemView alloc] init];
    self.myTabBarView.delegate = self;
    self.myTabBarView.backgroundColor = [UIColor clearColor];//背景色
    self.myTabBarView.frame = CGRectMake(0, SCREEN_HEIGHT-MC_TabbarHeight, SCREEN_WIDTH, MC_TabbarHeight);
    [self.view addSubview:self.myTabBarView];
    //创建tababr
    [self.myTabBarView createTabbarItemMainUI];
    
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
    self.myTabBarView.hidden = YES;
}

//手动调用显示tabbar
- (void)showTheTabbar{
    self.myTabBarView.hidden = NO;
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
