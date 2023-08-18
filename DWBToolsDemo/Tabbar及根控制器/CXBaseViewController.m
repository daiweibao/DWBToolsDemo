//
//  CXBaseViewController.m
//  AiHenDeChaoXi
//
//  Created by 戴维保 on 2023/8/18.
//  Copyright © 2023年 北京嗅美科技有限公司. All rights reserved.
//

#import "CXBaseViewController.h"

@interface CXBaseViewController ()

@end

@implementation CXBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //控制器背景颜色
    self.view.backgroundColor = [UIColor whiteColor];
    //设置状态栏的字体颜色
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    //创建导航栏
    [self createCXNav];
    
}


//创建导航
-(void)createCXNav{
    //导航栏
    UIView *navView= [[UIView alloc]init];
    self.navigationCXView = navView;
    self.navigationCXView.hidden = NO;//不影藏
    navView.frame = CGRectMake(0, 0, SCREEN_WIDTH, MC_NavHeight);
    navView.backgroundColor = kMainColor_NavBG;
    [self.view addSubview:navView];
    
    //创建返回键
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.backNavButton =backButton;
    backButton.frame = CGRectMake(0, MC_StatusBarHeight, 64, 44);
    backButton.contentMode = UIViewContentModeScaleAspectFill;
    backButton.clipsToBounds = YES;
    [backButton setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(pressButtonLeft) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:backButton];
    
    //导航标题
    UILabel * labelTitle = [[UILabel alloc]init];
    self.titleNavLabel = labelTitle;
    labelTitle.frame = CGRectMake(44, MC_StatusBarHeight, SCREEN_WIDTH-88, 44);
    labelTitle.backgroundColor = [UIColor clearColor];
    labelTitle.font = [UIFont boldSystemFontOfSize:18];
    labelTitle.textColor = [UIColor blackColor];
    labelTitle.text = @"";
    labelTitle.textAlignment = NSTextAlignmentCenter;
    [navView addSubview:labelTitle];
    
    //创建分割线
    UIView * lineNavView = [[UIView alloc]init];
    lineNavView.frame = CGRectMake(0, navView.height-0.5, SCREEN_WIDTH, 0.5);
    lineNavView.backgroundColor = kMainColor_NavBG;
    [navView addSubview:lineNavView];
    
}
//返回
-(void)pressButtonLeft{
//    [self.navigationController popViewControllerAnimated:YES];
    NSArray *viewcontrollers=self.navigationController.viewControllers;
    if (viewcontrollers.count>1) {
        if ([viewcontrollers objectAtIndex:viewcontrollers.count-1]==self) {
            //push方式
            [self.navigationController popViewControllerAnimated:YES];
        }
    }else{
        //present方式
        [self  dismissViewControllerAnimated:YES completion:nil];
    }
}

//将要出现
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //记得去导航控制器里设置影藏导航栏，CXNavigationController  里面设置影藏，不然此处隐藏无效
    //影藏导航栏，一定要用动画方式
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

//将要消失
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

//dealloc
-(void)dealloc{
    NSLog(@"走了dealloc");
}

//侧换返回和点击返回按钮都会走这里，控制不走dealloc也会走这里。
-(void)didMoveToParentViewController:(UIViewController*)parent{
    [super didMoveToParentViewController:parent];
    NSLog(@"%s,%@",__FUNCTION__,parent);
    if(!parent){
        NSLog(@"页面pop成功了");
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
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
