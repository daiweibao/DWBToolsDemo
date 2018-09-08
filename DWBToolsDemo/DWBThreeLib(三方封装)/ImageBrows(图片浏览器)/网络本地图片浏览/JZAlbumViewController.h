//
//  JZAlbumViewController.h
//  aoyouHH
//  功能描述：用于显示并浏览图片，添加了加载进度条功能
//  Created by jinzelu on 15/4/27.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JZAlbumViewController : UIViewController

/**
 *  接收图片数组，数组类型可以是url数组，image数组
 */
@property(nonatomic, strong) NSMutableArray *imgArr;
/**
 *  显示scrollView
 */
@property(nonatomic, strong) UIScrollView *scrollView;
/**
 *  显示下标
 */
@property(nonatomic, strong) UILabel *sliderLabel;
/**
 *  接收当前图片的序号,默认的是0
 */
@property(nonatomic, assign) NSInteger currentIndex;


@end
/*
 用法：
 //控制器跳转
 JZAlbumViewController *jzAlbumVC = [[JZAlbumViewController alloc]init];
 //当前点击图片的索引，记录点击了哪一张图片
 jzAlbumVC.currentIndex = currentIndex;
 //imgArr可以为url数组, 可以为urlString 数组, 可以为二进制 UIImage 数组
 jzAlbumVC.imgArr = self.mArrayUrl;
 
 [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:jzAlbumVC animated:NO completion:nil];
 
 */
