//
//  HopmeViewController.m
//  DWBToolsDemo
//
//  Created by 爱恨的潮汐 on 2018/9/8.
//  Copyright © 2018年 潮汐科技有限公司. All rights reserved.
//

#import "HopmeViewController.h"
//测试按钮
#import "CXTestHelp.h"

#import "TestModel.h"
@interface HopmeViewController ()

//功能入口
@property(nonatomic,weak) DragEnableButton * buttonTools;

@property(nonatomic,strong)TestModel * model;

@end

@implementation HopmeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.backNavButton.hidden = YES;//隐藏返回键
    self.titleNavLabel.text = @"我的工具类Demo";
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(50, 100, 300, 100);
    [button setTitle:@"工具类，请看代码文件夹：DWBTools 和 DWBThreeLib(三方封装)" forState:UIControlStateNormal];
    button.titleLabel.numberOfLines = 0;
    [button.titleLabel sizeToFit];
    [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [self.view addSubview:button];
    
    //创建功能入口控制器UI
#ifdef CXDEBUG
    //开发模式
    //测试按钮
    [CXTestHelp createToolsControllerUI:self];
#else
    //生产
    return;
#endif
    
}



//将要出现
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //记得去导航控制器里设置影藏导航栏，HSBaseNavigationController  里面设置影藏
    //展示tabbar
    self.tabBarController.tabBar.hidden = YES;//隐藏系统的
    [[CXTabBarController shareTabBarController] showTheTabbar];//展示自定义的
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
