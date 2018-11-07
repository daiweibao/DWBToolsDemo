//
//  HZPhotoBrowserView.h
//  HZPhotoBrowser
//
//  Created by huangzhenyu on 15/5/7.
//  Copyright (c) 2015年 huangzhenyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FLAnimatedImageView+WebCache.h>
@interface HZPhotoBrowserView : UIView
@property (nonatomic,strong) UIScrollView *scrollview;
//@property (nonatomic,strong) UIImageView *imageview;
@property (nonatomic,strong) FLAnimatedImageView *imageview;
@property (nonatomic, assign) CGFloat progress;
@property (nonatomic, assign) BOOL beginLoadingImage;
/**判断图片是否加载成功*/
@property (nonatomic, assign) BOOL hasLoadedImage;
@property (nonatomic,assign) CGSize zoomImageSize;
@property (nonatomic,assign) CGPoint scrollOffset;
@property (nonatomic, strong) void(^scrollViewDidScroll)(CGPoint offset);
@property (nonatomic,copy) void(^scrollViewWillEndDragging)(CGPoint velocity,CGPoint offset);//返回scrollView滚动速度
@property (nonatomic,copy) void(^scrollViewDidEndDecelerating)();
@property (nonatomic, assign) BOOL isFullWidthForLandScape;
- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder;
@end
