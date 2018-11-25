//
//  MYSegmentView.m
//  Kitchen
//
//  Created by su on 16/8/8.
//  Copyright © 2016年 susu. All rights reserved.
//

#import "MYSegmentView.h"


@interface MYSegmentView()

@property (nonatomic,strong)NSMutableArray *hotbuttons;//首页热门按钮（视频分类）

@property (nonatomic,strong)UIScrollView * sc;//这个是副导航的

@end



@implementation MYSegmentView

- (instancetype)initWithFrame:(CGRect)frame controllers:(NSArray *)controllers titleArray:(NSArray *)titleArray ParentController:(UIViewController *)parentC  lineWidth:(float)lineW lineHeight:(float)lineH Type:(NSString *)typeStr{
    if ( self=[super initWithFrame:frame  ]){
        float avgWidth = (frame.size.width/controllers.count);
   
        self.controllers=controllers;
        self.nameArray=titleArray;
        

        if ([typeStr isEqual:@"红人个人中心"]) {
            //标题栏高度
            CGFloat viewHeight = 42;
            
            //父视图
            self.segmentView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, viewHeight)];
            self.segmentView.tag=50;
            [self addSubview:self.segmentView];
            self.segmentScrollV=[[UIScrollView alloc]initWithFrame:CGRectMake(0, viewHeight, frame.size.width, frame.size.height -viewHeight)];
            self.segmentScrollV.contentSize=CGSizeMake(frame.size.width*self.controllers.count, 0);
            self.segmentScrollV.delegate=self;
            self.segmentScrollV.showsHorizontalScrollIndicator=NO;
            self.segmentScrollV.pagingEnabled=YES;
            self.segmentScrollV.bounces=NO;
            [self addSubview:self.segmentScrollV];
            
            for (int i=0;i<self.controllers.count;i++)
            {
                UIViewController * contr=self.controllers[i];
                [self.segmentScrollV addSubview:contr.view];
                contr.view.frame=CGRectMake(i*frame.size.width, 0, frame.size.width,frame.size.height);
                [parentC addChildViewController:contr];
                [contr didMoveToParentViewController:parentC];
            }
            
            
            for (int i=0;i<self.controllers.count;i++)
            {
                
                
                //汉字按钮
                UIButton * btn=[ UIButton buttonWithType:UIButtonTypeCustom];
                btn.frame=CGRectMake(i*(frame.size.width/self.controllers.count), 0, frame.size.width/self.controllers.count, viewHeight);
                btn.tag=i;
                [btn setTitle:self.nameArray[i] forState:(UIControlStateNormal)];
                [btn setTitleColor:[UIColor colorWithHexString:@"696969"] forState:(UIControlStateNormal)];
                [btn setTitleColor:MAIN_COLOR forState:(UIControlStateSelected)];
                [btn addTarget:self action:@selector(Click:) forControlEvents:(UIControlEventTouchUpInside)];
                btn.titleLabel.font=[UIFont systemFontOfSize:16];
                //默认选中
                if (i==0){
                    
                    btn.selected=YES ;
                    self.seleBtn=btn;
                    btn.titleLabel.font=[UIFont systemFontOfSize:16];
                    
                } else {
                    
                    btn.selected=NO;
                    
                }
                [self.segmentView addSubview:btn];
            }
            
            
            //汉字下面的线
            self.line=[[UIImageView alloc]initWithFrame:CGRectMake((avgWidth-lineW)/2,viewHeight-lineH-1, lineW, lineH)];
            //            self.line.image = [UIImage imageNamed:@"滚动条红色标签"];
            self.line.backgroundColor = MAIN_COLOR;
            self.line.tag=100;
            [self.segmentView addSubview:self.line];
            
            //最下面那条线
            self.down=[[UILabel alloc]initWithFrame:CGRectMake(0, viewHeight-1, frame.size.width, 1)];
            self.down.backgroundColor = [UIColor groupTableViewBackgroundColor];
            [self.segmentView addSubview:self.down];
            //            //阴影
            //            self.down.layer.shadowColor = [UIColor grayColor].CGColor;//shadowColor阴影颜色
            //            self.down.layer.shadowOffset = CGSizeMake(2,0);//shadowOffset阴影偏移，默认(0, -3),这个跟shadowRadius配合使用
            //            self.down.layer.shadowOpacity = 0.6;//阴影透明度，默认0
            //            self.down.layer.shadowRadius = 2;//阴影半径，默认3
    
        }else{
        //其他地方的在这里分支
            
        }
    }

    return self;
}


- (void)Click:(UIButton*)sender{
    self.seleBtn.titleLabel.font= [UIFont systemFontOfSize:17.];;
    self.seleBtn.selected=NO;
    self.seleBtn=sender;
    self.seleBtn.selected=YES;
    self.seleBtn.titleLabel.font= [UIFont systemFontOfSize:17.];;
    [UIView animateWithDuration:0.2 animations:^{
        CGPoint  frame=self.line.center;
        frame.x=self.frame.size.width/(self.controllers.count*2) +(self.frame.size.width/self.controllers.count)* (sender.tag);
        self.line.center=frame;
    }];
    [self.segmentScrollV setContentOffset:CGPointMake((sender.tag)*self.frame.size.width, 0) animated:YES ];
}

//我的美币界面（dianji）
- (void)Click1:(UIButton*)sender{
    self.seleBtn.titleLabel.font= [UIFont systemFontOfSize:14.];;
    self.seleBtn.selected=NO;
    self.seleBtn=sender;
    self.seleBtn.selected=YES;
    self.seleBtn.titleLabel.font= [UIFont systemFontOfSize:14.];;
    [UIView animateWithDuration:0.2 animations:^{
        CGPoint  frame=self.line.center;
        frame.x=self.frame.size.width/(self.controllers.count*2) +(self.frame.size.width/self.controllers.count)* (sender.tag);
        self.line.center=frame;
    }];
    [self.segmentScrollV setContentOffset:CGPointMake((sender.tag)*self.frame.size.width, 0) animated:YES ];

}

//工坊界面
- (void)hotClick1:(UIButton*)sender{
    
    self.seleBtn.selected=NO;
    self.seleBtn=sender;
    self.seleBtn.selected=YES;
    
    if (sender.tag == 0) {
        [UIView animateWithDuration:0.2 animations:^{
            
            self.line.frame=CGRectMake(SCREEN_WIDTH/2-65,40-2, 65, 2);
        }];
    }else{
        [UIView animateWithDuration:0.2 animations:^{
            
            self.line.frame=CGRectMake(SCREEN_WIDTH/2,40-2, 65, 2);
        }];
    }
    
    [self.segmentScrollV setContentOffset:CGPointMake((sender.tag)*self.frame.size.width, 0) animated:YES ];
    
}

//手动滚动键盘走这个方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
   
    //首页热门的滚动父试图
    if (scrollView.tag == 201754) {
//        NSLog(@"%f",scrollView.contentOffset.x);
        
        int n = scrollView.contentOffset.x / SCREEN_WIDTH;
        for (int i=0;i<self.hotbuttons.count;i++) {
            UIImageView *obj = self.hotbuttons[i];
            if (n==i) {
                obj.alpha = 1;
            }else{
                obj.alpha = 0.5;
            }
            
        }
        
        CGFloat w = 60;//每个cell宽度
        CGFloat space = (SCREEN_WIDTH-30-w*4)/3;
        
        if (n>=4) {
            
            [self.sc setContentOffset:CGPointMake((w+space)*(n-3), 0) animated:YES];
        }else{
        
            [self.sc setContentOffset:CGPointMake(0, 0) animated:YES];
        }
        
        return;
    }
    
    //首页热门的视频分类滚动条
    if (scrollView.tag == 201754+1) {
        
        return;
    }
    
    //工坊界面
    if (scrollView.tag == 20170516) {
        
        if (self.segmentScrollV.contentOffset.x/self.frame.size.width == 0) {
            
            [UIView animateWithDuration:0.2 animations:^{
                
                self.line.frame=CGRectMake(SCREEN_WIDTH/2-65,40-2, 65, 2);
            }];
        }else{
            [UIView animateWithDuration:0.2 animations:^{
                
                self.line.frame=CGRectMake(SCREEN_WIDTH/2,40-2, 65, 2);
            }];
        }
        
    
        UIButton * btn=(UIButton*)[self.segmentView viewWithTag:(self.segmentScrollV.contentOffset.x/self.frame.size.width)];
        self.seleBtn.selected=NO;
        self.seleBtn=btn;
        self.seleBtn.selected=YES;
        
        return;
    }
    
    
    //这里是控制付费课程目录一行按钮显示颜色
    if (scrollView.contentOffset.x == SCREEN_WIDTH){
        [[NSNotificationCenter defaultCenter] postNotificationName:@"changePayColor" object:@"1"];
    
    }else if (scrollView.contentOffset.x == SCREEN_WIDTH*2){
         [[NSNotificationCenter defaultCenter] postNotificationName:@"changePayColor" object:@"2"];
        
    }else{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"changePayColor" object:@"0"];
    }
    
    
    [UIView animateWithDuration:0.2 animations:^{
        CGPoint  frame=self.line.center;
        frame.x=self.frame.size.width/(self.controllers.count*2) +(self.frame.size.width/self.controllers.count)*(self.segmentScrollV.contentOffset.x/self.frame.size.width);
        self.line.center=frame;
    }];
    
    UIButton * btn=(UIButton*)[self.segmentView viewWithTag:(self.segmentScrollV.contentOffset.x/self.frame.size.width)];
    self.seleBtn.selected=NO;
    self.seleBtn=btn;
    self.seleBtn.selected=YES;
}


//目录一行按钮颜色  改变控制器
-(void)changePayController : (NSNotification *)notification{
    
    NSInteger num = [notification.object integerValue];
    
    [self.segmentScrollV setContentOffset:CGPointMake(num*self.frame.size.width, 0) animated:YES ];
}

- (NSMutableArray *)hotbuttons{

    if (_hotbuttons == nil) {
        _hotbuttons = [NSMutableArray array];
    }
    return _hotbuttons;
}


@end
