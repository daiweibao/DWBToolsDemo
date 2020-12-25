//
//  BaseShadowContentView.m
//  yingStep
//
//  Created by 你好 on 2020/6/11.
//  Copyright © 2020 北京chaoxi科技有限公司. All rights reserved.
//

#import "BaseShadowContentView.h"


@interface BaseShadowContentView()
@property (nonatomic,strong)UIView * shadowView;
@end
@implementation BaseShadowContentView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.shadowCornerRadius = 18;
        self.shadowColor = [UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:0.32];
        self.contentBackgroundColor =  [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
        self.rectCorner = UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomRight|UIRectCornerBottomLeft;
        [self addSubview:self.shadowView];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self.shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self);
    }];
}

-(UIView *)shadowView{
    if (!_shadowView) {
        _shadowView = [[UIView alloc] init];
//        _shadowView.layer.cornerRadius = 18;
//        _shadowView.layer.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0].CGColor;
//        _shadowView.layer.shadowColor = [UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:0.32].CGColor;
//        _shadowView.layer.shadowOffset = CGSizeMake(0,0);
        _shadowView.layer.shadowOpacity = 1;
        _shadowView.layer.shadowRadius = 10;
    }
    return _shadowView;
}


-(void)setShadowCornerRadius:(CGFloat)shadowCornerRadius{
    _shadowCornerRadius = shadowCornerRadius;
    [self.shadowView.layer setCornerRadius:shadowCornerRadius];
}

-(void)setShadowColor:(UIColor *)shadowColor{
    _shadowColor = shadowColor;
    [self.shadowView.layer setShadowColor:shadowColor.CGColor];
}

-(void)setContentBackgroundColor:(UIColor *)contentBackgroundColor{
    _contentBackgroundColor = contentBackgroundColor;
    [self.shadowView.layer setBackgroundColor:contentBackgroundColor.CGColor];
}

-(void)setRectCorner:(DWBRadiusType)rectCorner{
    _rectCorner = rectCorner;
    UIRectCorner corner = UIRectCornerTopLeft| UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight;
    switch (rectCorner) {
        case RadiusType_Top:{
            self.shadowView.layer.shadowOffset = CGSizeMake(0,-7);//
            corner = UIRectCornerTopLeft| UIRectCornerTopRight;
        }
            break;
        case RadiusType_bottom:{
            self.shadowView.layer.shadowOffset = CGSizeMake(0,7);//
            corner =  UIRectCornerBottomLeft | UIRectCornerBottomRight;
        }
            break;
        default:{
             self.shadowView.layer.shadowOffset = CGSizeMake(0,0);
        }
            break;
    }
    [self.shadowView setup_Radius:self.shadowCornerRadius corner:corner];
}

@end
