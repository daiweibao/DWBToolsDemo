//
//  NSString+GetImageHeight.h
//  AiHenDeChaoXi
//
//  Created by chaoxi on 2018/6/16.
//  Copyright © 2018年 chaoxi科技有限公司. All rights reserved.
//
//给出自己想要的图片宽度，知道UI给的图片的宽、高用比例计算出图片的【高度】。
#import <Foundation/Foundation.h>

@interface NSString (GetImageHeight)

/**
 给出自己想要的图片宽度，知道UI给的图片的宽、高用比例计算出图片的【高度】。
 
 @param myWidth 自己根据屏幕款算算出的宽度，为了不超过屏幕宽度
 @param width UI给的图片宽度
 @param height UI给的图片高度
 @return 返回计算出来的图片高度
 */
+(CGFloat)getHieghtWithMyWidth:(CGFloat)myWidth AndUIWidth:(CGFloat)width AndUIHeight:(CGFloat)height;



@end
