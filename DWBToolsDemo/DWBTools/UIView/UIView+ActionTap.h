//
//  UIView+ActionTap.h
//  ZuiMeiXinNiang
//
//  Created by 戴维保 on 16/9/2.
//  Copyright © 2016年 潮汐科技有限公司. All rights reserved.
//-

#import <UIKit/UIKit.h>

@interface UIView (ActionTap)

typedef void (^TouchBlock)(void);
/**
 *  点击手势封装,直接调用
 *
 *  @param block block
 */
-(void)addTapActionTouch:(TouchBlock)block;

//用法
//UIImageView * view = [[UIImageView alloc] initWithFrame:CGRectMake(80, 80, 80, 80)];
//view.backgroundColor = [UIColor redColor];
//view.userInteractionEnabled = YES;
//[view addTapActionTouch:^{
//    NSLog(@"点击手势");
//}];
//[self.view addSubview:view];

@end
