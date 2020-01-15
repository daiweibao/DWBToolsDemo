//
//  AlertCXImageView.m
//  AiHenDeChaoXi
//
//  Created by 戴维保 on 2018/4/12.
//  Copyright © 2018年 潮汐科技有限公司. All rights reserved.
//

#import "AlertCXCenterView.h"

@interface AlertCXCenterView()
@property (nonatomic, weak) UIView *contentView;
//弹框宽度
@property (nonatomic, assign) CGFloat widthAlter;
//类型
@property (nonatomic, assign) NSInteger type;

//标题和副标题
@property (nonatomic, copy) NSString *titleText;
@property (nonatomic, copy) NSString *subTitleText;
@property (nonatomic,strong)NSArray * array;
@property (nonatomic,strong)UIViewController * controller;


@end

@implementation AlertCXCenterView

/**
 自己封装的aleat
 
 @param controller 弹窗所在控制器
 @param title 标题
 @param message 内容
 @param array 按钮
 @param type 类型，0代表成功（默认成功） 1代表失败 100代表允许重复弹窗 ,200代表允许移除老的弹窗，展示新的弹窗（推送用）
 @param block 回调
 */
+ (void)AlertCXCenterAlertWithController:(UIViewController*)controller Title:(NSString*)title Message:(NSString *)message otherItemArrays:(NSArray *)array Type:(NSInteger)type handler:(ActionBlockAtIndex)block{
    
   //判断弹窗是否在哪屏幕中，如果不在屏幕中就不要弹窗了--用系统弹窗时不用判断，否则必死
    if ([UIView isViewAddWindowUp:controller.view]==NO) {
        //控制器不在屏幕中，不要弹窗了
        NSLog(@"收到自定义控制器不在屏幕中的弹窗屏幕");
        return;
    }
    
    if (array.count>2) {
        NSLog(@"按钮个数必最多只能是2个");
        return;
    }
    
    //不在keyWindow上
    UIView * viewWX = (UIView*)[[UIApplication sharedApplication].keyWindow viewWithTag:131450623];
    
    if (type==100) {
        //推送可以重复弹窗,设置成nil
        viewWX =nil;
    }
    
    if (type==200 && viewWX != nil) {
        //移除上次创建的弹框，显示最新弹框
        //移除弹框
        [viewWX removeFromSuperview];
        viewWX =nil;
    }
    
    //控件不存在才创建，防止重复创建
    if (viewWX==nil) {
        AlertCXCenterView * alertView = [[AlertCXCenterView alloc]init];
        alertView.tag = 131450623;
        //添加 ==不在keyWindow上
        [[UIApplication sharedApplication].keyWindow addSubview:alertView];
        
        //    block
        alertView.actionBlockAtIndex = block;
        
        //弹框宽度
        alertView.widthAlter = 296;
        
        alertView.type = type;
        
        //判空拦截
        if ([title isEqual:@""]||[NSString isNULL:title]) {
            title = nil;
        }
        if ([message isEqual:@""]||[NSString isNULL:message]) {
            message = nil;
        }
        
        if ([NSString isNULL:title]&&[NSString isNULL:message]) {
            //没有提示消息
            title = @"null😂";
        }
        //赋值
        alertView.titleText = title;
        alertView.subTitleText = message;
        alertView.array = array;
        alertView.controller = controller;
        //    创建UI
        [alertView setUpContentViewAray:array];
    }
    
}


//init
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        //设置蒙版层背景色
        self.backgroundColor=[UIColor colorWithRed:129/255.0 green:129/255.0 blue:129/255.0 alpha:0.7];
        //开启用户交互
        self.userInteractionEnabled = YES;
        //添加点击手势（拦截点击事件）
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ActionView)];
        [self addGestureRecognizer:tap];

        //关键盘
        [[UIApplication sharedApplication].keyWindow endEditing:YES];
        
    }
    return self;
}


//点击移除view(动画少点，否则会造成两个弹窗弹不出来)默认0.2
-(void)ActionBackRemoView{
    //移除动画
    [self dismissAlertAnimation];
    //控件动画影藏
     self.alpha = 0;
     _contentView.alpha = 0;
    [self removeFromSuperview];
}

//创建UI
- (void)setUpContentViewAray:(NSArray*)array{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        UIView *contentView = [[UIView alloc]init];
        self.contentView = contentView;
        contentView.backgroundColor = [UIColor whiteColor];
        //拦截点击事件
        contentView.clipsToBounds = YES;
        contentView.userInteractionEnabled = YES;
        //添加点击手势拦截
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ActionView)];
        [contentView addGestureRecognizer:tap];
        //添加控件
        [self addSubview:contentView];
        
        //创建UI
        [self createUITwo:array];
    });
}



#pragma mark ========== UI ===============
-(void)createUITwo:(NSArray*)array{
    if (array.count>2) {
        NSLog(@"按钮个数必最多只能是2个");
        return;
    }
    
    //添加大标题
    CGSize sizetitle = [NSString sizeMyStrWith:self.titleText andMyFont:[UIFont boldSystemFontOfSize:17] andMineWidth:self.widthAlter-30];
    
    UILabel *titleLabel = [UILabel new];
    titleLabel.text = self.titleText;
    titleLabel.font  = [UIFont boldSystemFontOfSize:17];
    titleLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    titleLabel.numberOfLines = 0;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [_contentView addSubview:titleLabel];
    
    //副标题
     CGSize sizeSubtitle = [NSString sizeMyStrWith:self.subTitleText andMyFont:[UIFont systemFontOfSize:12] andMineWidth:self.widthAlter-30];
    UILabel *messageLabel = [UILabel new];
    messageLabel.text = self.subTitleText;
    messageLabel.font  = [UIFont systemFontOfSize:12];
    messageLabel.textColor = [UIColor colorWithHexString:@"#999999"];
    messageLabel.numberOfLines = 0;
    messageLabel.textAlignment = NSTextAlignmentCenter;
    [_contentView addSubview:messageLabel];
    
    
    //创建分割线
    UIImageView * imageViewLine = [[UIImageView alloc]init];
    imageViewLine.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [_contentView addSubview:imageViewLine];
    
    
    
#pragma mark ========== 判断类型 =================
    
     if ([NSString isNULL:self.titleText]==NO && [NSString isNULL:self.subTitleText]==YES) {
        //只有大标题，没有副标题
         
        titleLabel.frame = CGRectMake(15, 32, self.widthAlter-30, sizetitle.height);
         
        messageLabel.hidden = YES;
        //分割线坐标
        imageViewLine.frame = CGRectMake(0, titleLabel.bottomY+32, self.widthAlter, 1);
        
        
    }else if ([NSString isNULL:self.titleText]==YES && [NSString isNULL:self.subTitleText]==NO){
        //只有副标题，没有大标题
        titleLabel.hidden = YES;
        //不要加距离
        messageLabel.frame = CGRectMake(15, 32, self.widthAlter-30, sizeSubtitle.height);
        //分割线坐标
        imageViewLine.frame = CGRectMake(0, messageLabel.bottomY+32, self.widthAlter, 1);
    
    }else{
        
        //大标题和副标题同时存在
        
        titleLabel.frame = CGRectMake(15, 32, self.widthAlter-30, sizetitle.height);
        
        messageLabel.frame = CGRectMake(15, CGRectGetMaxY(titleLabel.frame)+10, self.widthAlter-30, sizeSubtitle.height);
        //分割线坐标
        imageViewLine.frame = CGRectMake(0, messageLabel.bottomY+32, self.widthAlter, 1);
    }
    
    
    
    //只有一个按钮
    if (array.count==1) {
        //按钮
        UIButton *buttonOne = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonOne.frame = CGRectMake(0, imageViewLine.bottomY, self.widthAlter, 50);
        [buttonOne setTitle:[array firstObject] forState:UIControlStateNormal];
        [buttonOne setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        buttonOne.titleLabel.font = [UIFont systemFontOfSize:14];
        [buttonOne setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
        [buttonOne addTarget:self action:@selector(btnActionOne) forControlEvents:UIControlEventTouchUpInside];
        [_contentView addSubview:buttonOne];
        
        //设置View坐标
        _contentView.width = self.widthAlter;
        _contentView.height = CGRectGetMaxY(buttonOne.frame);
        _contentView.center = self.center;
        
        
    }else{
        //2个按钮
        //按钮1
        CGFloat buttonWidth = self.widthAlter/2;
        UIButton *buttonOne = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonOne.frame = CGRectMake(0, imageViewLine.bottomY, buttonWidth-0.5, 50);
        [buttonOne setTitle:[array firstObject] forState:UIControlStateNormal];
        [buttonOne setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
        buttonOne.titleLabel.font = [UIFont systemFontOfSize:14];
        [buttonOne addTarget:self action:@selector(btnActionOne) forControlEvents:UIControlEventTouchUpInside];
        [_contentView addSubview:buttonOne];
        
        
        //创建一条分割线
        UIImageView * imageLineShu = [[UIImageView alloc]init];
        imageLineShu.frame = CGRectMake(self.widthAlter/2-0.5, imageViewLine.bottomY, 1, 50);
        imageLineShu.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [_contentView addSubview:imageLineShu];
        
        
        //按钮2
        UIButton *buttonTwo = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonTwo.frame = CGRectMake(buttonOne.rightX+1, imageViewLine.bottomY, buttonWidth, 50);
        [buttonTwo setTitle:[array lastObject] forState:UIControlStateNormal];
        buttonTwo.titleLabel.font = [UIFont systemFontOfSize:14];
        [buttonTwo setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
        [buttonTwo addTarget:self action:@selector(btnActionTwo) forControlEvents:UIControlEventTouchUpInside];
        [_contentView addSubview:buttonTwo];
        
        
        //设置View坐标
        _contentView.width = self.widthAlter;
        _contentView.height = CGRectGetMaxY(buttonTwo.frame);
        _contentView.center = self.center;
        
    }
    
    //展示动画
    [self showAlertAnimation];
    
}


//按钮1点击事件
-(void)btnActionOne{
    //移除弹框
    [self ActionBackRemoView];
    //回调按钮点击标记
    if (self.actionBlockAtIndex) {
        self.actionBlockAtIndex(0);
    }
    
}

//按钮2点击事件
-(void)btnActionTwo{
    //移除弹框
    [self ActionBackRemoView];
    //回调按钮点击标记
    if (self.actionBlockAtIndex) {
        self.actionBlockAtIndex(1);
    }
}

-(void)ActionView{
    //什么也不干，拦截点击事件
}

//展示动画
- (void)showAlertAnimation {
    //弹出动画，不带弹簧
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    
    animation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1)],
                         [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.05, 1.05, 1)],
                         [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1)]];
    animation.keyTimes = @[ @0, @0.5, @1 ];
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    animation.duration = .3;
    
    [_contentView.layer addAnimation:animation forKey:@"showAlert"];
    
}
//移除动画
- (void)dismissAlertAnimation {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    
    animation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1)],
                         [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.95, 0.95, 1)],
                         [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.8, 0.8, 1)]];
    animation.keyTimes = @[ @0, @0.5, @1 ];
    animation.fillMode = kCAFillModeRemoved;
    animation.duration = 0.01;
    
    [_contentView.layer addAnimation:animation forKey:@"dismissAlert"];
}


@end
