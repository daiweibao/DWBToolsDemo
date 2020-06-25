//
//  BaseShadowContentView.h
//  yingStep
//
//  Created by 你好 on 2020/6/11.
//  Copyright © 2020 北京赢响国际科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface BaseShadowContentView : UIView
@property (nonatomic,assign) CGFloat shadowCornerRadius; //圆角 默认18
@property (nonatomic,strong) UIColor * shadowColor; //阴影色值 默认 [UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:0.32]
@property (nonatomic,strong) UIColor * contentBackgroundColor;//内容颜色 默认白色
@property (nonatomic,assign) DWBRadiusType rectCorner; //默认 全部阴影:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomRight|UIRectCornerBottomLeft

@end

NS_ASSUME_NONNULL_END
