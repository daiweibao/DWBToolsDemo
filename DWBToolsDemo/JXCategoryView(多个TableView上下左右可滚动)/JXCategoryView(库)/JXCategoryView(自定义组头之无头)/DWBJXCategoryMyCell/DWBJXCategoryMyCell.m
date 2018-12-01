//
//  DWBJXCategoryMyCell.m
//  DWBToolsDemo
//
//  Created by 戴维保 on 2018/11/25.
//  Copyright © 2018 潮汐科技有限公司. All rights reserved.
//

#import "DWBJXCategoryMyCell.h"
#import "JXCategoryTitleCellModel.h"
@interface DWBJXCategoryMyCell ()
//父视图，主要是要留出高度
@property(nonatomic,strong)UIView * contentTitleView;

@end

@implementation DWBJXCategoryMyCell



- (void)initializeViews
{
    [super initializeViews];
    //影藏父类标题
    self.titleLabel.hidden = YES;
    self.maskTitleLabel.hidden = YES;
    
    
    //创建父视图UI
    self.contentTitleView = [[UIView alloc]init];
    self.contentTitleView.frame = CGRectMake(0, 0, self.contentView.width, 25);
    [self.contentView addSubview:self.contentTitleView];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    //设置坐标

}

//改变选中，非选中状态
- (void)reloadData:(JXCategoryBaseCellModel *)cellModel {
    [super reloadData:cellModel];
    JXCategoryTitleCellModel *myCellModel = (JXCategoryTitleCellModel *)cellModel;
    if (myCellModel.selected) {
        self.contentTitleView.backgroundColor = [UIColor redColor];
    }else {
        self.contentTitleView.backgroundColor  =[UIColor blackColor];
    }
}

@end
