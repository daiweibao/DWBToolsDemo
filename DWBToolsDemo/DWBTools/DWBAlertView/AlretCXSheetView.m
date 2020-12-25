//
//  AlretCXSheetView.m
//  AiHenDeChaoXi
//
//  Created by chaoxi on 2018/4/20.
//  Copyright © 2018年 chaoxi科技有限公司. All rights reserved.
//

#import "AlretCXSheetView.h"

@interface AlretCXSheetView()
@property (nonatomic, weak) UIView *contentView;
//弹框宽度
@property (nonatomic, assign) CGFloat widthAlter;
//取消按钮
@property (nonatomic, weak) UIButton * buttonCancel;

@end

@implementation AlretCXSheetView

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
        
        //控件宽度
         self.widthAlter = SCREEN_WIDTH;
        
        //关键盘
        [[UIApplication sharedApplication].keyWindow endEditing:YES];
        
    }
    return self;
}


//创建UI
- (void)setUpContentViewAray:(NSArray*)array{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        UIView *contentView = [[UIView alloc]init];
        self.contentView = contentView;
        //拦截点击事件
        contentView.clipsToBounds = YES;
        contentView.userInteractionEnabled = YES;
        contentView.backgroundColor = [UIColor groupTableViewBackgroundColor];
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
    //创建UI添加到父视图上

    //创建标题和其他按钮的父视图
    UIView * viewSubTitleOther = [[UIView alloc]init];
    viewSubTitleOther.backgroundColor = [UIColor whiteColor];
    [_contentView addSubview:viewSubTitleOther];
    

    //添加标题
    UILabel *titleLabel = [[UILabel alloc]init];
    if ([NSString isNULL:self.titleText]) {
        titleLabel.text = @"";
        titleLabel.frame = CGRectMake(0, 0, self.widthAlter, 0);
    }else{
        titleLabel.text = self.titleText;
        titleLabel.frame = CGRectMake(0, 0, self.widthAlter, 44);
    }
    titleLabel.font  = [UIFont boldSystemFontOfSize:12];
    titleLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [viewSubTitleOther addSubview:titleLabel];
    
    //循环创建按钮和按钮对应的顶部分割线
    CGFloat heighttitleSub = titleLabel.bottomY;
    for (int i = 0; i < array.count; i++) {
        UIButton * buttonOther = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonOther.frame = CGRectMake(0, titleLabel.bottomY + 44 * i, self.widthAlter, 44);
        [buttonOther setTitle:array[i] forState:UIControlStateNormal];
        //按钮变红
        if (i == self.redIndex) {
             [buttonOther setTitleColor:MAIN_COLOR forState:UIControlStateNormal];
        }else{
            [buttonOther setTitleColor:MAIN_COLOR forState:UIControlStateNormal];
            
        }
        buttonOther.titleLabel.font = [UIFont systemFontOfSize:14];
        buttonOther.tag = 101+i;
        [buttonOther addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [viewSubTitleOther addSubview:buttonOther];
        //线。添加到button上
        UIImageView * imageLine = [[UIImageView alloc]init];
        imageLine.frame = CGRectMake(0, 0, self.widthAlter , 1);
        imageLine.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [buttonOther addSubview:imageLine];
        
        heighttitleSub = buttonOther.bottomY;
    }
    
    //重置标题和其他按钮父视图坐标
     viewSubTitleOther.frame = CGRectMake(0, 0, self.widthAlter, heighttitleSub);
    
    
    //创建取消按钮,数据单独传入，不存在数组里了
    UIButton * buttonCancel = [UIButton buttonWithType:UIButtonTypeCustom];
    self.buttonCancel = buttonCancel;
      buttonCancel.tag = 101+array.count;
    if (self.isShow==YES) {
        buttonCancel.frame = CGRectMake(0, viewSubTitleOther.bottomY + 10, self.widthAlter, 44);
        [buttonCancel setTitle:self.cancetitle forState:UIControlStateNormal];
    }else{
       buttonCancel.frame = CGRectMake(0, viewSubTitleOther.bottomY, self.widthAlter, 0);
       [buttonCancel setTitle:@"" forState:UIControlStateNormal];
    }
    buttonCancel.backgroundColor = [UIColor whiteColor];
    if (array.count == self.redIndex) {
        [buttonCancel setTitleColor:MAIN_COLOR forState:UIControlStateNormal];
    }else{
        [buttonCancel setTitleColor:MAIN_COLOR forState:UIControlStateNormal];
    }
    buttonCancel.titleLabel.font = [UIFont systemFontOfSize:16];
    [buttonCancel addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_contentView addSubview:buttonCancel];
    
    
    //设置大父视图View的坐标,出现后的坐标，但是一开始藏起来，用动画展示
//    SCREEN_HEIGHT-buttonCancel.bottomY-10 - MC_TabbarSafeBottomMargin
    _contentView.frame = CGRectMake(0, SCREEN_HEIGHT, self.widthAlter, buttonCancel.bottomY);
    
    //动画展示坐标
    [UIView animateWithDuration:0.35 animations:^{
        //设置大父视图View的坐标
        _contentView.frame = CGRectMake(0, SCREEN_HEIGHT-buttonCancel.bottomY - MC_TabbarSafeBottomMargin, self.widthAlter, buttonCancel.bottomY);
        
    }];
}


//按钮点击事件
-(void)buttonAction:(UIButton *)button{
    //移除弹框
    [self ActionBackRemoView];
    //回调按钮点击标记
    if (self.actionBlockAtIndex) {
        self.actionBlockAtIndex(button.tag-101);
    }
    
}

//点击移除view(动画少点，否则会造成两个弹窗弹不出来)默认0.2
-(void)ActionBackRemoView{
    //直接移除，不要动画
    [self removeFromSuperview];
    
//    [UIView animateWithDuration:0.35 animations:^{
//        _contentView.frame = CGRectMake(20.0*px, SCREEN_HEIGHT, self.widthAlter, _buttonCancel.bottomY);
//    } completion:^(BOOL finished) {
//
//        [self removeFromSuperview];
//    }];
}


-(void)ActionView{
    //移除
    [self ActionBackRemoView];
}


@end
