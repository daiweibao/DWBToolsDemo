//
//  NSString+GetImageHeight.m
//  AiHenDeChaoXi
//
//  Created by 戴维保 on 2018/6/16.
//  Copyright © 2018年 潮汐科技有限公司. All rights reserved.
//

#import "NSString+GetImageHeight.h"

@implementation NSString (GetImageHeight)

/**
 给出自己想要的图片宽度，知道UI给的图片的宽、高用比例计算出图片的【高度】。

 @param myWidth 自己根据屏幕款算算出的宽度，为了不超过屏幕宽度
 @param width UI给的图片宽度
 @param height UI给的图片高度
 @return 返回计算出来的图片高度
 */
+(CGFloat)getHieghtWithMyWidth:(CGFloat)myWidth AndUIWidth:(CGFloat)width AndUIHeight:(CGFloat)height{
    
    CGFloat imageHeight = myWidth * height / width;
    
    return imageHeight;
}
@end
