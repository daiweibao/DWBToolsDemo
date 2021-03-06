//
//  CXTabBarController.m
//  AiHenDeChaoXi
//
//  Created by chaoxi on 2018/3/19.
//  Copyright © 2018年 chaoxi科技有限公司. All rights reserved.
//

#import "CXTabBarController.h"
#import "CXNavigationController.h"
//tabbar
#import "TBTabBar.h"
//自己定义的tabbar
#import "CXTabbar.h"

//首页
#import "HomeViewController.h"
#import "CategoryViewController.h"
#import "ActivityViewController.h"
#import "MineViewController.h"
//登录
#import "LoginViewController.h"


@interface CXTabBarController ()<UITabBarControllerDelegate>
/** 之前被选中的UITabBarItem角标 */
@property (nonatomic,assign) NSInteger selectIndexCX;

@end

@implementation CXTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 初始化所有控制器
    [self setUpChildVC];
    
    // 创建tabbar中间的tabbarItem
    [self setUpMidelTabbarItem];
    
    self.delegate = self;//设置代理
    
}

#pragma mark -创建tabbar中间的tabbarItem

- (void)setUpMidelTabbarItem {
    
    
//    TBTabBar *tabBar = [[TBTabBar alloc] init];//凸出的tabbar
    
//    UITabBar *tabBar = [[UITabBar alloc] init];//不凸出的系统tabbar
    
     CXTabbar *tabBar = [[CXTabbar alloc] init]; //自己定义的tabbar
    
    // KVC：如果要修系统的某些属性，但被设为readOnly，就是用KVC，即setValue：forKey：。
    [self setValue:tabBar forKey:@"tabBar"];
    
    //去掉黑线,然后替换tabbar上面那一条线,下面两个方法必须同时设置，否则无效imageWithColor是根据颜色生成图片的封装
    [tabBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor] size:CGSizeMake(self.view.frame.size.width, .5)]];
    //添加tabbar黑线
    [tabBar setShadowImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"#D8D8D8"] size:CGSizeMake(self.view.frame.size.width, .5)]];
    

//    //tabbar添加阴影
//    tabBar.layer.shadowColor = [UIColor blackColor].CGColor;
//    tabBar.layer.shadowOffset = CGSizeMake(0, -2);
//    tabBar.layer.shadowOpacity = 0.1;
//    tabBar.layer.shadowRadius =1;

//
    //（3）设置其他属性
    tabBar.barTintColor = [UIColor whiteColor];//设置tabbar背景颜色
    tabBar.translucent = NO;
    
    
    //中间发布按钮点击回调(屏蔽掉就就换成不突出的)
    __weak typeof(self) weakSelf = self;
    [tabBar setDidClickPublishBtn:^{
        //凸出按钮点击事件
        [weakSelf actionTabbarActive];

    }];

}

//点击tabbar按钮
-(void)actionTabbarActive{
    UINavigationController * nav = [(UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController selectedViewController];
    ActivityViewController * VC = [[ActivityViewController alloc]init];
    [nav pushViewController:VC animated:YES];
}


#pragma mark -初始化所有控制器

- (void)setUpChildVC {
    
    HomeViewController *homeVC = [[HomeViewController alloc] init];
    //设置角标数量
    //    homeVC.tabBarItem.badgeValue = @"1111";
    
    [self setChildVC:homeVC title:@"首页" image:@"tab_mall_normal" selectedImage:@"tab_mall"];
    
    CategoryViewController *SecondVC = [[CategoryViewController alloc] init];
    [self setChildVC:SecondVC title:@"分类" image:@"tab_fenlei_normal"  selectedImage:@"tab_fenlei"];
    
    //中间突出
    UIViewController *centerVC = [[UIViewController alloc] init];
    [self setChildVC:centerVC title:@"" image:@""  selectedImage:@""];//什么都不设置

    //
    FoundViewController *foundVC = [[FoundViewController alloc] init];
    [self setChildVC:foundVC title:@"发现" image:@"tab_faxian_normal"  selectedImage:@"tab_faxian"];
    
    //
    MineViewController *myVC = [[MineViewController alloc] init];
    [self setChildVC:myVC title:@"我的" image:@"tab_mine_normal" selectedImage:@"tab_mine"];
}

//设置子控制器
- (void) setChildVC:(UIViewController *)childVC title:(NSString *) title image:(NSString *) image selectedImage:(NSString *) selectedImage {
    childVC.tabBarItem.title = title;
    //设置字体属性
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSForegroundColorAttributeName] = [UIColor colorWithHexString:@"#999999"];
    dict[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    
    //设置字体属性(选中)
    NSMutableDictionary *dictSelect = [NSMutableDictionary dictionary];
    dictSelect[NSForegroundColorAttributeName] = COLOR_Main;
    dictSelect[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    
    //禁用渲染
    [childVC.tabBarItem setTitleTextAttributes:dict forState:UIControlStateNormal];
    [childVC.tabBarItem setTitleTextAttributes:dictSelect forState:UIControlStateSelected];
    
    //设置图片
    childVC.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVC.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
//    //字控制器图片调整文字图片位置【有效】
//    childVC.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -4);
//    childVC.tabBarItem.imageInsets = UIEdgeInsetsMake(0, 0, 0, 0);
//
    //导航
    CXNavigationController *nav = [[CXNavigationController alloc] initWithRootViewController:childVC];
    //    nav.navigationBar.barTintColor = [UIColor whiteColor];//导航栏颜色
    [self addChildViewController:nav];
}



/**
 *  iOS点击tabbar判断是否跳转到登陆界面
 TabBarController代理,写在CXTabBarController里，首先要遵守协议：UITabBarControllerDelegate， self.delegate = self;//设置代理
 */
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    if ([viewController.tabBarItem.title isEqualToString:@"我的"]) {
        if ([NSString isNULL:SESSIONID]) {//去登录
             UINavigationController * nav = [(UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController selectedViewController];
            LoginViewController * VC = [[LoginViewController alloc]init];
            //登录成功
            [VC setLoginSuccessfulAfter:^{
                tabBarController.selectedIndex = 4;
            }];
            //模拟模态动画push
            [UIViewController navPushToPresentWithPushController:VC];
            
           
            return NO;
        }else{
            return YES;
        }
    }else{
        return YES;
    }
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    
    // 判断本次点击的UITabBarItem是否和上次的一样
    if (tabBarController.selectedIndex == self.selectIndexCX) { // 一样就发出通知
        //二次点击
        [[NSNotificationCenter defaultCenter] postNotificationName:@"LLTabBarDidClickNotification" object:[NSString stringWithFormat:@"%lu",(unsigned long)tabBarController.selectedIndex] userInfo:nil];
        
    }else{
        NSLog(@"首次点击tabbar");
        [[NSNotificationCenter defaultCenter] postNotificationName:@"LLTabBarDidFirstActionClickNotification" object:[NSString stringWithFormat:@"%lu",(unsigned long)tabBarController.selectedIndex] userInfo:nil];
    }
    
    // 将这次点击的UITabBarItem赋值给属性
    self.selectIndexCX = tabBarController.selectedIndex;
    
    
    /*
    // 监听UITabBarItem被重复点击时的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarDidClick:) name:@"LLTabBarDidClickNotification" object:nil];
    //二次点击tabbar的事件,控件在屏幕中才刷新，不然点击其他tabbar也会刷新
    - (void)tabBarDidClick:(NSNotification *)notf{
        //点击的是自己才刷新
        if ([notf.object isEqual:@"0"]) {
            //必须在主线程，否则会死
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView.mj_header beginRefreshing]; // MJRefresh
            });
        }
    }
     
     */
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
