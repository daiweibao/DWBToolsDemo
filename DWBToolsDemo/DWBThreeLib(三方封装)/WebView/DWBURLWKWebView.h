//
//  DWBURLWKWebView.h
//  DouZhuan
//
//  Created by 爱恨的潮汐 on 2018/9/26.
//  Copyright © 2018 品创时代互联网科技（北京）有限公司. All rights reserved.
//
//网址URL
#import <WebKit/WebKit.h>
#import <WebKit/WebKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface DWBURLWKWebView : WKWebView
//KVO获取网页高度回调
@property(nonatomic,copy)void (^WebviewHeight)(CGFloat wheight);
//网页加载完成
@property(nonatomic,copy)void (^webviewFinishLoad)(CGFloat  height);

//block回调，控制器里调用(加载URL)
-(void)htmlWebViewURL:(NSString*)urlString Type:(NSString * _Nullable)typeString htmlHeightKVO:(void (^)(CGFloat webHeight))htmlHeight FinishLoadeEnd:(void (^)(CGFloat endHeight))FinishLoadeEnd;

@end

NS_ASSUME_NONNULL_END
