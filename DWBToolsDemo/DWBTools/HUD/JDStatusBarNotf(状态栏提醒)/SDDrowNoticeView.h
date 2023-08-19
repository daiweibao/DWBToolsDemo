//
//  SDDrowNoticeView.h
//  XiaoYuanSheQu
//
//  Created by 爱恨的潮汐 on 2017/9/28.
//  Copyright © 2017年 潮汐科技有限公司. All rights reserved.
//

//
//  SDDrowNoticeView.h
//  SDDrowNoticeView
//
//  Created by tianNanYiHao on 2017/7/28.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//  仿下拉通知view

#import <UIKit/UIKit.h>

@interface SDDrowNoticeView : UIView

/**
 状态栏提醒，背景黑色，传入标题就可以，适配iPhoneX用的

 @param title 标题
 */
+(void)showJDStatusBarMySelfIPhoneX:(NSString*)title;

@end
