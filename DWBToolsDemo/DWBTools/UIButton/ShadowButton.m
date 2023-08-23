//
//  ShadowButton.m
//  APP
//
//  Created by 小潮汐 on 2021/11/26.
//  Copyright © 2021 DWB. All rights reserved.
//

#import "ShadowButton.h"

@implementation ShadowButton

-(id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        [self setAdjustsImageWhenHighlighted:NO]; // 默认是YES 高亮效果,
        [self bringSubviewToFront:self.titleLabel];
        //文字居中
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}
#pragma mark------------button同时显示图片与文字-----------
//设置文字的坐标
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}
//设置图片的坐标
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}

@end
