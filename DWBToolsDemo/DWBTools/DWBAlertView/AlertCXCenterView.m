//
//  AlertCXImageView.m
//  AiHenDeChaoXi
//
//  Created by 爱恨的潮汐 on 2018/4/12.
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
 @param type 类型，-1代表默认，0代表成功；40代表内容文字左对齐
 @param block 回调
 */
+ (void)AlertCXCenterAlertWithController:(UIViewController*)controller Title:(NSString*)title Message:(NSString *)message otherItemArrays:(NSArray *)array Type:(NSInteger)type handler:(ActionBlockAtIndex)block{
    
//   //判断弹窗是否在哪屏幕中，如果不在屏幕中就不要弹窗了--用系统弹窗时不用判断，否则必死
//    if ([UIView isViewAddWindowUp:controller.view]==NO) {
//        //控制器不在屏幕中，不要弹窗了
//        NSLog(@"收到自定义控制器不在屏幕中的弹窗屏幕");
//        return;
//    }
    
    if (array.count>2) {
        NSLog(@"按钮个数必最多只能是2个");
        return;
    }
    if (title.length<=0 && message.length<=0 ) {
        //都为空
        return;
    }
    //不在keyWindow上
    UIView * viewWX = (UIView*)[[UIApplication sharedApplication].keyWindow viewWithTag:131450623];
    
    //控件不存在才创建，防止重复创建
    if (viewWX==nil) {
        AlertCXCenterView * alertView = [[AlertCXCenterView alloc]init];
        alertView.tag = 131450623;
        //添加 ==不在keyWindow上
        [[UIApplication sharedApplication].keyWindow addSubview:alertView];
        //block
        alertView.actionBlockAtIndex = block;
        //弹框宽度
        alertView.widthAlter = 280;
        alertView.type = type;
        
        //判空拦截
        if (title.length<=0) {
            title = @"";
        }
        if (message.length<=0) {
            message = @"";
        }
        if (title.length<=0 && message.length<=0) {
            //没有提示消息
            title = @"";
        }
        //赋值
        alertView.titleText = title;
        alertView.subTitleText = message;
        alertView.array = array;
        alertView.controller = controller;
        //创建UI
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
        self.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.65];
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
        contentView.layer.cornerRadius = 10;
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
    CGSize sizetitle = [NSString sizeMyStrWith:self.titleText andMyFont:[UIFont boldSystemFontOfSize:20] andMineWidth:self.widthAlter-40];
    
    UILabel *titleLabel = [UILabel new];
    titleLabel.text = self.titleText;
    titleLabel.font  = [UIFont boldSystemFontOfSize:20];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.numberOfLines = 1;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [_contentView addSubview:titleLabel];
    
    //副标题
     CGSize sizeSubtitle = [NSString sizeMyHaveSpaceLabelWithMaxWidth:self.widthAlter-40 WithContentStr:self.subTitleText andFont:[UIFont systemFontOfSize:16] andLinespace:5];//有行间距
    UILabel *messageLabel = [UILabel new];
    messageLabel.attributedText = [NSString getLabelLineSpace:self.subTitleText LineSpacing:5];
    messageLabel.font  = [UIFont systemFontOfSize:16];
    messageLabel.textColor = UIColorFromRGB(0x5A5A5A);
    messageLabel.numberOfLines = 0;
    if (self.type==40) {
        //内容左对齐
        messageLabel.textAlignment = NSTextAlignmentLeft;
    }else{
        messageLabel.textAlignment = NSTextAlignmentCenter;
    }
    [_contentView addSubview:messageLabel];

    
#pragma mark ========== 判断类型 =================
    CGFloat contentY;
     if (self.titleText.length>0 && self.subTitleText.length<=0) {
        //只有大标题，没有副标题
         
        titleLabel.frame = CGRectMake(20, 20, self.widthAlter-40, sizetitle.height);
         
        messageLabel.hidden = YES;
         
        contentY = titleLabel.bottomY;
        
    }else if (self.titleText<=0 && self.subTitleText>=0){
        //只有副标题，没有大标题
        titleLabel.hidden = YES;
        //不要加距离
        messageLabel.frame = CGRectMake(20, 20, self.widthAlter-40, sizeSubtitle.height);
        
        contentY = messageLabel.bottomY;
    
    }else{
        
        //大标题和副标题同时存在
        
        titleLabel.frame = CGRectMake(20, 20, self.widthAlter-40, sizetitle.height);
        
        messageLabel.frame = CGRectMake(15, CGRectGetMaxY(titleLabel.frame)+20, self.widthAlter-30, sizeSubtitle.height);
        
        contentY = messageLabel.bottomY;
    }
    
    
    //按钮内容分割线
    UIView *viewLineH = [[UIView alloc]init];
    viewLineH.frame = CGRectMake(0, contentY+20, self.widthAlter, 1);
    viewLineH.backgroundColor =UIColorFromRGB(0xD5D5D5);
    [_contentView addSubview:viewLineH];
    
    
    //只有一个按钮
    if (array.count==1) {
        //按钮
        UIButton *buttonOne = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonOne.frame = CGRectMake((self.widthAlter-self.widthAlter/2)/2, viewLineH.bottomY, self.widthAlter/2,50);
        [buttonOne setTitle:[array firstObject] forState:UIControlStateNormal];
        [buttonOne setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        buttonOne.titleLabel.font = [UIFont systemFontOfSize:16];
        buttonOne.titleLabel.adjustsFontSizeToFitWidth = YES;
        [buttonOne addTarget:self action:@selector(btnActionOne) forControlEvents:UIControlEventTouchUpInside];
        [_contentView addSubview:buttonOne];
        //设置View坐标
        _contentView.width = self.widthAlter;
        _contentView.height = CGRectGetMaxY(buttonOne.frame)+15;
        _contentView.center = self.center;
        
        
    }else{
        //2个按钮
       
        CGFloat buttonWidth = (self.widthAlter-1) / 2;
        //按钮1
        UIButton *buttonOne = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonOne.frame = CGRectMake(0, viewLineH.bottomY, buttonWidth, 50);
        [buttonOne setTitle:[array firstObject] forState:UIControlStateNormal];
        [buttonOne setTitleColor:UIColorFromRGB(0x5A5A5A) forState:UIControlStateNormal];
        buttonOne.titleLabel.font = [UIFont systemFontOfSize:16];
        buttonOne.titleLabel.adjustsFontSizeToFitWidth = YES;
        [buttonOne addTarget:self action:@selector(btnActionOne) forControlEvents:UIControlEventTouchUpInside];
        [_contentView addSubview:buttonOne];
        
        
        //两个按钮中间竖着的分割线
        UIView *viewLineTwo = [[UIView alloc]init];
        viewLineTwo.frame = CGRectMake(buttonOne.rightX, buttonOne.y, 1, 50);
        viewLineTwo.backgroundColor =UIColorFromRGB(0xD5D5D5);
        [_contentView addSubview:viewLineTwo];
        
        //按钮2
        UIButton *buttonTwo = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonTwo.frame = CGRectMake(viewLineTwo.rightX,buttonOne.y, buttonWidth, 50);
        [buttonTwo setTitle:[array lastObject] forState:UIControlStateNormal];
        buttonTwo.titleLabel.font = [UIFont systemFontOfSize:16];
        [buttonTwo setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        buttonTwo.titleLabel.adjustsFontSizeToFitWidth = YES;
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



#pragma mark============系统中间弹窗封装=====================
//系统中间弹窗
+ (void)AlertSystemCXCenterAlertWithTitle:(NSString*)title Message:(NSString *)message otherItemArrays:(NSArray <NSString *>*)array Type:(NSInteger)type handler:(void(^)(NSInteger indexCenter))actionBlock{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    if(type==40){
        //设置内容左对齐
        //UILabel *label1 = [alertVC.view valueForKeyPath:@"_titleLabel"];
        UILabel *labelMessage = [alertController.view valueForKeyPath:@"_messageLabel"];
        labelMessage.textAlignment = NSTextAlignmentLeft;
    }
    
    if(array.count ==1){
        //只有一个按钮
        //确定
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:array.firstObject style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            actionBlock(0);
        }];
        [alertController addAction:okAction];

    }else if (array.count ==2){
        //2个按钮
        //
        UIAlertAction *actionOne = [UIAlertAction actionWithTitle:array.firstObject style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            actionBlock(0);
        }];
        //
        UIAlertAction *actionTwo = [UIAlertAction actionWithTitle:array.lastObject style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            actionBlock(1);
        }];
        
        //kvc修改取消按钮颜色，找到那个按钮是取消
        if([actionOne.title isEqual:@"取消"]){
            [actionOne setValue:[UIColor grayColor] forKey:@"titleTextColor"];
        }
        if([actionTwo.title isEqual:@"取消"]){
            [actionTwo setValue:[UIColor grayColor] forKey:@"titleTextColor"];
        }
        
        [alertController addAction:actionOne];
        [alertController addAction:actionTwo];
    }
//    [UIApplication sharedApplication].keyWindow.rootViewController
    [[UIViewController getCurrentVC] presentViewController:alertController animated:YES completion:nil];
}


@end
