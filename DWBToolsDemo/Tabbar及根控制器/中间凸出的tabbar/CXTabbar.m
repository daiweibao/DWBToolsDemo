//
//  CXTabbar.m
//  AiHenDeChaoXi
//
//  Created by 戴维保 on 2018/7/7.
//  Copyright © 2018年 北京嗅美科技有限公司. All rights reserved.
//

#import "CXTabbar.h"

@interface CXTabbar ()

/** plus按钮 */
@property (nonatomic, weak) UIButton *plusBtn ;

@end

@implementation CXTabbar

- (void)layoutSubviews {
    [super layoutSubviews];
    
    //判空在创建，否则会创建两次这个按钮太黑了
    if (self.plusBtn==nil) {
        
        UIButton *publishBtn = [[UIButton alloc] init];
        self.plusBtn = publishBtn;
        //button各个状态点击事件
        [publishBtn addTarget:self action:@selector(recordTouchDown:) forControlEvents:UIControlEventTouchDown];
        [publishBtn addTarget:self action:@selector(recordTouchUpOutside) forControlEvents:UIControlEventTouchUpOutside];
        [publishBtn addTarget:self action:@selector(recordTouchUpInside) forControlEvents:UIControlEventTouchUpInside];
        [publishBtn addTarget:self action:@selector(recordTouchDragEnter) forControlEvents:UIControlEventTouchDragEnter];
        [publishBtn addTarget:self action:@selector(recordTouchDragInside) forControlEvents:UIControlEventTouchDragInside];
        [publishBtn addTarget:self action:@selector(recordTouchDragOutside) forControlEvents:UIControlEventTouchDragOutside];
        [publishBtn addTarget:self action:@selector(recordTouchDragExit) forControlEvents:UIControlEventTouchDragExit];
        
        publishBtn.adjustsImageWhenHighlighted = NO;
        [publishBtn setImage:[UIImage imageNamed:@"tabbar-语音"] forState:UIControlStateNormal];
        //    语音图标没阴影@2x
        //     [publishBtn setImage:[UIImage imageNamed:@"语音图标没阴影"] forState:UIControlStateNormal];
        [publishBtn setImage:[UIImage imageNamed:@"语音按下状态"] forState:UIControlStateHighlighted];//高亮状态
        [publishBtn setTitle:@"语音" forState:UIControlStateNormal];
        [publishBtn setTitleColor:MAIN_COLOR forState:UIControlStateNormal];
        publishBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        
        publishBtn.frame = CGRectMake(SCREEN_WIDTH/5 * 2, -10, SCREEN_WIDTH/5, 50);
        //button按钮
        [publishBtn setImagePositionWithType:SSImagePositionTypeTop spacing:0];
        
        [self addSubview:publishBtn];
        
    }

}

#pragma mark ==========适配ipad，让TabBar在ipad上不会出现图片文字左右排列的问题。（注意：只能放在CXTabbar里，否则会影响到导航栏）=====
//适配ipad，让TabBar在ipad上不会出现图片文字左右排列的问题。
- (UITraitCollection *)traitCollection {
    //如果是ipad就处理下
    if ([DWBDeviceHelp isiPadDevice]==YES) {
        return [UITraitCollection traitCollectionWithVerticalSizeClass:UIUserInterfaceSizeClassCompact];
    }
    
    return [super traitCollection];
    
}

//button各种点击事件
//手指按下
-(void)recordTouchDown:(UIButton*)button{
    if (self.didClickPublishBtn) {
        self.didClickPublishBtn();
    }
}
//手指滑出
-(void)recordTouchUpOutside{
        if (self.didClickPublishBtnRemo) {
            self.didClickPublishBtnRemo();
        }
}
//手指抬起来
-(void)recordTouchUpInside{
        if (self.didClickPublishBtnRemo) {
            self.didClickPublishBtnRemo();
        }
}

-(void)recordTouchDragEnter{
    
}
-(void)recordTouchDragInside{
    
}
-(void)recordTouchDragOutside{
}

-(void)recordTouchDragExit{
}

//重写hitTest方法，去监听发布按钮的点击，目的是为了让凸出的部分点击也有反应
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    //这一个判断是关键，不判断的话push到其他页面，点击发布按钮的位置也是会有反应的，这样就不好了
    //self.isHidden == NO 说明当前页面是有tabbar的，那么肯定是在导航控制器的根控制器页面
    //在导航控制器根控制器页面，那么我们就需要判断手指点击的位置是否在发布按钮身上
    //是的话让发布按钮自己处理点击事件，不是的话让系统去处理点击事件就可以了
    if (self.isHidden == NO) {
        
        //将当前tabbar的触摸点转换坐标系，转换到发布按钮的身上，生成一个新的点
        CGPoint newP = [self convertPoint:point toView:self.plusBtn];
        
        //判断如果这个新的点是在发布按钮身上，那么处理点击事件最合适的view就是发布按钮
        if ( [self.plusBtn pointInside:newP withEvent:event]) {
            return self.plusBtn;
        }else{//如果点不在发布按钮身上，直接让系统处理就可以了
            
            return [super hitTest:point withEvent:event];
        }
    }
    
    else {//tabbar隐藏了，那么说明已经push到其他的页面了，这个时候还是让系统去判断最合适的view处理就好了
        
        return [super hitTest:point withEvent:event];
    }
}


@end
