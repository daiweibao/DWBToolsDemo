//
//  UIControl+recurClick.m
//  主要解决按钮的重复点击问题
//
//  Created by King on 16/9/2.
//  Copyright © 2016年 King. All rights reserved.
//

#import "UIControl+recurClick.h"
#import <objc/runtime.h>

static const char *UIControl_rippleLayer = "UIControl_rippleLayer";
static const char *UIControl_acceptEventInterval = "UIControl_acceptEventInterval";
static const char *UIControl_acceptEventTime     = "UIControl_acceptEventTime";
static const char *UIControl_startPoint     = "UIControl_startPoint";
static const char *UIControl_showFlash     = "UIControl_showFlash";


@interface UIControl()

/** 阴影layer */
@property (nonatomic, strong) CAShapeLayer *rippleLayer;
@property (nonatomic, assign) CGPoint startPoint;

@end



@implementation UIControl (recurClick)

- (instancetype)init{
    if (self = [super init]) {
        self.clipsToBounds = YES;
//        self.showFlash = NO;
    }
    return self;
}
+ (void)load{
    //获取这两个方法
    Method systemMethod = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));
    SEL sysSEL = @selector(sendAction:to:forEvent:);
    
    Method myMethod = class_getInstanceMethod(self, @selector(mm_sendAction:to:forEvent:));
    SEL mySEL = @selector(mm_sendAction:to:forEvent:);
    
    //添加方法进去
    BOOL didAddMethod = class_addMethod(self, sysSEL, method_getImplementation(myMethod), method_getTypeEncoding(myMethod));
    
    //如果方法已经存在
    if (didAddMethod) {
        class_replaceMethod(self, mySEL, method_getImplementation(systemMethod), method_getTypeEncoding(systemMethod));
    }else{
        method_exchangeImplementations(systemMethod, myMethod);
        
    }
    /*-----以上主要是实现两个方法的互换,load是gcd的只shareinstance，果断保证执行一次-------*/
}

- (void)mm_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event{
    if (NSDate.date.timeIntervalSince1970 - self.mm_acceptEventTime < self.mm_acceptEventInterval) {
        return;
    }
    if (self.mm_acceptEventInterval > 0) {
        self.mm_acceptEventTime = NSDate.date.timeIntervalSince1970;
    }
    if (self.showFlash) {
        [self creatAnimation:self.startPoint];
    }
    [self mm_sendAction:action to:target forEvent:event];
}



- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *view = [super hitTest:point withEvent:event];
    self.startPoint = point;
    return view;
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    //获取触摸点位置
//    CGPoint touchPoint = [[touches anyObject] locationInView:self];
//    self.startPoint = touchPoint;
//    [self creatAnimation:touchPoint];
//}


- (void)creatAnimation:(CGPoint)touchPoint{
    return;
    //创建初始曲线
    CGRect circleRect = CGRectMake(touchPoint.x - 1, touchPoint.y -1 , 2, 2);
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:circleRect];
    self.rippleLayer = [CAShapeLayer layer];
    //水波纹的颜色
    self.rippleLayer.fillColor = UIColorFromRGB(0x666666).CGColor;
    self.rippleLayer.opacity = 0.3;
    self.rippleLayer.strokeColor = [UIColor lightGrayColor].CGColor;
    self.rippleLayer.lineWidth = 0.1f;
    self.rippleLayer.path = path.CGPath;
    //创建layer
    [self.layer addSublayer:self.rippleLayer];
    //计算最终直径
    CGFloat diameter = sqrt(self.bounds.size.width * self.bounds.size.width + self.bounds.size.height * self.bounds.size.height) + 10;
    UIBezierPath *finalBezierPath = [self pathWithDiameter:diameter];
    //基础动画
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.delegate = (id)self;
    animation.keyPath = @"path";
    animation.toValue = (id)finalBezierPath.CGPath;
    animation.duration = 0.1;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    [self.rippleLayer addAnimation:animation forKey:@"changePath"];
}
- (UIBezierPath *)pathWithDiameter:(CGFloat)diameter {
    return [UIBezierPath bezierPathWithOvalInRect:CGRectMake((CGRectGetWidth(self.bounds) - diameter) / 2, (CGRectGetHeight(self.bounds) - diameter) / 2, diameter, diameter)];
}

#pragma mark - AnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if (flag) {
        [self.rippleLayer removeFromSuperlayer];
    }
}

#pragma mark ------ Getter/Setter

- (NSTimeInterval )mm_acceptEventInterval{
    return [objc_getAssociatedObject(self, UIControl_acceptEventInterval) doubleValue];
}

- (void)setMm_acceptEventInterval:(NSTimeInterval)mm_acceptEventInterval{
    objc_setAssociatedObject(self, UIControl_acceptEventInterval, @(mm_acceptEventInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSTimeInterval )mm_acceptEventTime{
    return [objc_getAssociatedObject(self, UIControl_acceptEventTime) doubleValue];
}

- (void)setMm_acceptEventTime:(NSTimeInterval)mm_acceptEventTime{
    objc_setAssociatedObject(self, UIControl_acceptEventTime, @(mm_acceptEventTime), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(CAShapeLayer *)rippleLayer{
    return objc_getAssociatedObject(self, &UIControl_rippleLayer);
}

- (void)setRippleLayer:(CAShapeLayer *)rippleLayer{
    objc_setAssociatedObject(self, &UIControl_rippleLayer, rippleLayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGPoint)startPoint{
    NSValue *value = objc_getAssociatedObject(self, &UIControl_startPoint);
    if(value) {
        CGPoint point;
        [value getValue:&point];
        return point;
    }else {
        return CGPointZero;
    }
}
- (void)setStartPoint:(CGPoint)startPoint{
    NSValue *value = [NSValue value:&startPoint withObjCType:@encode(CGPoint)];
    objc_setAssociatedObject(self, &UIControl_startPoint, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)showFlash{
    return objc_getAssociatedObject(self, &UIControl_showFlash);
}
- (void)setShowFlash:(BOOL)showFlash{
    return objc_setAssociatedObject(self, &UIControl_showFlash, @(showFlash), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}



@end


