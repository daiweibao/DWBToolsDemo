//
//  CXRootViewController.m
//  AiHenDeChaoXi
//
//  Created by 戴维保 on 2018/3/19.
//  Copyright © 2018年 北京嗅美科技有限公司. All rights reserved.
//

#import "CXRootViewController.h"

@interface CXRootViewController ()

@end

@implementation CXRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self setupRootUI];
}

- (void)setupRootUI{
    
    
    //控制器，显示内容，除去导航高度--在最上面创建
    UIView * contentCXView = [[UIView alloc]init];
    self.contentCXView = contentCXView;
    [self.view addSubview:contentCXView];
    [contentCXView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(0);
    }];
    
    
    //主导航栏--不能添加到contentCXView上
    UIView *navigationCXView = [[UIView alloc]init];
    self.navigationCXView = navigationCXView;
    navigationCXView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:navigationCXView];
    [navigationCXView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(MC_NavHeight);
    }];
    
    //返回
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.backButton = backButton;
    backButton.contentMode = UIViewContentModeScaleAspectFill;
    backButton.clipsToBounds = YES;
    backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;//设置左对齐
    [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    backButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [backButton setImage:[UIImage imageNamed:@"黑色返回"] forState:UIControlStateNormal];
    [backButton setContentEdgeInsets:UIEdgeInsetsMake(0, 16, 0, 0)];//调整返回键按钮距离左边位置，不然返回键不灵敏
    [backButton addTarget:self action:@selector(pressButtonLeft:) forControlEvents:UIControlEventTouchUpInside];
    [navigationCXView addSubview:backButton];
    [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(64, 44));
    }];
    
    //导航标题
    UILabel *titleNavLabel = [[UILabel alloc]init];
    self.titleNavLabel = titleNavLabel;
    titleNavLabel.textColor = [UIColor blackColor];
    titleNavLabel.font = [UIFont boldSystemFontOfSize:17];
    titleNavLabel.textAlignment = NSTextAlignmentCenter;
    [navigationCXView addSubview:titleNavLabel];
    [titleNavLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(navigationCXView.mas_centerX);
        make.height.mas_equalTo(44);
        make.bottom.mas_equalTo(0);
    }];
    
    //右边按钮
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightButton = rightButton;
    [rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [rightButton addTarget:self action:@selector(pressButtonRight:) forControlEvents:UIControlEventTouchUpInside];
    rightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;//设置右对齐
    [rightButton setContentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 16)];//调整返回键距离左边位置，不然返回键不灵敏
    [navigationCXView addSubview:rightButton];
    [rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(100, 44));
    }];
    
    //导航栏下面的线
    UIView *lineNav = [[UIView alloc]init];
    self.lineNav = lineNav;
    lineNav.backgroundColor = [UIColor colorWithHexString:@"#D8D8D8"];
    [navigationCXView addSubview:lineNav];
    [lineNav mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(navigationCXView.mas_bottom);
        make.height.mas_equalTo(0.5);
    }];
    
    
}


//返回按钮点击
- (void)pressButtonLeft:(UIButton*)button{
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

//右边按钮
-(void)pressButtonRight:(UIButton*)button{
    
}


/*
 
 //特殊界面将要出现--关闭侧滑返回手势
 if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
 self.navigationController.interactivePopGestureRecognizer.enabled = NO;
 }
 
 //特殊界面将要消失--开启侧滑返回手势
 if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
 self.navigationController.interactivePopGestureRecognizer.enabled = YES;
 }
 
 */


//将要出现
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //友盟统计-开始（全局整个项目只需要一个就可以统计了）
    //    [NSString stringWithUTF8String:object_getClassName(self)]//根据父类获取子类控制器名字
//    [MobClick beginLogPageView:[NSString stringWithUTF8String:object_getClassName(self)]];
    //    防止关闭导航栏透明后  控制器坐标下移64
    self.extendedLayoutIncludesOpaqueBars = YES;
    //隐藏导航
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    //影藏tabbar
     self.tabBarController.tabBar.hidden = YES;
    
}
//将要消失
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //友盟统计-结束，（全局整个项目只需要一个就可以统计了）
    //    [NSString stringWithUTF8String:object_getClassName(self)]//根据父类获取子类控制器名字
//    [MobClick endLogPageView:[NSString stringWithUTF8String:object_getClassName(self)]];
    
    [SVProgressHUD dismiss];//影藏加载中
    
    //关闭键盘
    [[UIApplication sharedApplication].keyWindow.rootViewController.view endEditing:YES];
    
    //隐藏导航
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    //影藏tabbar
    self.tabBarController.tabBar.hidden = YES;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
}


@end

