//
//  MyCenterHeaderView.m
//  DWBToolsDemo
//
//  Created by 戴维保 on 2018/11/24.
//  Copyright © 2018 潮汐科技有限公司. All rights reserved.
//

#import "MyCenterHeaderView.h"
@interface MyCenterHeaderView()
@property (nonatomic, strong) UIImageView *imageView;
//下拉放大头部用
@property (nonatomic, assign) CGRect imageViewFrame;
@end
@implementation MyCenterHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)scrollViewDidScroll:(CGFloat)contentOffsetY {
    CGRect frame = self.imageViewFrame;
    frame.size.height -= contentOffsetY;
    frame.origin.y = contentOffsetY;
    self.imageView.frame = frame;
}

#pragma mark =============下面开始创建UI===============

-(void)createUI{
    
    _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"lufei.jpg"]];
    self.imageView.clipsToBounds = YES;
    self.imageView.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.frame.size.height);
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:self.imageView];
    
    self.imageViewFrame = self.imageView.frame;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, self.frame.size.height - 30, 200, 30)];
    label.font = [UIFont systemFontOfSize:20];
    label.text = @"Monkey·D·路飞";
    label.textColor = [UIColor redColor];
    label.userInteractionEnabled = YES;
    [self addSubview:label];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ActionTIn)];
    [label addGestureRecognizer:tap];
    
    NSLog(@"加载了头部");
}

-(void)ActionTIn{
    NSLog(@"点击头部");
}




@end
