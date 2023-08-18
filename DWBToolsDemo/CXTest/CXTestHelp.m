//
//  CXTestHelp.m
//  hnnxebank
//
//  Created by 季文斌 on 2023/7/28.
//  Copyright © 2023 Alibaba. All rights reserved.
//

#import "CXTestHelp.h"
#import "DragEnableButton.h"
#import "ToolsEntController.h"

@interface CXTestHelp()

@end

@implementation CXTestHelp


//创建功能入口控制器UI
+(void)createToolsControllerUI:(UIViewController *)VC{
#pragma mark ================= 功能入口制器入口 =================
    
#ifdef CXDEBUG
    //开发模式
#else
    //生产
    return;
#endif
    
    //测试控制器入口
    DragEnableButton * buttonTools = [DragEnableButton buttonWithType:UIButtonTypeCustom];
    buttonTools.frame = CGRectMake(SCREEN_WIDTH-55, SCREEN_HEIGHT-MC_TabbarHeight-310, 50, 50);
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
        [VC.navigationController pushViewController:testVC animated:YES];
        //关闭高亮
        weakbuttonTools.highlighted = NO;
        
    }];
    //拖拽
    [buttonTools setDragEnable:YES];
    //吸附
    [buttonTools setAdsorbEnable:YES];
    [VC.view addSubview:buttonTools];
}


@end
