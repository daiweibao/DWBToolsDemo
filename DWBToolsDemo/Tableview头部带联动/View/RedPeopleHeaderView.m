//
//  RedPeopleHeaderView.m
//  DWBToolsDemo
//
//  Created by chaoxi on 2018/11/24.
//  Copyright © 2018 chaoxi科技有限公司. All rights reserved.
//

#import "RedPeopleHeaderView.h"

@interface RedPeopleHeaderView()

@end

@implementation RedPeopleHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}


#pragma mark =============下面开始创建UI===============

-(void)createUI{
    
    UIImageView * imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"lufei.jpg"]];
    imageView.clipsToBounds = YES;
    imageView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 300);
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:imageView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, imageView.bottomY - 30, 200, 30)];
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
