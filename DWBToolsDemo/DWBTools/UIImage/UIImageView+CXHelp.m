//
//  UIImageView+CXHelp.m
//  AiHenDeChaoXi
//
//  Created by 爱恨的潮汐 on 2018/7/24.
//  Copyright © 2018年 潮汐科技有限公司. All rights reserved.
//

#import "UIImageView+CXHelp.h"

@implementation UIImageView (CXHelp)



/**
 设置图片控件高斯模糊
 */
-(void)setUpImageViewBlurEffect{
    //普通高斯模糊
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectview = [[UIVisualEffectView alloc] initWithEffect:blur];
     effectview.frame = self.frame;
    [self addSubview:effectview];
    
    //补充：有个三方的图片半透明高斯模糊：LBBlurredImage   "UIImageView+LBBlurredImage
}

@end
