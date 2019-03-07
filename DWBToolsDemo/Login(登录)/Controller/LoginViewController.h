//
//  LoginViewController.h
//  DWBToolsDemo
//
//  Created by 戴维保 on 2019/3/7.
//  Copyright © 2019 潮汐科技有限公司. All rights reserved.
//

#import "CXRootViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface LoginViewController : CXRootViewController

//登录成功的回调
@property(nonatomic,copy)void(^loginSuccessfulAfter)(void);

@end

NS_ASSUME_NONNULL_END
