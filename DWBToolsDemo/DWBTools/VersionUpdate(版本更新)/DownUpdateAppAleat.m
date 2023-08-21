//
//  DownUpdateAppAleat.m
//  AiHenDeChaoXi
//
//  Created by 爱恨的潮汐 on 2018/6/12.
//  Copyright © 2018年 潮汐科技有限公司. All rights reserved.
//

#import "DownUpdateAppAleat.h"
#import "AFNetworking.h"
@interface DownUpdateAppAleat()
@property (nonatomic, weak) UIView *contentView;

@end

@implementation DownUpdateAppAleat




/**
 检查更新

 @param version 版本号
 @param content 内容
 */
+ (void)downUpdateAppAleatWithVersion:(NSString *)version AndContent:(NSString*)content{

    DownUpdateAppAleat * alertView = [[DownUpdateAppAleat alloc]init];
    //添加 ==不在keyWindow上
    [[UIApplication sharedApplication].keyWindow addSubview:alertView];
    
    //创建UI
    [alertView createUIWithVersion:version AndContent:content];
    
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
- (void)createUIWithVersion:(NSString *)version AndContent:(NSString*)content{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        UIView *contentView = [[UIView alloc]init];
        self.contentView = contentView;
        contentView.backgroundColor = [UIColor whiteColor];
        //拦截点击事件
        contentView.userInteractionEnabled = YES;
        //添加点击手势拦截
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ActionView)];
        [contentView addGestureRecognizer:tap];
        //添加控件
        [self addSubview:contentView];
        
        //布局，不用设置高度
        [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.mas_centerY);
            make.centerX.mas_equalTo(self.mas_centerX);
            make.width.mas_equalTo(296);
        }];
        
        //创建UI
        [self createUITwoWithVersion:version AndContent:content];
    });
}



#pragma mark ========== UI ===============
-(void)createUITwoWithVersion:(NSString *)version AndContent:(NSString*)content{
    
    //创建背景图
    UIImageView * bubbleBackgroundView = [[UIImageView alloc]init];
    bubbleBackgroundView.image = [self resizableImageWithName:@"版本更新背景"];//图片拉升不变形
    [self.contentView addSubview:bubbleBackgroundView];
    
    //关闭按钮
    UIButton * buttonOFF = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonOFF setImage:[UIImage imageNamed:@"版本检测弹窗关闭"] forState:UIControlStateNormal];
    [buttonOFF addTarget:self action:@selector(ActionBackRemoView) forControlEvents:UIControlEventTouchUpInside];
    [_contentView addSubview:buttonOFF];
    [buttonOFF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(44, 44));
    }];
    
    //添加大标题
    UILabel *titleLabel = [UILabel new];
    titleLabel.text = [NSString stringWithFormat:@"最新版本(%@)",version];
    titleLabel.font  = [UIFont boldSystemFontOfSize:17];
    titleLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    titleLabel.numberOfLines = 0;
    titleLabel.textAlignment = NSTextAlignmentLeft;
    [_contentView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(40);
        make.top.mas_equalTo(150);
        make.height.mas_equalTo(24);
    }];
    
    //内容
    UILabel *messageLabel = [UILabel new];
    //行间距
//    @"1、视频信息流连播优化\n2、支持门禁授权功能\n3、其他问题修复"
    messageLabel.attributedText = [NSString getLabelLineSpace:content LineSpacing:8];
    messageLabel.font  = [UIFont systemFontOfSize:14];
    messageLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    messageLabel.numberOfLines = 0;
    messageLabel.textAlignment = NSTextAlignmentLeft;
    [_contentView addSubview:messageLabel];
    [messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleLabel.mas_bottom).mas_equalTo(18);
        make.left.mas_equalTo(40);
        make.right.mas_equalTo(-40);
    }];

    
    //立即升级按钮
    UIButton * buttonBig = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonBig.backgroundColor = MAIN_COLOR;
    [buttonBig setTitle:@"立即升级" forState:UIControlStateNormal];
    buttonBig.titleLabel.font = [UIFont systemFontOfSize:16];
    [buttonBig addTarget:self action:@selector(ActionbuttonBig) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:buttonBig];
    [buttonBig mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(messageLabel.mas_bottom).mas_equalTo(34);
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
        make.width.mas_equalTo(188);
        make.height.mas_equalTo(44);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(-30);
    }];

    //背景图坐标
    WeakSelf(self);
    [bubbleBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(weakself.contentView);
    }];
    //展示动画
    [self showAlertAnimation];
    
}

//图片拉升不变形
- (UIImage *)resizableImageWithName:(NSString *)name{
    
    UIImage *oldImage = [UIImage imageNamed:name];
    //    resizableImageWithCapInsets：设定拉伸范围（让图片距离上左下右有多少范围不拉伸）
    //    resizingMode:表示拉伸的方法。
    CGFloat w = oldImage.size.width * 0.8;
    CGFloat h = oldImage.size.height * 0.8;
    return [oldImage resizableImageWithCapInsets:UIEdgeInsetsMake(h, w, h, w) resizingMode:UIImageResizingModeStretch];
    
}


//立即升级
-(void)ActionbuttonBig{
    //移除
    [self ActionBackRemoView];
    //只需要修改后面的App-Id即可--去appstroe下载
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:AppstoreUrl]];
}


//立即更新按钮点击事件
-(void)btnActionOne{
    //移除弹框
    [self ActionBackRemoView];
  
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
