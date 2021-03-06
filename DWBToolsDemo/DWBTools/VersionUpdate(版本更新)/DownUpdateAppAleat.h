//
//  DownUpdateAppAleat.h
//  AiHenDeChaoXi
//
//  Created by chaoxi on 2018/6/12.
//  Copyright © 2018年 chaoxi科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
#import "DWBAFNetworking.h"
@interface DownUpdateAppAleat : UIView
/**
 检查更新
 
 @param version 版本号
 @param content 内容
 */
+ (void)downUpdateAppAleatWithVersion:(NSString *)version AndContent:(NSString*)content;

@end
