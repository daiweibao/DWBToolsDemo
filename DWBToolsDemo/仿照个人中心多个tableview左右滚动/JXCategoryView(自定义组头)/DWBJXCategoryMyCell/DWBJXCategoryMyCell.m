//
//  DWBJXCategoryMyCell.m
//  DWBToolsDemo
//
//  Created by 戴维保 on 2018/11/25.
//  Copyright © 2018 潮汐科技有限公司. All rights reserved.
//

#import "DWBJXCategoryMyCell.h"
#import "DWBJXCategoryMyCellModel.h"
@interface DWBJXCategoryMyCell ()


@property(nonatomic,strong)UIView * viewSub;


@end

@implementation DWBJXCategoryMyCell

- (void)initializeViews
{
//    [super initializeViews];
    
    
    self.viewSub  = [[UIView alloc]init];
    
    self.viewSub.frame = CGRectMake(0, 0, self.width, 30);
    self.viewSub.backgroundColor = [UIColor blackColor];
    [self.contentView addSubview:self.viewSub];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    //设置坐标
    
}

- (void)reloadData:(JXCategoryBaseCellModel *)cellModel {
    [super reloadData:cellModel];
    
    DWBJXCategoryMyCellModel *myCellModel = (DWBJXCategoryMyCellModel *)cellModel;
    
    //    CGFloat pointSize = myCellModel.titleFont.pointSize;
    //    UIFontDescriptor *fontDescriptor = myCellModel.titleFont.fontDescriptor;
    if (myCellModel.selected) {
        //        fontDescriptor = myCellModel.titleSelectedFont.fontDescriptor;
        //        pointSize = myCellModel.titleSelectedFont.pointSize;
    }
    if (myCellModel.titleLabelZoomEnabled) {
        //        self.titleLabel.font = [UIFont fontWithDescriptor:fontDescriptor size:pointSize*myCellModel.titleLabelZoomScale];
        //        self.maskTitleLabel.font = [UIFont fontWithDescriptor:fontDescriptor size:pointSize*myCellModel.titleLabelZoomScale];
    }else {
        //        self.titleLabel.font = [UIFont fontWithDescriptor:fontDescriptor size:pointSize];
        //        self.maskTitleLabel.font = [UIFont fontWithDescriptor:fontDescriptor size:pointSize];
    }
    
    //    self.maskTitleLabel.hidden = !myCellModel.titleLabelMaskEnabled;
    if (myCellModel.titleLabelMaskEnabled) {
        //        self.titleLabel.textColor = myCellModel.titleColor;
        //        self.maskTitleLabel.font = myCellModel.titleFont;
        //        self.maskTitleLabel.textColor = myCellModel.titleSelectedColor;
        //
        //        self.maskTitleLabel.text = myCellModel.title;
        //        [self.maskTitleLabel sizeToFit];
        //
        //        CGRect frame = myCellModel.backgroundViewMaskFrame;
        //        frame.origin.x -= (self.contentView.bounds.size.width - self.maskTitleLabel.bounds.size.width)/2;
        //        frame.origin.y = 0;
        //        [CATransaction begin];
        //        [CATransaction setDisableActions:YES];
        //        self.maskLayer.frame = frame;
        //        [CATransaction commit];
    }else {
        if (myCellModel.selected) {
            self.viewSub.backgroundColor = [UIColor redColor];
        }else {
            self.viewSub.backgroundColor  =[UIColor blackColor];
        }
    }
    
    //    self.titleLabel.text = myCellModel.title;
    //    [self.titleLabel sizeToFit];
    //    [self setNeedsLayout];
    //    [self layoutIfNeeded];
}


@end
