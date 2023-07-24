//
//  CXTabBarController.m
//  AiHenDeChaoXi
//
//  Created by 戴维保 on 2018/3/19.
//  Copyright © 2018年 北京嗅美科技有限公司. All rights reserved.
//

#import "CXTabBarController.h"
#import "CXNavigationController.h"
//tabbar
#import "TBTabBar.h"
//自己定义的tabbar
#import "CXTabbar.h"
//首页
#import "HopmeViewController.h"


@interface CXTabBarController ()<UITabBarControllerDelegate>
/** 之前被选中的UITabBarItem */
@property (nonatomic, strong) UITabBarItem *lastItem;

//语音控制器
@property(nonatomic,strong)UIViewController *voiceVC;

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
    
//    UITabBar *tabBar = [[UITabBar alloc] init];//不凸出的tabbar
    
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
    
    
    // 二次点击触发刷新将默认被选中的tabBarItem保存为属性
    self.lastItem = tabBar.selectedItem;
    
    
    
    //中间发布按钮点击回调(屏蔽掉就就换成不突出的)
    __weak typeof(self) weakSelf = self;
    [tabBar setDidClickPublishBtn:^{
        //凸出按钮点击事件
        //点击按钮选中语音tabbar
         weakSelf.selectedIndex = 2;
      
        
    }];
    
    //button抬起
    [tabBar setDidClickPublishBtnRemo:^{
        //按钮抬起来
       
        
    }];


}


#pragma mark -初始化所有控制器

- (void)setUpChildVC {
    
    HopmeViewController *homeVC = [[HopmeViewController alloc] init];
    //设置角标数量
    //    homeVC.tabBarItem.badgeValue = @"1111";
    
    [self setChildVC:homeVC title:@"首页" image:@"tabbar-资讯" selectedImage:@"tabbar-资讯S"];
    
    UIViewController *SecondVC = [[UIViewController alloc] init];
    [self setChildVC:SecondVC title:@"测试1" image:@"tabbar-缴费"  selectedImage:@"tabbar-缴费S"];
    
    //语音
    UIViewController *voiceVC = [[UIViewController alloc] init];
    self.voiceVC = voiceVC;
    [self setChildVC:voiceVC title:@"" image:@""  selectedImage:@""];//什么都不设置

    //开门
    UIViewController *messageVC = [[UIViewController alloc] init];
    [self setChildVC:messageVC title:@"测试2" image:@"tabbar-门禁"  selectedImage:@"tabbar-门禁S"];
    
    //我的
    UIViewController *myVC = [[UIViewController alloc] init];
    [self setChildVC:myVC title:@"我的" image:@"tabbar-我的" selectedImage:@"tabbar-我的S"];
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
    dictSelect[NSForegroundColorAttributeName] = [UIColor blackColor];
    dictSelect[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    
    //禁用渲染
    [childVC.tabBarItem setTitleTextAttributes:dict forState:UIControlStateNormal];
    [childVC.tabBarItem setTitleTextAttributes:dictSelect forState:UIControlStateSelected];
    
    //设置图片
    childVC.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVC.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    //字控制器图片调整文字图片位置
    childVC.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -4);
    childVC.tabBarItem.imageInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    
    // 二次点击触发刷新将默认被选中的tabBarItem保存为属性
    self.lastItem = self.tabBar.selectedItem;
    
    //导航
    CXNavigationController *nav = [[CXNavigationController alloc] initWithRootViewController:childVC];
    //    nav.navigationBar.barTintColor = [UIColor whiteColor];//导航栏颜色
    [self addChildViewController:nav];
}

//二次点击tabbar触发刷新代理方法
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    // 判断本次点击的UITabBarItem是否和上次的一样
    if (item == self.lastItem) { // 一样就发出通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"LLTabBarDidClickNotification" object:nil userInfo:nil];
    }
    // 将这次点击的UITabBarItem赋值给属性
    self.lastItem = item;
}


/**
 *  iOS点击tabbar判断是否跳转到登陆界面
    TabBarController代理,写在CXTabBarController里，首先要遵守协议：UITabBarControllerDelegate， self.delegate = self;//设置代理
 */
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    if ([viewController.tabBarItem.title isEqualToString:@"首页"] || [viewController.tabBarItem.title isEqualToString:@"测试1"] || [viewController.tabBarItem.title isEqualToString:@"我的"]) {
        NSString *sign = @""; //取出登陆状态(NSUserDefaults即可)
        NSInteger selectedIndex  =  0 ;
        if ([NSString isNULL:sign]==NO) {  //未登录
            if ([viewController.tabBarItem.title isEqualToString:@"首页"]) {
                selectedIndex = 0;
            } else if ([viewController.tabBarItem.title isEqualToString:@"测试1"]) {
                selectedIndex = 1;
            }else if ([viewController.tabBarItem.title isEqualToString:@"测试2"]) {
                selectedIndex = 3;
            } else if ([viewController.tabBarItem.title isEqualToString:@"我的"]) {
                selectedIndex = 4;
            }
            //            //弹窗登陆
            //            [AlertCXLoginView showAletCXInfoisBlackHome:nil LoginSuccess:^{
            //                //登陆成功后判断选定哪一个
            //                _rootVC.selectedIndex = selectedIndex;
            //            }];
            
            return NO;
        }else{
            return YES;
        }
    }else{
        return YES;
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
