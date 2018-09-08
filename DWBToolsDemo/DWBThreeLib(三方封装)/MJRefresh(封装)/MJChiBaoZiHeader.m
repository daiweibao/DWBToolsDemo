//
//  MJChiBaoZiHeader.m
//  MJRefreshExample
//
//  Created by MJ Lee on 15/6/12.
//  Copyright © 2015年 小码哥. All rights reserved.
//

#import "MJChiBaoZiHeader.h"

@implementation MJChiBaoZiHeader
#pragma mark - 重写方法
#pragma mark 基本设置
- (void)prepare
{
    [super prepare];
    
    // 设置普通状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
//    for (NSUInteger i = 1; i<=60; i++) {
//        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_anim__000%zd", i]];
//        [idleImages addObject:image];
//    }
    //自己的
    for (NSUInteger i = 1; i<3; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"明杰刷新动画%zd", i]];
        [idleImages addObject:image];
    }
    
     [self setImages:idleImages forState:MJRefreshStateIdle];
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    NSMutableArray *refreshingImages = [NSMutableArray array];
//    for (NSUInteger i = 1; i<=3; i++) {
//        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_loading_0%zd", i]];
//        [refreshingImages addObject:image];
//    }
    
    //自己的
    for (NSUInteger i = 1; i<3; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"明杰刷新动画等待中%zd", i]];
        [refreshingImages addObject:image];
    }
    
    [self setImages:refreshingImages duration:0.5 forState:MJRefreshStatePulling];
    
    // 设置正在刷新状态的动画图片
    [self setImages:refreshingImages duration:0.5 forState:MJRefreshStateRefreshing];
    
    // 设置即将准备刷新
    [self setImages:refreshingImages duration:0.5 forState:MJRefreshStateWillRefresh];
    
}
@end
