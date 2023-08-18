//
//  HopmeViewController.m
//  DWBToolsDemo
//
//  Created by 戴维保 on 2018/9/8.
//  Copyright © 2018年 北京嗅美科技有限公司. All rights reserved.
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
    self.navigationCXView.hidden = YES;
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

//
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//
//    NSLog(@"点击屏幕");
//}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //打开tabbar
    self.tabBarController.tabBar.hidden = NO;
    
    _buttonTools.hidden = NO;//功能入口控制器
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    _buttonTools.hidden = YES;//功能入口控制器
    //跟控制器将要消失也要打开tabbar
    self.tabBarController.tabBar.hidden = NO;
    
}

-(void)dealloc{
    
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
