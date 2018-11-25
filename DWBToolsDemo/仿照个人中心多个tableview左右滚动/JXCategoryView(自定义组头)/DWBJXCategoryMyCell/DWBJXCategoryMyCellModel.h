//
//  DWBJXCategoryMyCellModel.h
//  DWBToolsDemo
//
//  Created by 戴维保 on 2018/11/25.
//  Copyright © 2018 潮汐科技有限公司. All rights reserved.
//

#import "JXCategoryIndicatorCellModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DWBJXCategoryMyCellModel : JXCategoryIndicatorCellModel
@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) UIColor *titleColor;

@property (nonatomic, strong) UIColor *titleSelectedColor;

@property (nonatomic, strong) UIFont *titleFont;

@property (nonatomic, strong) UIFont *titleSelectedFont;

@property (nonatomic, assign) BOOL titleLabelMaskEnabled;

@property (nonatomic, strong) CALayer *backgroundEllipseLayer;

@property (nonatomic, assign) BOOL titleLabelZoomEnabled;

@property (nonatomic, assign) CGFloat titleLabelZoomScale;
@end

NS_ASSUME_NONNULL_END
