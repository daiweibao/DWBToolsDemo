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
    
    _titleLabelZoomEnabled = NO;
    //    _titleLabelZoomScale = 1.2;
    _titleColor = [UIColor blackColor];
    _titleSelectedColor = [UIColor redColor];
    _titleFont = [UIFont systemFontOfSize:15];
    _titleColorGradientEnabled = NO;
    _titleLabelMaskEnabled = NO;
    //    _titleLabelZoomScrollGradientEnabled = YES;
    
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

- (UIFont *)titleSelectedFont {
    if (_titleSelectedFont != nil) {
        return _titleSelectedFont;
    }
    return self.titleFont;
}

#pragma mark - Override

- (Class)preferredCellClass {
    return [DWBJXCategoryMyCell class];
}

- (void)refreshDataSource {
    NSMutableArray *tempArray = [NSMutableArray array];
    for (int i = 0; i < self.titles.count; i++) {
        DWBJXCategoryMyCellModel *cellModel = [[DWBJXCategoryMyCellModel alloc] init];
        [tempArray addObject:cellModel];
    }
    self.dataSource = tempArray;
}

- (void)refreshSelectedCellModel:(JXCategoryBaseCellModel *)selectedCellModel unselectedCellModel:(JXCategoryBaseCellModel *)unselectedCellModel {
    [super refreshSelectedCellModel:selectedCellModel unselectedCellModel:unselectedCellModel];
    
    DWBJXCategoryMyCellModel *myUnselectedCellModel = (DWBJXCategoryMyCellModel *)unselectedCellModel;
    myUnselectedCellModel.titleColor = self.titleColor;
    myUnselectedCellModel.titleSelectedColor = self.titleSelectedColor;
    myUnselectedCellModel.titleLabelZoomScale = 1.0;
    
    DWBJXCategoryMyCellModel *myselectedCellModel = (DWBJXCategoryMyCellModel *)selectedCellModel;
    myselectedCellModel.titleColor = self.titleColor;
    myselectedCellModel.titleSelectedColor = self.titleSelectedColor;
    myselectedCellModel.titleLabelZoomScale = self.titleLabelZoomScale;
}

- (void)refreshLeftCellModel:(JXCategoryBaseCellModel *)leftCellModel rightCellModel:(JXCategoryBaseCellModel *)rightCellModel ratio:(CGFloat)ratio {
    [super refreshLeftCellModel:leftCellModel rightCellModel:rightCellModel ratio:ratio];
    
    DWBJXCategoryMyCellModel *leftModel = (DWBJXCategoryMyCellModel *)leftCellModel;
    DWBJXCategoryMyCellModel *rightModel = (DWBJXCategoryMyCellModel *)rightCellModel;
    
    if (self.titleLabelZoomEnabled && self.titleLabelZoomScrollGradientEnabled) {
        leftModel.titleLabelZoomScale = [JXCategoryFactory interpolationFrom:self.titleLabelZoomScale to:1.0 percent:ratio];
        rightModel.titleLabelZoomScale = [JXCategoryFactory interpolationFrom:1.0 to:self.titleLabelZoomScale percent:ratio];
    }
    
    if (self.titleColorGradientEnabled) {
        //处理颜色渐变
        if (leftModel.selected) {
            leftModel.titleSelectedColor = [JXCategoryFactory interpolationColorFrom:self.titleSelectedColor to:self.titleColor percent:ratio];
            leftModel.titleColor = self.titleColor;
        }else {
            leftModel.titleColor = [JXCategoryFactory interpolationColorFrom:self.titleSelectedColor to:self.titleColor percent:ratio];
            leftModel.titleSelectedColor = self.titleSelectedColor;
        }
        if (rightModel.selected) {
            rightModel.titleSelectedColor = [JXCategoryFactory interpolationColorFrom:self.titleColor to:self.titleSelectedColor percent:ratio];
            rightModel.titleColor = self.titleColor;
        }else {
            rightModel.titleColor = [JXCategoryFactory interpolationColorFrom:self.titleColor to:self.titleSelectedColor percent:ratio];
            rightModel.titleSelectedColor = self.titleSelectedColor;
        }
    }
}

- (CGFloat)preferredCellWidthAtIndex:(NSInteger)index {
    if (self.cellWidth == JXCategoryViewAutomaticDimension) {
        return ceilf([self.titles[index] boundingRectWithSize:CGSizeMake(MAXFLOAT, self.bounds.size.height) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : self.titleFont} context:nil].size.width);
    }else {
        return self.cellWidth;
    }
}

- (void)refreshCellModel:(JXCategoryBaseCellModel *)cellModel index:(NSInteger)index {
    [super refreshCellModel:cellModel index:index];
    
    DWBJXCategoryMyCellModel *model = (DWBJXCategoryMyCellModel *)cellModel;
    model.titleFont = self.titleFont;
    model.titleSelectedFont = self.titleSelectedFont;
    model.titleColor = self.titleColor;
    model.titleSelectedColor = self.titleSelectedColor;
    model.title = self.titles[index];
    model.titleLabelMaskEnabled = self.titleLabelMaskEnabled;
    model.titleLabelZoomEnabled = self.titleLabelZoomEnabled;
    model.titleLabelZoomScale = 1.0;
    if (index == self.selectedIndex) {
        model.titleLabelZoomScale = self.titleLabelZoomScale;
    }
}


@end
