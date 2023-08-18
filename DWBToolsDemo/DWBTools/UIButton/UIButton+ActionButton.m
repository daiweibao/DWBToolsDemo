//
//  UIButton+ActionButton.m
//  aaa
//
//  Created by 季文斌 on 2023/8/14.
//  Copyright © 2023 Alibaba. All rights reserved.
//

#import "UIButton+ActionButton.h"

    
@implementation UIButton (ActionButton)

@dynamic blockBtn;
static char *blockBtnKey = "blockBtnKey";
//关联属性
- (CXButtonBlock)blockBtn{
   return  objc_getAssociatedObject(self, blockBtnKey);
}

-(void)setBlockBtn:(CXButtonBlock)blockBtn{
        objc_setAssociatedObject(self, blockBtnKey, blockBtn, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

//封装button点击事件
- (void)addTapButton:(CXButtonBlock)buttonBlock{
    self.blockBtn = buttonBlock;
    [self addTarget:self action:@selector(buttonCXAction:) forControlEvents:UIControlEventTouchUpInside];
}
//button的点击事件
- (void)buttonCXAction:(UIButton *)button{
    self.blockBtn(button);
}

@end
