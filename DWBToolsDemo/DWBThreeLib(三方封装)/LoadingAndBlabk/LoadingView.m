
//
//  LoadingView.m
//  XiaoYuanSheQu
//
//  Created by 戴维保 on 16/9/12.
//  Copyright © 2016年 北京嗅美科技有限公司. All rights reserved.
//

#import "LoadingView.h"
#import "Masonry.h"
@interface LoadingView()

//控制器
@property(nonatomic,strong)UIViewController * controller;
//是否要创建返回键
@property(nonatomic,assign)BOOL isBack;
//y坐标
@property(nonatomic,assign)CGFloat Max_Y;
//控件高度
@property(nonatomic,assign)CGFloat viewHeight;

@end

@implementation LoadingView

#pragma mark ==================新封装方法 ====================================
//新封装方法，传入起始坐标和高度，是否有导航栏 就可以
+(void)loadingView:(UIViewController*)controller isCreateBack:(BOOL)isBack viewMaxY:(CGFloat)max_Y viewHeight:(CGFloat)height LoadeFailure:(void (^)(void))loadeFailure{
    
    //必须判断否则会崩溃
    if (![controller isKindOfClass:[UIViewController class]]) {
        NSLog(@"不是控制器");
        
    }else{
        
        //创建
        LoadingView * loadView = [[LoadingView alloc]init];
        loadView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        loadView.controller = controller;
         loadView.tag = 456672;
        //是否创建返回键
        loadView.isBack = isBack;
        //y的最大坐标
        loadView.Max_Y = max_Y;
        
        //判断要不要创建返回键
        if (isBack==YES) {
            //如果要创建返回按钮，起始坐标固定为0
            loadView.frame = CGRectMake(0, max_Y-height, SCREEN_WIDTH, height);
        }else{
            //如果要创建返回按钮，起始坐标固定为0
            loadView.frame = CGRectMake(0, max_Y-height, SCREEN_WIDTH, height);
        }
        
        //控件高度（调set方法）--最后在创建
        loadView.viewHeight = height;
    
        //添加到控制器上
        [controller.view addSubview:loadView];
        //添加到控制器最上层
        [controller.view bringSubviewToFront:loadView];
        
        
        //加载失败的回调
        loadView.userInteractionEnabled = YES;
        [loadView addTapActionTouch:^{
           //找到加载失败的view
            UIView * viewFailureSub = (UIView*)[controller.view viewWithTag:456673];
            //如果加载失败的控件存在才能点击
            if (viewFailureSub) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (loadeFailure) {
                        loadeFailure();
                    }
                    //移除加载失败图片，不要移除加载中图片
                    [viewFailureSub removeFromSuperview];
                      //加载失败点击回调，这里如果不处理，界面就会一直停留在加载中动画上
                });
            }
        }];
    
    }
}

// 在initWithFrame:方法中添加子控件
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}


-(void)setViewHeight:(CGFloat)viewHeight{
    _viewHeight = viewHeight;
    //创建UI
    [self loadingNew];
}


//新的加载中
-(void)loadingNew{
    //需要创建导航栏的
    if (self.isBack==YES) {
        //主导航栏
        UIView *TopView = [[UIView alloc]init];
        TopView.backgroundColor = [UIColor whiteColor];
        [self addSubview:TopView];
        [TopView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(0);
            make.height.mas_equalTo(MC_NavHeight);
        }];
        [UIView setupShadowView:TopView];//设置阴影
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        backButton.frame = CGRectMake(0, MC_StatusBarHeight, 44, 44);
        backButton.contentMode = UIViewContentModeScaleAspectFill;
        backButton.clipsToBounds = YES;
        [backButton setImage:[UIImage imageNamed:@"nav_back_black"] forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(pressButtonLeftNew) forControlEvents:UIControlEventTouchUpInside];
        [TopView addSubview:backButton];
    
    }
    
    //加载中动画
    UIImageView *imageViewLoding = [[UIImageView alloc]init];
    imageViewLoding.tag = 456674;
    imageViewLoding.image = [UIImage imageNamed:@"加载中icon"];
    [self addSubview:imageViewLoding];
    if (self.isBack==YES) {
        //要创建返回键
        imageViewLoding.frame = CGRectMake(SCREEN_WIDTH/2-16, self.height/2-80+MC_NavHeight/2, 32, 33);
        
    }else{
        //不用创建返回键
        imageViewLoding.frame = CGRectMake(SCREEN_WIDTH/2-16,  self.height/2-80, 32, 33);
    }
    
    //提示
    UILabel *labelInfo = [[UILabel alloc]init];
    labelInfo.frame = CGRectMake(0, imageViewLoding.bottomY+24, SCREEN_WIDTH, 15);
    labelInfo.textAlignment = NSTextAlignmentCenter;
    labelInfo.text =@"加载中请稍后!";
    labelInfo.textColor = [UIColor colorWithHexString:@"#333333"];
    labelInfo.font = [UIFont systemFontOfSize:12];
    labelInfo.userInteractionEnabled = YES;
    [self addSubview:labelInfo];
    
   
    //让图片一直旋转
    CABasicAnimation *animation =  [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    //默认是顺时针效果，若将fromValue和toValue的值互换，则为逆时针效果
    animation.fromValue = [NSNumber numberWithFloat:0.f];
    animation.toValue =  [NSNumber numberWithFloat: M_PI *2];
    animation.duration  = 1;
    animation.autoreverses = NO;
    animation.fillMode =kCAFillModeForwards;
    animation.repeatCount = MAXFLOAT; //如果这里想设置成一直自旋转，可以设置为MAXFLOAT，否则设置具体的数值则代表执行多少次
    [imageViewLoding.layer addAnimation:animation forKey:nil];
    
    
}


/**
 加载失败UI

 @param controller 当前控制器
 */
+(void)loadingfailureUIWithController:(UIViewController*)controller{
    
    //必须判断否则会崩溃
    if ([controller isKindOfClass:[UIViewController class]]) {
        //在控制器上找到加载中控件，找到了才创建
        UIView * loadView = (UIView*)[controller.view viewWithTag:456672];
        //控件存在才添加
        if (loadView) {
            
            //找到加载失败的view
            UIView * viewFailureFound = (UIView*)[controller.view viewWithTag:456673];
            if (viewFailureFound) {
                [viewFailureFound removeFromSuperview];//移除
            }
            //加载失败父视图
            UIView * viewFailureSub = [[UIView alloc]init];
            viewFailureSub.tag = 456673;
            viewFailureSub.backgroundColor = [UIColor groupTableViewBackgroundColor];
            viewFailureSub.frame =CGRectMake(0, 0, SCREEN_WIDTH, loadView.height);
            [loadView addSubview:viewFailureSub];
            
            //找到父视图icon的控件
            UIImageView * imageViewLodingSub = (UIImageView*)[controller.view viewWithTag:456674];
            //加载中动画
            UIImageView *imageViewLoding = [[UIImageView alloc]init];
            imageViewLoding.image = [UIImage imageNamed:@"加载中icon"];
            [viewFailureSub addSubview:imageViewLoding];
            
            if (imageViewLodingSub.y==loadView.height/2-80) {
                //不用创建返回键
                viewFailureSub.frame =CGRectMake(0, 0, SCREEN_WIDTH, loadView.height);
                 imageViewLoding.frame = imageViewLodingSub.frame;//设置坐标
                
            }else{
                //要创建返回键不能挡住加载中上面创建的返回键--所以坐标重新计算
                viewFailureSub.frame =CGRectMake(0, MC_NavHeight, SCREEN_WIDTH, loadView.height-MC_NavHeight);
                imageViewLoding.frame = CGRectMake(imageViewLodingSub.x, imageViewLodingSub.y-MC_NavHeight, imageViewLodingSub.width, imageViewLodingSub.height);
            }
        
            
            
            //提示
            UILabel *labelInfo = [[UILabel alloc]init];
            labelInfo.frame = CGRectMake(0, imageViewLoding.bottomY+24, SCREEN_WIDTH, 15);
            labelInfo.textAlignment = NSTextAlignmentCenter;
            labelInfo.text =@"网络加载失败，点击重试!";
            labelInfo.textColor = [UIColor colorWithHexString:@"#333333"];
            labelInfo.font = [UIFont systemFontOfSize:12];
            labelInfo.userInteractionEnabled = YES;
            [viewFailureSub addSubview:labelInfo];

        }
        
    }
}


//返回
-(void)pressButtonLeftNew{
    //返回
    [self.controller.navigationController popViewControllerAnimated:YES];
    
    //启动广告的返回（勿删，否则启动广告点击无法返回）
    [self.controller dismissViewControllerAnimated:YES completion:nil];
    
}


//移除加载中-新
+(void)removeLoadingController:(UIViewController*)controller{
    
    //必须判断否则会崩溃
    if ([controller isKindOfClass:[UIViewController class]]) {
        
        UIView * loadView = (UIView*)[controller.view viewWithTag:456672];
        //移除
        [loadView removeFromSuperview];
        
    }else{
        
        //        NSLog(@"不是控制器");
    }
    
}





@end

