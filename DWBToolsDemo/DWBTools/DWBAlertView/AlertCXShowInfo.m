//
//  CXShowInfoView.m
//  AiHenDeChaoXi
//
//  Created by chaoxi on 2018/4/20.
//  Copyright © 2018年 chaoxi科技有限公司. All rights reserved.
//

#import "AlertCXShowInfo.h"

@interface AlertCXShowInfo()

@property (nonatomic, weak) UIView *contentView;
//弹框宽度
@property (nonatomic, assign) CGFloat widthAlter;
//类型
@property (nonatomic, assign) NSInteger type;
//标题和副标题
@property (nonatomic, copy) NSString *titleText;
@property (nonatomic, copy) NSString *subTitleText;

@end

@implementation AlertCXShowInfo

/**
 自定义带图标的弹窗，弹窗后2s自动消失
 
 @param title 标题
 @param message 内容
 @param type 类型，成功还是失败，用来控制图标 -1为默认
 */
+ (void)showAletCXInfoTitle:(NSString*)title Message:(NSString *)message Type:(NSInteger)type{
    
    //不在keyWindow上
    UIView * viewWX = (UIView*)[[UIApplication sharedApplication].keyWindow viewWithTag:19920228];
    //移除弹框
    [viewWX removeFromSuperview];
  
   //创建
    AlertCXShowInfo * alertView = [[AlertCXShowInfo alloc]init];
    alertView.tag = 131450623;
    //添加 ==不在keyWindow上
    [[UIApplication sharedApplication].keyWindow addSubview:alertView];
    //弹框宽度
    alertView.widthAlter = 240;
    
    alertView.type = type;
    
    //判空拦截
    if ([NSString isNULL:title]) {
        title = nil;
    }
    if ([NSString isNULL:message]) {
        message = nil;
    }
    
    if ([NSString isNULL:title]&&[NSString isNULL:message]) {
        
        title = @"抱歉，出错了~😂";
    }
    //赋值
    alertView.titleText = title;
    alertView.subTitleText = message;
    //创建UI
    [alertView setUpContentView];
    
}


//init
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        //设置蒙版层背景色
        self.backgroundColor=[UIColor colorWithRed:129/255.0 green:129/255.0 blue:129/255.0 alpha:0.7];
        //关闭用户交互
        self.userInteractionEnabled = NO;
    }
    return self;
}

//创建UI
- (void)setUpContentView{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        UIView *contentView = [[UIView alloc]init];
        self.contentView = contentView;
        contentView.backgroundColor = [UIColor whiteColor];
        contentView.layer.masksToBounds = YES;
        contentView.layer.cornerRadius =5;
        //拦截点击事件
        contentView.clipsToBounds = YES;
        contentView.userInteractionEnabled = NO;
        //添加控件
        [self addSubview:contentView];
        
        //创建UI
        [self createUI];
    });
}


#pragma mark ========== UI ===============
-(void)createUI{
    //添加icon
    UIButton * buttonIcon = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonIcon.frame = CGRectMake(self.widthAlter/2-15, 10, 30, 30);
    //在这里判断成功还是失败
    [buttonIcon setImage:[UIImage imageNamed:@"无按钮提示框成功"] forState:UIControlStateNormal];
    [_contentView addSubview:buttonIcon];
    
    //添加大标题
    CGSize sizetitle = [self.titleText boundingRectWithSize:CGSizeMake(self.widthAlter-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:14]} context:nil].size;
    UILabel *titleLabel = [UILabel new];
    titleLabel.text = self.titleText;
    titleLabel.frame = CGRectMake(15, buttonIcon.bottomY+6, self.widthAlter-30, sizetitle.height);
    titleLabel.font  = [UIFont boldSystemFontOfSize:14];
    titleLabel.textColor = MAIN_COLOR;
    titleLabel.numberOfLines = 0;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [_contentView addSubview:titleLabel];
    
    //副标题
    CGSize sizeSubtitle = [self.subTitleText boundingRectWithSize:CGSizeMake(self.widthAlter-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    UILabel *messageLabel = [UILabel new];
    messageLabel.text = self.subTitleText;
    //如果大标题和小标题中的任何一个不存在就走这里
    if (self.subTitleText.length==0||self.titleText.length==0) {
        //不要加距离
        messageLabel.frame = CGRectMake(15, CGRectGetMaxY(titleLabel.frame), self.widthAlter-30, sizeSubtitle.height);
        
    }else{
        //加距离
        messageLabel.frame = CGRectMake(15, CGRectGetMaxY(titleLabel.frame)+10, self.widthAlter-30, sizeSubtitle.height);
        
    }
    
    messageLabel.font  = [UIFont systemFontOfSize:12];
    messageLabel.textColor = [UIColor colorWithHexString:@"#999999"];
    messageLabel.numberOfLines = 0;
    messageLabel.textAlignment = NSTextAlignmentCenter;
    [_contentView addSubview:messageLabel];
    
    //设置View坐标
    _contentView.width = self.widthAlter;
    _contentView.height = messageLabel.bottomY+15;
    _contentView.center = self.center;
    
    
    //2秒后自动移除
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //控件动画影藏
        [self removeFromSuperview];
    });
 
}

@end
