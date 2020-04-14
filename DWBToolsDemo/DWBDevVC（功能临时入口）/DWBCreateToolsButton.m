//
//  DWBCreateToolsButton.m
//  DWBToolsDemo
//
//  Created by 戴维保 on 2019/12/31.
//  Copyright © 2019 潮汐科技有限公司. All rights reserved.
//

#import "DWBCreateToolsButton.h"
#import "ToolsEntController.h"
@implementation DWBCreateToolsButton

//只执行一次的方法，在这个地方 替换方法
+(void)load{
    
    //保证线程安全
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        //延迟1秒执行，不然不显示，因为找不到当前显示的控制器
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [DWBCreateToolsButton createToolsControllerUI];
        });
        
    });
}


//创建功能入口控制器UI
+(void)createToolsControllerUI{
//    NSLog(@"当前设备UUID:%@",[getUUID getUUID]);
//#pragma mark ================= 功能入口制器入口 =================
//#if DEBUG
//    //测试环境打开
//#else
//    //线上环境不打开
//    return;
//#endif
//        //模拟器判断
//        if ([DWBDeviceHelp isSimulator]==YES) {
//            if ([[getUUID getUUID] isEqual:@"CB1480F5-53FE-4CFB-B743-0A50858D4210"]||//iPhone XS Max
//                [[getUUID getUUID] isEqual:@"50B89EB9-F75F-4625-A3BA-DEF73D0BB7E1"]||//iPhone X
//                [[getUUID getUUID] isEqual:@"BB99A1CB-A16F-4C32-A714-07D1D01531E2"]||//iPhone SE
//                [[getUUID getUUID] isEqual:@"7E3C3AF0-9A76-43BC-B2EE-2EA532E6B0C1"]||//iPhone11 Pro Max
//                [[getUUID getUUID] isEqual:@"C7D27AB3-158F-4C50-B8C1-ADFB8214D908"]//iPhone 8
//                ) {
//                //创建
//            }else{
//                return;
//            }
//
//        }else{
//            //真机判断显示条件
//            if(![GET_userPhoneName isEqual:@"爱恨的潮汐"]){
//                return;
//            }
//        }
//
    //测试控制器入口
    DragEnableButton * buttonTools = [DragEnableButton buttonWithType:UIButtonTypeCustom];
    buttonTools.frame = CGRectMake(SCREEN_WIDTH-55, SCREEN_HEIGHT-MC_TabbarHeight-210, 50, 50);
    [buttonTools setTitle:@"Debug" forState:UIControlStateNormal];
    buttonTools.backgroundColor = [UIColor redColor];
    buttonTools.layer.cornerRadius = 25;
    buttonTools.titleLabel.font = [UIFont boldSystemFontOfSize:12];
    WeakSelf(buttonTools);
    [buttonTools addTapActionTouch:^{
        //这里一定要用点击手势，否则不响应
        //测试控制器
        ToolsEntController *testVC = [[ToolsEntController alloc] init];
        testVC.controllerId = @"控制器的Id";
        [[UIViewController getTopWindowController].navigationController pushViewController:testVC animated:YES];
        //关闭高亮
        weakbuttonTools.highlighted = NO;
        
    }];
    //拖拽
    [buttonTools setDragEnable:YES];
    //吸附
    [buttonTools setAdsorbEnable:YES];
    [[UIViewController getTopWindowController].view addSubview:buttonTools];
}



@end
