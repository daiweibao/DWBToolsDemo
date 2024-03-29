//
//  DownUpdateAppAleat.h
//  AiHenDeChaoXi
//
//  Created by 爱恨的潮汐 on 2018/6/12.
//  Copyright © 2018年 潮汐科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry.h>
@interface DownUpdateAppAleat : UIView
/**
 检查更新
 
 @param version 版本号
 @param content 内容
 */
+ (void)downUpdateAppAleatWithVersion:(NSString *)version AndContent:(NSString*)content;

@end
