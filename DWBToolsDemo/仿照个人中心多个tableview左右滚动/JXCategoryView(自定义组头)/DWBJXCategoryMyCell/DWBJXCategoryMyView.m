//
//  DWBJXCategoryMyView.m
//  DWBToolsDemo
//
//  Created by 戴维保 on 2018/11/25.
//  Copyright © 2018 潮汐科技有限公司. All rights reserved.
//

#import "DWBJXCategoryMyView.h"
//处理颜色
#import "JXCategoryFactory.h"

@interface DWBJXCategoryMyView ()

@end

@implementation DWBJXCategoryMyView


- (void)initializeData
{
    [super initializeData];
    
    //背景色
    self.backgroundColor = [UIColor yellowColor];
}

//自定义UI
-(void)createMyUI{
    //两个之间距离
    self.cellSpacing = 100;
    //宽度
     self.cellWidth = (SCREEN_WIDTH -  self.cellSpacing * (self.titles.count-1))/self.titles.count;
    //判空防止崩溃
    if (self.cellWidth < 0) {
        self.cellWidth = 30;
    }
    
    //左右距离
    self.contentEdgeInsetLeft = 0;
    self.contentEdgeInsetRight = 0;
    
}


@end
