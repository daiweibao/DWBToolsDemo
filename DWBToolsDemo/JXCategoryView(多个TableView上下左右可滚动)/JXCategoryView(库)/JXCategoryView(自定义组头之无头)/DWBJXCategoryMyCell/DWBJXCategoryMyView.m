//
//  DWBJXCategoryMyView.m
//  DWBToolsDemo
//
//  Created by chaoxi on 2018/11/25.
//  Copyright © 2018 chaoxi科技有限公司. All rights reserved.
//

#import "DWBJXCategoryMyView.h"
//处理颜色
#import "JXCategoryFactory.h"
#import "DWBJXCategoryMyCell.h"

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
    self.cellSpacing = 30;
    //宽度:self.cellWidth总宽度小于屏幕宽度就不会被拖动
#pragma mark ===========self.cellWidth总宽度小于屏幕宽度就不会被拖动,可以看成是固定头===========
     self.cellWidth = (SCREEN_WIDTH -  self.cellSpacing * (self.titles.count-1))/self.titles.count;
    //判空防止崩溃，必须
    if (self.cellWidth < 0) {
        self.cellWidth = 50;
    }
    //左右距离
    self.contentEdgeInsetLeft = 0;
    self.contentEdgeInsetRight = 0;
    
}

#pragma mark - Override
//必须实现
- (Class)preferredCellClass {
    return [DWBJXCategoryMyCell class];
}


@end
