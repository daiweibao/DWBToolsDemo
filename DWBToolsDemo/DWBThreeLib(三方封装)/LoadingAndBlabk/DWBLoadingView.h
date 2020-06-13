//
//  DWBLoadingView.h
//  XiaoYuanSheQu
//
//  Created by 戴维保 on 16/9/12.
//  Copyright © 2016年 潮汐科技有限公司. All rights reserved.
//
//封装的加载中和加载失败网络提示
#import <UIKit/UIKit.h>

@interface DWBLoadingView : UIView

/// 加载中封装
/// @param frame 控件坐标
/// @param addSubViewMy 添加哪一个父视图上
/// @param isBack 是否创建返回键
/// @param loadeFailure 加载失败点击回调
- (instancetype)initWithFrame:(CGRect)frame AddLoadingAddSubView:(UIView *)addSubViewMy isCreateBack:(BOOL)isBack LoadeFailure:(void (^)(void))loadeFailure;

///加载失败UI--没网(居中样式)
-(void)loadingfailureUI;

/// 加载失败UI--服务器报错(居中样式)
-(void)loadingfailure_ServerErrorUI;

/// 移除加载中
-(void)removeLoading;


#pragma mark ===========用法
/*
 //加载中
 @property (nonatomic, strong)DWBLoadingView *loadingView;
 //添加加载中【封装】
 WeakSelf(self);
 self.loadingView =[[DWBLoadingView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-MC_NavHeight) AddLoadingAddSubView:self.view isCreateBack:NO LoadeFailure:^{
     //加载失败点击回调，这里如果不处理，界面就会一直停留在加载中动画上
     [weakself.tableView.mj_header beginRefreshing];
 }];
 //没网
 [self.loadingView loadingfailureUI];
 //服务器异常
 [self.loadingView loadingfailure_ServerErrorUI];
 //移除加载中
 [self.loadingView removeLoading];
 
 */



@end

