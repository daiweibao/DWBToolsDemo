//
//  DWBAlretCXSheetView.m
//  AiHenDeChaoXi
//
//  Created by chaoxi on 2018/4/20.
//  Copyright © 2018年 chaoxi科技有限公司. All rights reserved.
//

#import "DWBAlretCXSheetView.h"

@interface DWBAlretCXSheetView()
//外部传入的值
@property (nonatomic,strong)UIViewController * controller;//控制器
@property (nonatomic, copy) NSString *titleText;//标题
@property (nonatomic,strong)NSArray * array;//除去取消按钮数组
@property(nonatomic,assign)NSInteger redIndex;//让哪一个按钮变红
@property(nonatomic,assign)BOOL isShow;//是否展示取消按钮
@property (nonatomic, copy) NSString * cancetitle;//取消按钮的标题
@property (nonatomic, assign) NSInteger type;//类型

@property (nonatomic, weak) UIView *contentView;
//弹框宽度
@property (nonatomic, assign) CGFloat widthAlter;
//取消按钮
@property (nonatomic, weak) UIButton * buttonCancel;
@property (nonatomic, strong)UIView *viewBottom;

@end

@implementation DWBAlretCXSheetView

+ (void)AlertMyCXSheetViewWithController:(UIViewController*)controller Title:(NSString*)title otherItemArrays:(NSArray *)array ShowRedindex:(NSInteger )redIndex isShowCancel:(BOOL)isShow CancelTitle:(NSString*)cancetitle Type:(NSInteger)type handler:(ActionBlockAtIndex)block{
    
    //判断弹窗是否在哪屏幕中，如果不在屏幕中就不要弹窗了--用系统弹窗时不用判断，否则必死
    if (type==300) {
        //控制器不在屏幕中也能弹窗
    }else{
        if ([UIView isViewAddWindowUp:controller.view]==NO) {
            //控制器不在屏幕中，不要弹窗了
            NSLog(@"收到自定义控制器不在屏幕中的底部弹窗");
            return;
        }
        
    }
    
    //不在keyWindow上
    UIView * viewWX = (UIView*)[[UIApplication sharedApplication].keyWindow viewWithTag:19920227];
    
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
        DWBAlretCXSheetView * alertView = [[DWBAlretCXSheetView alloc]init];
        alertView.tag = 19920227;
        //添加 ==不在keyWindow上
        [[UIApplication sharedApplication].keyWindow addSubview:alertView];
        
        //    block
        alertView.actionBlockAtIndex = block;
        
        //弹框宽度
        alertView.controller = controller;
        alertView.titleText = title;
        alertView.array = array;
        alertView.redIndex =redIndex;
        alertView.isShow = isShow;
        alertView.cancetitle = cancetitle;
        alertView.type = type;
        
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
        self.backgroundColor=[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.5];
        //开启用户交互
        self.userInteractionEnabled = YES;
        //添加点击手势（拦截点击事件）
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ActionViewSup)];
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
        contentView.backgroundColor = DWBColorHex(@"#F1F1F1");
        //添加点击手势拦截
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ActionView)];
        [contentView addGestureRecognizer:tap];
        //添加控件
        [self addSubview:contentView];
        [contentView setup_Radius:10 corner:UIRectCornerTopLeft|UIRectCornerTopRight];
        //创建UI
        [self createUITwo:array];
    });
}
/// 设置指定圆角【指定边角圆角】
/// @param radius 圆角大小
/// @param corner 圆角指定角
- (void)setup_Radius:(CGFloat)radius corner:(UIRectCorner)corner {
    if (@available(iOS 11.0, *)) {
        self.layer.cornerRadius = radius;
        self.layer.maskedCorners = (CACornerMask)corner;
    } else {
        UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corner cornerRadii:CGSizeMake(radius, radius)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = self.bounds;
        maskLayer.path = path.CGPath;
        self.layer.mask = maskLayer;
    }
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
        titleLabel.frame = CGRectMake(0, 0, self.widthAlter, 51);
    }
    titleLabel.font  = [UIFont boldSystemFontOfSize:15];
    titleLabel.textColor = DWBColorHex(@"#999999");
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [viewSubTitleOther addSubview:titleLabel];
    
    //循环创建按钮和按钮对应的顶部分割线
    CGFloat heighttitleSub = titleLabel.bottomY;
    for (int i = 0; i < array.count; i++) {
        UIButton * buttonOther = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonOther.frame = CGRectMake(0, titleLabel.bottomY + 51 * i, self.widthAlter, 51);
        [buttonOther setTitle:array[i] forState:UIControlStateNormal];
        //按钮变红
        if (i == self.redIndex) {
             [buttonOther setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        }else{
            [buttonOther setTitleColor:DWBColorHex(@"#222222") forState:UIControlStateNormal];
            
        }
        buttonOther.titleLabel.font = [UIFont systemFontOfSize:15];
        buttonOther.tag = 101+i;
        [buttonOther addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [viewSubTitleOther addSubview:buttonOther];
        //线。添加到button上
        UIImageView * imageLine = [[UIImageView alloc]init];
        imageLine.frame = CGRectMake(0, 0, self.widthAlter , 0.5);
        imageLine.backgroundColor = DWBColorHex(@"#F1F1F1");
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
        [buttonCancel setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }else{
        [buttonCancel setTitleColor:DWBColorHex(@"#222222") forState:UIControlStateNormal];
    }
    buttonCancel.titleLabel.font = [UIFont systemFontOfSize:15];
    [buttonCancel addTarget:self action:@selector(ActionViewSup) forControlEvents:UIControlEventTouchUpInside];
    [_contentView addSubview:buttonCancel];
    
    //底部挡板View
    UIView *viewBottom = [[UIView alloc]init];
    self.viewBottom = viewBottom;
    viewBottom.frame = CGRectMake(0, buttonCancel.bottomY, SCREEN_WIDTH, MC_TabbarSafeBottomMargin);
    viewBottom.backgroundColor = [UIColor whiteColor];
    [_contentView addSubview:viewBottom];
    
    //
    
    
    //设置大父视图View的坐标,出现后的坐标，但是一开始藏起来，用动画展示
//    SCREEN_HEIGHT-buttonCancel.bottomY-10 - MC_TabbarSafeBottomMargin
    _contentView.frame = CGRectMake(0, SCREEN_HEIGHT, self.widthAlter, viewBottom.bottomY);
    
    //动画展示坐标
    [UIView animateWithDuration:0.35 animations:^{
        //设置大父视图View的坐标
        _contentView.frame = CGRectMake(0, SCREEN_HEIGHT-viewBottom.bottomY, self.widthAlter, viewBottom.bottomY);
        
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

//点击空白处关闭
- (void)ActionViewSup{
    [UIView animateWithDuration:0.35 animations:^{
        _contentView.frame = CGRectMake(0, SCREEN_HEIGHT, self.widthAlter, self.viewBottom.bottomY);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
