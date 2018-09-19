//
//  HopmeViewController.m
//  DWBToolsDemo
//
//  Created by 戴维保 on 2018/9/8.
//  Copyright © 2018年 北京嗅美科技有限公司. All rights reserved.
//

#import "HopmeViewController.h"
#import "ToolsEntController.h"
@interface HopmeViewController ()

//功能入口
@property(nonatomic,weak) DragEnableButton * buttonTools;

@end

@implementation HopmeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.backButton.hidden = YES;
    self.titleNavLabel.text = @"我的工具类Demo";
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(50, 100, 300, 100);
    [button setTitle:@"工具类，请看代码文件夹：DWBTools 和 DWBThreeLib(三方封装)" forState:UIControlStateNormal];
    button.titleLabel.numberOfLines = 0;
    [button.titleLabel sizeToFit];
    [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [self.view addSubview:button];
    
    //创建功能入口控制器UI
    [self createToolsControllerUI];
    
}


//创建功能入口控制器UI
-(void)createToolsControllerUI{
#pragma mark ================= 功能入口制器入口 =================
    //测试控制器入口
    DragEnableButton * buttonTools = [DragEnableButton buttonWithType:UIButtonTypeCustom];
    self.buttonTools = buttonTools;
    buttonTools.frame = CGRectMake(SCREEN_WIDTH-55, SCREEN_HEIGHT-MC_TabbarHeight-210, 50, 50);
    [buttonTools setTitle:@"入口" forState:UIControlStateNormal];
    buttonTools.backgroundColor = [UIColor redColor];
    buttonTools.layer.cornerRadius = 25;
    buttonTools.titleLabel.font = [UIFont systemFontOfSize:15];
    WeakSelf(self);
    WeakSelf(buttonTools);
    [buttonTools addTapActionTouch:^{
        //这里一定要用点击手势，否则不响应
        //测试控制器
        ToolsEntController *testVC = [[ToolsEntController alloc] init];
        [weakself.navigationController pushViewController:testVC animated:YES];
        //关闭高亮
        weakbuttonTools.highlighted = NO;
        
    }];
    //拖拽
    [buttonTools setDragEnable:YES];
    //吸附
    [buttonTools setAdsorbEnable:YES];
    [[UIApplication sharedApplication].keyWindow addSubview:buttonTools];
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
