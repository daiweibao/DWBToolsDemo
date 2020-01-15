//
//  MJDIYLoadingHeader.m
//  AiHenDeChaoXi
//
//  Created by 戴维保 on 2018/7/6.
//  Copyright © 2018年 潮汐科技有限公司. All rights reserved.
//

#import "MJDIYLoadingHeader.h"

@interface MJDIYLoadingHeader()

//动画
@property(nonatomic,weak) CABasicAnimation *animation;
//动画
@property(nonatomic,weak) UIImageView * imageViewGif;

@end

@implementation MJDIYLoadingHeader

#pragma mark - 重写方法
#pragma mark 在这里做一些初始化配置（比如添加子控件）
- (void)prepare
{
    [super prepare];
    
    // 设置控件的高度（默认54）
    self.mj_h = 54;
    
    //创建UI
    UIImageView * imageViewGif = [[UIImageView alloc]init];
    self.imageViewGif = imageViewGif;
    //没有动画时默认显示图
    imageViewGif.image = [UIImage imageNamed:@"上拉加载中"];
    [self addSubview:imageViewGif];
    
    //让图片一直旋转
    CABasicAnimation *animation =  [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    self.animation = animation;
    //默认是顺时针效果，若将fromValue和toValue的值互换，则为逆时针效果
    animation.fromValue = [NSNumber numberWithFloat:0.f];
    animation.toValue =  [NSNumber numberWithFloat: M_PI *2];
    animation.duration  = 1;
    animation.autoreverses = NO;
    animation.removedOnCompletion = NO;//默认YES，设置成NO保证按home键回来后UIApplicationDidBecomeActiveNotification继续通知接听后动画
    animation.fillMode =kCAFillModeForwards;
    animation.repeatCount = MAXFLOAT; //如果这里想设置成一直自旋转，可以设置为MAXFLOAT，否则设置具体的数值则代表执行多少次
    [self.imageViewGif.layer addAnimation:animation forKey:nil];
    
    //程序从后台启动时
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(doAnimation:) name:UIApplicationDidBecomeActiveNotification object:nil];
}

//实现自定义的方法doAnimation:，再次方法中添加动画
- (void)doAnimation:(NSNotification *)notify{
    //再次开始动画
    self.animation.removedOnCompletion = NO;
}

#pragma mark 在这里设置子控件的位置和尺寸
- (void)placeSubviews
{
    [super placeSubviews];
    
    //普通手机普通界面
    self.mj_h = 54;
    //图片坐标
    self.imageViewGif.frame =  CGRectMake(SCREEN_WIDTH/2.0-12.5, 15, 25, 25);
}


#pragma mark - 动画效果

//暂停动画
- (void)pauseAnimation {
    //（0-5）
    //开始时间：0
    //    myView.layer.beginTime
    //1.取出当前时间，转成动画暂停的时间
    CFTimeInterval pauseTime = [_imageViewGif.layer convertTime:CACurrentMediaTime() fromLayer:nil];
    
    //2.设置动画的时间偏移量，指定时间偏移量的目的是让动画定格在该时间点的位置
    _imageViewGif.layer.timeOffset = pauseTime;
    
    //3.将动画的运行速度设置为0， 默认的运行速度是1.0
    _imageViewGif.layer.speed = 0;
    
}

//恢复动画
- (void)resumeAnimation {
    //1.将动画的时间偏移量作为暂停的时间点
    CFTimeInterval pauseTime = _imageViewGif.layer.timeOffset;
    //2.计算出开始时间
    CFTimeInterval begin = CACurrentMediaTime() - pauseTime;
    
    [_imageViewGif.layer setTimeOffset:0];
    [_imageViewGif.layer setBeginTime:begin];
    
    _imageViewGif.layer.speed = 1;
}



#pragma mark 监听scrollView的contentOffset改变
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    [super scrollViewContentOffsetDidChange:change];
    
}

#pragma mark 监听scrollView的contentSize改变
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change
{
    [super scrollViewContentSizeDidChange:change];
    
}

#pragma mark 监听scrollView的拖拽状态改变
- (void)scrollViewPanStateDidChange:(NSDictionary *)change
{
    [super scrollViewPanStateDidChange:change];
    
}

#pragma mark 监听控件的刷新状态
- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState;
    
    switch (state) {
        case MJRefreshStateIdle:
            //恢复动画
            [self resumeAnimation];
            break;
        case MJRefreshStatePulling:
            break;
        case MJRefreshStateRefreshing:
            break;
        default:
            break;
    }
}

#pragma mark 监听拖拽比例（控件被拖出来的比例--暂时不修改）
- (void)setPullingPercent:(CGFloat)pullingPercent
{
    [super setPullingPercent:pullingPercent];
}


@end
