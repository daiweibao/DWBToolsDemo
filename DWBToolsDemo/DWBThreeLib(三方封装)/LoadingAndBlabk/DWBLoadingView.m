
//
//  DWBLoadingView.m
//  XiaoYuanSheQu
//
//  Created by 戴维保 on 16/9/12.
//  Copyright © 2016年 潮汐科技有限公司. All rights reserved.
//

#import "DWBLoadingView.h"
//加载中图片--三方
#import "FBShimmeringView.h"
@interface DWBLoadingView()
//添加到的父视图
@property (nonatomic, strong) UIView *addSubViewMy;
//是否要创建返回键
@property(nonatomic,assign)BOOL isBack;
//加载失败--没网
@property (nonatomic, strong)UIView * viewNoNetFailureSub;
//加载失败-服务器报错
@property (nonatomic, strong)UIView * viewFailureServerErrorSub;
//加载失败的回调
@property (nonatomic,copy)void (^loadingfailureRefresh)(void);

@end

@implementation DWBLoadingView
// 在initWithFrame:方法中添加子控件
- (instancetype)initWithFrame:(CGRect)frame AddLoadingAddSubView:(UIView *)addSubViewMy isCreateBack:(BOOL)isBack LoadeFailure:(void (^)(void))loadeFailure{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = addSubViewMy.backgroundColor;
        self.addSubViewMy = addSubViewMy;
        //是否创建返回键
        self.isBack = isBack;
        //回调
        self.loadingfailureRefresh =loadeFailure;
        //添加到父视图上
        [addSubViewMy addSubview:self];
        //添加到最上层
        [addSubViewMy bringSubviewToFront:self];
        //创建UI
        [self loadingNew];
        
        [self addTapActionTouch:^{
            //拦截点击事件
        }];
    }
    return self;
}

//加载中UI
-(void)loadingNew{
    //需要创建导航栏的
    if (self.isBack==YES) {
        //主导航栏
        UIView *TopView = [[UIView alloc]init];
        TopView.frame = CGRectMake(0, 0, self.width, MC_NavHeight);
        TopView.backgroundColor = [UIColor whiteColor];
        [self addSubview:TopView];
        //返回键
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        backButton.frame = CGRectMake(0, MC_StatusBarHeight, 84, 44);
        backButton.contentMode = UIViewContentModeScaleAspectFill;
        backButton.clipsToBounds = YES;
        [backButton setImage:[UIImage imageNamed:@"backicon"] forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(pressButtonLeftNew) forControlEvents:UIControlEventTouchUpInside];
        [TopView addSubview:backButton];
        
        //创建一条线
        UIView * navLine = [[UIView alloc]init];
        navLine.frame = CGRectMake(0, TopView.bottomY-1, TopView.width, 1);
        navLine.backgroundColor = [UIColor clearColor];
        [TopView addSubview:navLine];
    }
    
    //加载中--三方
    FBShimmeringView * shimmmeringView = [[FBShimmeringView alloc] init];
    shimmmeringView.backgroundColor = [UIColor clearColor];
    shimmmeringView.shimmeringPauseDuration = 1;
    shimmmeringView.shimmeringSpeed = 200;
    [self addSubview:shimmmeringView];
    
    //加载中动画 111* 111
    UIButton * buttonLoding = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonLoding.tag = 456674;
    [buttonLoding setImage:[UIImage imageNamed:@"icon_loding"] forState:UIControlStateNormal];
    [self addSubview:buttonLoding];
    
    //三方控件赋值
    shimmmeringView.contentView = buttonLoding;
    shimmmeringView.shimmering = YES;
    //    211* 40
    CGFloat lW = 111;
    CGFloat lH = 111;
    
    if (self.isBack==YES) {
        //要创建返回键
        buttonLoding.frame = CGRectMake(SCREEN_WIDTH/2-lW/2, (self.height-lH - MC_NavHeight)/2, lW, lH);
        //动画控件坐标
        shimmmeringView.frame = buttonLoding.frame;
  
    }else{
        //不用创建返回键
        buttonLoding.frame = CGRectMake(SCREEN_WIDTH/2-lW/2, (self.height-lH)/2, lW, lH);
        //动画控件坐标
        shimmmeringView.frame = buttonLoding.frame;
    }
}

/**
 加载失败UI--没网(居中样式)
 */
-(void)loadingfailureUI{
    //控件存在才添加
    if (self) {
        //加载失败父视图
        [self.viewNoNetFailureSub removeFromSuperview];//先移除
        
        self.viewNoNetFailureSub = [[UIView alloc]init];
        self.viewNoNetFailureSub.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.viewNoNetFailureSub];
        if (self.isBack==NO) {
            //不用创建返回键
            self.viewNoNetFailureSub.frame =CGRectMake(0, 0, SCREEN_WIDTH, self.height);
        }else{
            //要创建返回键不能挡住加载中上面创建的返回键--所以坐标重新计算
            self.viewNoNetFailureSub.frame =CGRectMake(0, MC_NavHeight, SCREEN_WIDTH, self.height-MC_NavHeight);
        }
        
        //加载失败子视图View
        UIView *failureSubSmall = [[UIView alloc]init];
        [self.viewNoNetFailureSub addSubview:failureSubSmall];
        //开始创建子控制器
        //图标
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:@"加载失败-没网"];
        imageView.contentMode = UIViewContentModeCenter;
        imageView.frame = CGRectMake((SCREEN_WIDTH-dwb_pt(150))/2,0, dwb_pt(150), dwb_pt(130));
        [failureSubSmall addSubview:imageView];
        
        //标题1
        UILabel *title = [[UILabel alloc] init];
        title.text = @"网络错误";
        title.font = [UIFont boldSystemFontOfSize:16];
        title.textColor = DWBColorHex(@"#272030");
        title.textAlignment = NSTextAlignmentCenter;
        title.frame = CGRectMake(0, imageView.bottomY+dwb_pt(30), SCREEN_WIDTH, dwb_pt(17));
        [failureSubSmall addSubview:title];
        //标题2
        UILabel *title2 = [[UILabel alloc] init];
        title2.text = @"请检查网络连接是否正常";
        title2.font = [UIFont systemFontOfSize:12];
        title2.textColor = DWBColorHex(@"#A59FB4");
        title2.textAlignment = NSTextAlignmentCenter;
        title2.frame = CGRectMake(0, title.bottomY+dwb_pt(12), SCREEN_WIDTH, dwb_pt(13));
        [failureSubSmall addSubview:title2];
        
        //刷新
        UILabel *retryBtn = [[UILabel alloc]init];
        retryBtn.frame = CGRectMake(imageView.x, title2.bottomY + dwb_pt(50), dwb_pt(300), dwb_pt(44));
        retryBtn.centerX = imageView.centerX;
        retryBtn.font = [UIFont boldSystemFontOfSize:16];
        retryBtn.text = @"刷新";
        retryBtn.textColor =DWBColorHex(@"#FFFFFF");
        retryBtn.textAlignment = NSTextAlignmentCenter;
        [failureSubSmall addSubview:retryBtn];
        //设置圆角阴影
        //圆角
        retryBtn.layer.backgroundColor = [UIColor redColor].CGColor;
        retryBtn.layer.cornerRadius = 22;
        //阴影
        retryBtn.layer.shadowColor = [UIColor colorWithRed:255/255.0 green:200/255.0 blue:215/255.0 alpha:1.0].CGColor;
        retryBtn.layer.shadowOffset = CGSizeMake(0,5);
        retryBtn.layer.shadowOpacity = 1;
        retryBtn.layer.shadowRadius = 20;
        WeakSelf(self);
        [retryBtn addTapActionTouch:^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if (weakself.loadingfailureRefresh) {
                    weakself.loadingfailureRefresh();
                }
                //移除加载失败图片，不要移除加载中图片
                [weakself.viewNoNetFailureSub removeFromSuperview];
            });
        }];
        
        CGFloat viewAllH =retryBtn.bottomY;
        //子视图父坐标
        failureSubSmall.frame = CGRectMake(0, (self.viewNoNetFailureSub.height-viewAllH)/2, self.viewNoNetFailureSub.width, viewAllH);
    }
}


/**
 加载失败UI--服务器报错(居中样式)
 */
-(void)loadingfailure_ServerErrorUI{
    //控件存在才添加
    if (self) {
        //加载失败父视图
        [self.viewFailureServerErrorSub removeFromSuperview];
        
        self.viewFailureServerErrorSub = [[UIView alloc]init];
        self.viewFailureServerErrorSub.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.viewFailureServerErrorSub];
        
        if (self.isBack==NO) {
            //不用创建返回键
            self.viewFailureServerErrorSub.frame =CGRectMake(0, 0, SCREEN_WIDTH, self.height);
            
        }else{
            //要创建返回键不能挡住加载中上面创建的返回键--所以坐标重新计算
            self.viewFailureServerErrorSub.frame =CGRectMake(0, MC_NavHeight, SCREEN_WIDTH, self.height-MC_NavHeight);
        }
        
        //加载失败子视图View
        UIView *failureSubSmall = [[UIView alloc]init];
        [self.viewFailureServerErrorSub addSubview:failureSubSmall];
        
        //开始创建子控制器
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:@"加载失败-接口错误"];
        imageView.contentMode = UIViewContentModeCenter;
        imageView.frame = CGRectMake((SCREEN_WIDTH-dwb_pt(138))/2, 0, dwb_pt(138), dwb_pt(154));
        [failureSubSmall addSubview:imageView];
        
        
        //标题1
        UILabel *title = [[UILabel alloc] init];
        title.text = @"加载失败";
        title.font = [UIFont boldSystemFontOfSize:16];
        title.textColor = DWBColorHex(@"#272030");
        title.textAlignment = NSTextAlignmentCenter;
        title.frame = CGRectMake(0, imageView.bottomY+dwb_pt(30), SCREEN_WIDTH, dwb_pt(17));
        [failureSubSmall addSubview:title];
        //标题2
        UILabel *title2 = [[UILabel alloc] init];
        title2.text = @"攻城狮小哥哥正在紧急修理中";
        title2.font = [UIFont systemFontOfSize:12];
        title2.textColor = DWBColorHex(@"#A59FB4");
        title2.textAlignment = NSTextAlignmentCenter;
        title2.frame = CGRectMake(0, title.bottomY+dwb_pt(12), SCREEN_WIDTH, dwb_pt(13));
        [failureSubSmall addSubview:title2];
        
        //刷新
        UILabel *retryBtn = [[UILabel alloc]init];
        retryBtn.frame = CGRectMake(imageView.x, title2.bottomY + dwb_pt(50), dwb_pt(300), dwb_pt(44));
        retryBtn.centerX = imageView.centerX;
        retryBtn.font = [UIFont boldSystemFontOfSize:16];
        retryBtn.text = @"刷新";
        retryBtn.textColor =DWBColorHex(@"#FFFFFF");
        retryBtn.textAlignment = NSTextAlignmentCenter;
        [failureSubSmall addSubview:retryBtn];
        //设置圆角阴影
        //圆角
        retryBtn.layer.backgroundColor = [UIColor redColor].CGColor;
        retryBtn.layer.cornerRadius = 22;
        //阴影
        retryBtn.layer.shadowColor = [UIColor colorWithRed:255/255.0 green:200/255.0 blue:215/255.0 alpha:1.0].CGColor;
        retryBtn.layer.shadowOffset = CGSizeMake(0,5);
        retryBtn.layer.shadowOpacity = 1;
        retryBtn.layer.shadowRadius = 20;
        WeakSelf(self);
        [retryBtn addTapActionTouch:^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if (weakself.loadingfailureRefresh) {
                    weakself.loadingfailureRefresh();
                }
                //移除加载失败图片，不要移除加载中图片
                [weakself.viewFailureServerErrorSub removeFromSuperview];
            });
        }];
        
        CGFloat viewAllH =retryBtn.bottomY;
        failureSubSmall.frame = CGRectMake(0, (self.viewFailureServerErrorSub.height-viewAllH)/2, self.viewFailureServerErrorSub.width, viewAllH);
    }
}

//返回
-(void)pressButtonLeftNew{
    //返回
    [[UIViewController getTopWindowController].navigationController popViewControllerAnimated:YES];
    //启动广告的返回（勿删，否则启动广告点击无法返回）
    [[UIViewController getTopWindowController] dismissViewControllerAnimated:YES completion:nil];
    
}

/// 移除加载中
-(void)removeLoading{
    [self removeFromSuperview];
}



@end




