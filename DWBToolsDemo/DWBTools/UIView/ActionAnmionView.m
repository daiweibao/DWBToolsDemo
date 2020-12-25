//
//  ActionAnmionView.m
//  miniVideo
//
//  Created by chaoxi on 2020/4/27.
//  Copyright © 2020 北京chaoxi科技有限公司. All rights reserved.
//

#import "ActionAnmionView.h"

@implementation ActionAnmionView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{

    UIView *view = [super hitTest:point withEvent:event];
    
    if (!view && !self.isHidden && self.alpha > 0.01) {
        //presentationLayer 是动画渲染过程的图层
        CALayer *presentationLayer = self.layer.presentationLayer;
        CGPoint touchPoint = [self convertPoint:point toView:self.superview];
        if (CGRectContainsPoint(presentationLayer.frame, touchPoint)) {
            view = self;
        }
    }
    
    return view;
}

@end
