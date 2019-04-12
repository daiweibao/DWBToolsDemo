//
//  HomeViewController.m
//  DWBToolsDemo
//
//  Created by 戴维保 on 2019/3/7.
//  Copyright © 2019 潮汐科技有限公司. All rights reserved.
//

#import "HomeViewController.h"

#import "ToolsEntController.h"
#import "TestModel.h"
@interface HomeViewController ()

//功能入口
@property(nonatomic,weak) DragEnableButton * buttonTools;

@property(nonatomic,strong)TestModel * model;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.backButton.hidden = YES;
    self.titleNavLabel.text = @"首页";
    
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
#if DEBUG
    //测试环境打开
#else
    //线上环境不打开
    return;
#endif
    //    //模拟器判断
    //    if ([DWBDeviceHelp isSimulator]==YES) {
    //        if ([[getUUID getUUID] isEqual:@"CB1480F5-53FE-4CFB-B743-0A50858D4210"]||//iPhone XS Max
    //            [[getUUID getUUID] isEqual:@"50B89EB9-F75F-4625-A3BA-DEF73D0BB7E1"]||//iPhone X
    //            [[getUUID getUUID] isEqual:@"BB99A1CB-A16F-4C32-A714-07D1D01531E2"]||//iPhone SE
    //            [[getUUID getUUID] isEqual:@"C7D27AB3-158F-4C50-B8C1-ADFB8214D908"]//iPhone 8
    //            ) {
    //            //创建
    //        }else{
    //            return;
    //        }
    //
    //    }else{
    //        //真机判断显示条件
    //        if(![GET_userPhoneName isEqual:@"爱恨的潮汐"]){
    //            return;
    //        }
    //    }
    
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
        testVC.controllerId = @"控制器的Id";
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

    _buttonTools.hidden = NO;//功能入口控制器
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    _buttonTools.hidden = YES;//功能入口控制器
    //跟控制器将要消失也要打开tabbar
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
