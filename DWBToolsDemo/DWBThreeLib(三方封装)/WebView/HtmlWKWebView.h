//
//  HtmlWKWebView.h
//  XiaoYuanSheQu
//
//  Created by chaoxi on 2017/3/31.
//  Copyright © 2017年 chaoxi科技有限公司. All rights reserved.
//

/*
  (1)适用于HTML解析和网页链接的解析，不适用与与JS的交互，因为代理方法控制器里不走，除非重写代理方法
  (2)WKWebView的封装所有属性,包括进度条、长按保存图片、图片自适应手机、WKWebView的头部控件、尾部控件
 （3）使用时一定要先设置完头部和尾部控件，在开始加载网页
*/
#import <WebKit/WebKit.h>

@interface HtmlWKWebView : WKWebView

//wkWebview网页
@property(nonatomic,strong)WKWebView * wkWebview;

//头部视图
@property(nonatomic,strong)UIView * headerView;
//尾部视图
@property(nonatomic,strong)UIView * footView;

//HTML
@property(nonatomic,strong)NSString * htmlString;

//移除KVO
@property(nonatomic,strong)NSString * remoDeallocKvo;


//与JS有交互的WKWebViewConfiguration不会走Init方法需要手动调用创建UI
@property(nonatomic,strong)NSString * actionJS;


@end
