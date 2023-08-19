//
//  MacroHeaderHeader.h
//  DWBToolsDemo
//
//  Created by 爱恨的潮汐 on 2018/9/11.
//  Copyright © 2018年 潮汐科技有限公司. All rights reserved.
//

#ifndef MacroHeaderHeader_h
#define MacroHeaderHeader_h

static NSString * const TestString = @"测试";


#pragma mark ===============项目相关 S ==================
//取出用户ID
#define USERID [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"member_uid"]]
//取出用户昵称
#define USER_name [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"alias"]]
//取出用户头像连接
#define USER_PhoneImage [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"headPortrait"]]



//默认头像图片名字
#define default_HeaderImage @"person_head_default"
//默认图片（横向封面图）
#define default_CoverImage @"mall_banner_ default"

#pragma mark ===============项目相关 E ==================




#endif /* MacroHeaderHeader_h */
