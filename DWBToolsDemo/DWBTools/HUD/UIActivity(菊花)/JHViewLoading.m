//
//  JHViewLoading.m
//  XiaoYuanSheQu
//
//  Created by 爱恨的潮汐 on 2016/11/16.
//  Copyright © 2016年 潮汐科技有限公司. All rights reserved.
//

#import "JHViewLoading.h"
#import "Masonry.h"
@implementation JHViewLoading

//创建ActivityIndicatorView
+(void)createActivityIndicatorView:(UIView*)view Type:(NSString *)type{
    
    //创建小菊花
    UIActivityIndicatorView * loadingView = [[UIActivityIndicatorView alloc] init];
    if (type.length>0) {
        //大的
        loadingView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    }else{
        //小的
        loadingView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
    }
    
    //    UIActivityIndicatorViewStyleWhiteLarge 的尺寸是（37，37）
    //    UIActivityIndicatorViewStyleWhite 的尺寸是（22，22）
    view.tag = 56666;
    [view addSubview:loadingView];
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(view);
    }];
}

//开始加载ActivityIndicatorView
+(void)startActivityIndicatorView:(UIView*)view{
    //通过tage找到他
    UIActivityIndicatorView * loadingView = (UIActivityIndicatorView *)[view viewWithTag:56666];
    //结束加载
    [loadingView startAnimating];
}

//结束加载ActivityIndicatorView
+(void)endActivityIndicatorView:(UIView*)view{
    //通过tage找到他
    UIActivityIndicatorView * loadingView = (UIActivityIndicatorView *)[view viewWithTag:56666];
    //结束加载
    [loadingView stopAnimating];
}


@end
