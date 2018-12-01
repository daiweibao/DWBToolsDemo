//
//  UIImage+PlayGif.m
//  ZuiMeiXinNiang
//
//  Created by 戴维保 on 2017/3/17.
//  Copyright © 2017年 zmxn. All rights reserved.
//

#import "UIImage+PlayGif.h"
@implementation UIImage (PlayGif)

/**
 播放本地gif图片（复制SDWebImage的方法，更新SDWebImage也不影响））
 
 @param imageName gif图片名字 美聊精选.gif
 @return 返回图片
 */
+(UIImage *)gifImagePlay:(NSString * )imageName{
    
  NSData * data = [NSData dataWithContentsOfFile:[[NSBundle bundleWithPath:[[NSBundle mainBundle] bundlePath]] pathForResource:[NSString stringWithFormat:@"%@.gif",imageName] ofType:nil]];
    
    //进入SDImage的方法
    if (!data) {
        return nil;
    }
    
    CGImageSourceRef source = CGImageSourceCreateWithData((__bridge CFDataRef)data, NULL);
    
    size_t count = CGImageSourceGetCount(source);
    
    UIImage *animatedImage;
    
    if (count <= 1) {
        animatedImage = [[UIImage alloc] initWithData:data];
    }
    else {
        NSMutableArray *images = [NSMutableArray array];
        
        NSTimeInterval duration = 0.0f;
        
        for (size_t i = 0; i < count; i++) {
            CGImageRef image = CGImageSourceCreateImageAtIndex(source, i, NULL);
            if (!image) {
                continue;
            }
            
            duration += [self sd_frameDurationAtIndex:i source:source];
            
            [images addObject:[UIImage imageWithCGImage:image scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp]];
            
            CGImageRelease(image);
        }
        
        if (!duration) {
            duration = (1.0f / 10.0f) * count;
        }
        
        animatedImage = [UIImage animatedImageWithImages:images duration:duration];
    }
    
    CFRelease(source);
    
    return animatedImage;
}

#pragma mark =============SDWebImage复制过来的方法，无依赖=====================

+ (UIImage *)sd_animatedGIFWithData:(NSData *)data {
    if (!data) {
        return nil;
    }
    
    CGImageSourceRef source = CGImageSourceCreateWithData((__bridge CFDataRef)data, NULL);
    
    size_t count = CGImageSourceGetCount(source);
    
    UIImage *animatedImage;
    
    if (count <= 1) {
        animatedImage = [[UIImage alloc] initWithData:data];
    }
    else {
        NSMutableArray *images = [NSMutableArray array];
        
        NSTimeInterval duration = 0.0f;
        
        for (size_t i = 0; i < count; i++) {
            CGImageRef image = CGImageSourceCreateImageAtIndex(source, i, NULL);
            if (!image) {
                continue;
            }
            
            duration += [self sd_frameDurationAtIndex:i source:source];
            
            [images addObject:[UIImage imageWithCGImage:image scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp]];
            
            CGImageRelease(image);
        }
        
        if (!duration) {
            duration = (1.0f / 10.0f) * count;
        }
        
        animatedImage = [UIImage animatedImageWithImages:images duration:duration];
    }
    
    CFRelease(source);
    
    return animatedImage;
}

+ (float)sd_frameDurationAtIndex:(NSUInteger)index source:(CGImageSourceRef)source {
    float frameDuration = 0.1f;
    CFDictionaryRef cfFrameProperties = CGImageSourceCopyPropertiesAtIndex(source, index, nil);
    NSDictionary *frameProperties = (__bridge NSDictionary *)cfFrameProperties;
    NSDictionary *gifProperties = frameProperties[(NSString *)kCGImagePropertyGIFDictionary];
    
    NSNumber *delayTimeUnclampedProp = gifProperties[(NSString *)kCGImagePropertyGIFUnclampedDelayTime];
    if (delayTimeUnclampedProp) {
        frameDuration = [delayTimeUnclampedProp floatValue];
    }
    else {
        
        NSNumber *delayTimeProp = gifProperties[(NSString *)kCGImagePropertyGIFDelayTime];
        if (delayTimeProp) {
            frameDuration = [delayTimeProp floatValue];
        }
    }
    
    // Many annoying ads specify a 0 duration to make an image flash as quickly as possible.
    // We follow Firefox's behavior and use a duration of 100 ms for any frames that specify
    // a duration of <= 10 ms. See <rdar://problem/7689300> and <http://webkit.org/b/36082>
    // for more information.
    
    if (frameDuration < 0.011f) {
        frameDuration = 0.100f;
    }
    
    CFRelease(cfFrameProperties);
    return frameDuration;
}

+ (UIImage *)sd_animatedGIFNamed:(NSString *)name {
    CGFloat scale = [UIScreen mainScreen].scale;
    
    if (scale > 1.0f) {
        NSString *retinaPath = [[NSBundle mainBundle] pathForResource:[name stringByAppendingString:@"@2x"] ofType:@"gif"];
        
        NSData *data = [NSData dataWithContentsOfFile:retinaPath];
        
        if (data) {
            return [UIImage sd_animatedGIFWithData:data];
        }
        
        NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"gif"];
        
        data = [NSData dataWithContentsOfFile:path];
        
        if (data) {
            return [UIImage sd_animatedGIFWithData:data];
        }
        
        return [UIImage imageNamed:name];
    }
    else {
        NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"gif"];
        
        NSData *data = [NSData dataWithContentsOfFile:path];
        
        if (data) {
            return [UIImage sd_animatedGIFWithData:data];
        }
        
        return [UIImage imageNamed:name];
    }
}

- (UIImage *)sd_animatedImageByScalingAndCroppingToSize:(CGSize)size {
    if (CGSizeEqualToSize(self.size, size) || CGSizeEqualToSize(size, CGSizeZero)) {
        return self;
    }
    
    CGSize scaledSize = size;
    CGPoint thumbnailPoint = CGPointZero;
    
    CGFloat widthFactor = size.width / self.size.width;
    CGFloat heightFactor = size.height / self.size.height;
    CGFloat scaleFactor = (widthFactor > heightFactor) ? widthFactor : heightFactor;
    scaledSize.width = self.size.width * scaleFactor;
    scaledSize.height = self.size.height * scaleFactor;
    
    if (widthFactor > heightFactor) {
        thumbnailPoint.y = (size.height - scaledSize.height) * 0.5;
    }
    else if (widthFactor < heightFactor) {
        thumbnailPoint.x = (size.width - scaledSize.width) * 0.5;
    }
    
    NSMutableArray *scaledImages = [NSMutableArray array];
    
    for (UIImage *image in self.images) {
        UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
        
        [image drawInRect:CGRectMake(thumbnailPoint.x, thumbnailPoint.y, scaledSize.width, scaledSize.height)];
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
        
        [scaledImages addObject:newImage];
        
        UIGraphicsEndImageContext();
    }
    
    return [UIImage animatedImageWithImages:scaledImages duration:self.duration];
}


/**
 FLAnimatedImageView控件播放本地动画

 @param gifName 图片名字，不能包含.gif
 @return FLAnimatedImage结果
 */
+(FLAnimatedImage* )playGifImageFLAnimated:(NSString *)gifName{
    //读取图片，并设置格式，依赖FLAnimatedImage三方库
    NSString  *filePath = [[NSBundle bundleWithPath:[[NSBundle mainBundle] bundlePath]]pathForResource:gifName ofType:@"gif"];
    NSData  *imageData = [NSData dataWithContentsOfFile:filePath];
    return [FLAnimatedImage animatedImageWithGIFData:imageData];
    
    /*
     使用示例
     FLAnimatedImageView *imgView = [[FLAnimatedImageView alloc]init];
     imgView.frame = CGRectMake(0.0, 220.0, 100.0, 100.0);
     imgView.animatedImage = [UIImage playGifImageFLAnimated:@"加载中最新"];
     [self.view addSubview:imgView];
     //动画播放完成1次，停止播放动画
     imgView.loopCompletionBlock = ^(NSUInteger loopCountRemaining){
     [weakimgViewAnima stopAnimating];
     };
     
     */
    
}



//播放数组图片动画案例
+(void)PlayAnimationImages:(UIImageView *)imageview{
    //图片数组播放动画
    NSMutableArray * imagesArr = [NSMutableArray array];
    for (int i = 1; i < 5; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"认证中%d",i]];
        if (image) {
            [imagesArr addObject:image];
        }
    }
    imageview.animationImages = imagesArr; //获取Gif图片列表数组
    imageview.animationDuration = 1;     //执行一次完整动画所需的时长
    imageview.animationRepeatCount = 0;  //动画重复次数
    [imageview startAnimating];

}



@end
