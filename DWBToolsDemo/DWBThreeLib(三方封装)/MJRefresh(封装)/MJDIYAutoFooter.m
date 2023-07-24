//
//  MJDIYAutoFooter.m
//  AiHenDeChaoXi
//
//  Created by 戴维保 on 2018/4/22.
//  Copyright © 2018年 北京嗅美科技有限公司. All rights reserved.
//

#import "MJDIYAutoFooter.h"

#import "AFNetworking.h"

@interface MJDIYAutoFooter()

//动画
@property(nonatomic,weak) CABasicAnimation *animation;

@property (weak, nonatomic) UILabel *label;
//@property (weak, nonatomic) UIActivityIndicatorView *loading;
@property(nonatomic,weak)UIImageView *imageView;

@end

@implementation MJDIYAutoFooter

#pragma mark - 重写方法
#pragma mark 在这里做一些初始化配置（比如添加子控件）
- (void)prepare
{
    [super prepare];
    
    // 设置控件的高度
    self.mj_h = 50;
    
    // 添加label
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor colorWithHexString:@"#999999"];
    label.font = [UIFont boldSystemFontOfSize:12];
    label.textAlignment = NSTextAlignmentCenter;
    label.userInteractionEnabled = YES;
    [label addTapActionTouch:^{
        if (self.state==MJRefreshStateNoMoreData) {
            //已加载完毕全部的时候就不要在点击了
            
        }else{
            self.state = MJRefreshStateRefreshing;
            
        }
    }];
    [self addSubview:label];
    self.label = label;
    
//    // loading
//    UIActivityIndicatorView *loading = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//    [self addSubview:loading];
//    self.loading = loading;
    
    
    
    //创建图片
    UIImageView *imageView = [[UIImageView alloc]init];
    self.imageView = imageView;
    imageView.image = [UIImage imageNamed:@"上拉加载中"];
    [self addSubview:imageView];
     self.imageView.hidden = YES;
    
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
    [self.imageView.layer addAnimation:animation forKey:nil];
    
    //创建后让动画暂停
    [self pauseAnimation];
    
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
    
    self.label.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.mj_h);
  
    self.imageView.center = CGPointMake(self.width * 0.5 , self.mj_h * 0.5);
    self.imageView.size = CGSizeMake(25, 25);
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
//            self.label.text = @"点击或者上拉加载更多";
////            [self.loading stopAnimating];
//            self.label.hidden = NO;
//
//            self.imageView.hidden = YES;
//            //动画暂停
//            [self pauseAnimation];
            
            //手动监听网络状态
            [self handGetTheNetworkStatus];
            
            break;
        case MJRefreshStateRefreshing:
            
            self.label.text = @"加载数据中";//
//            [self.loading startAnimating];
             self.imageView.hidden = NO;
            //动画恢复
            [self resumeAnimation];
             self.label.hidden = YES;
            break;
        case MJRefreshStateNoMoreData:
            self.label.text = @"亲，没有更多内容了！";
//            [self.loading stopAnimating];
            self.imageView.hidden = YES;
            //动画暂停
            [self pauseAnimation];
            
             self.label.hidden = NO;
            break;
        default:
            break;
    }
}


#pragma mark - 动画效果

//暂停动画
- (void)pauseAnimation {
    //（0-5）
    //开始时间：0
    //    myView.layer.beginTime
    //1.取出当前时间，转成动画暂停的时间
    CFTimeInterval pauseTime = [_imageView.layer convertTime:CACurrentMediaTime() fromLayer:nil];
    
    //2.设置动画的时间偏移量，指定时间偏移量的目的是让动画定格在该时间点的位置
    _imageView.layer.timeOffset = pauseTime;
    
    //3.将动画的运行速度设置为0， 默认的运行速度是1.0
    _imageView.layer.speed = 0;
    
}

//恢复动画
- (void)resumeAnimation {
    //1.将动画的时间偏移量作为暂停的时间点
    CFTimeInterval pauseTime = _imageView.layer.timeOffset;
    //2.计算出开始时间
    CFTimeInterval begin = CACurrentMediaTime() - pauseTime;
    
    [_imageView.layer setTimeOffset:0];
    [_imageView.layer setBeginTime:begin];
    
    _imageView.layer.speed = 1;
}



//手动监听网络状态并判断是否自动播放
-(void)handGetTheNetworkStatus{
    //手动监听的
    AFNetworkReachabilityManager * NetworkMon = [AFNetworkReachabilityManager sharedManager];
    [NetworkMon setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status == 0) {
            //没网
            self.state = MJRefreshStateIdle;
            self.label.hidden = NO;
            self.imageView.hidden = YES;
            //动画暂停
            [self pauseAnimation];
            
            self.label.text = @"网络加载失败";//提示没网
            
        }else{
           //有网
            if (self.state==MJRefreshStateNoMoreData) {
                //已加载完全部的时候不改变
            }else{
                self.state = MJRefreshStateIdle;
                self.label.hidden = NO;
                self.imageView.hidden = YES;
                //动画暂停
                [self pauseAnimation];
                
                self.label.text = @"点击或者上拉加载更多";//网络恢复
                
            }
            
        }
    }];
    
    // 开始监听网络
    [NetworkMon startMonitoring];
}



@end
