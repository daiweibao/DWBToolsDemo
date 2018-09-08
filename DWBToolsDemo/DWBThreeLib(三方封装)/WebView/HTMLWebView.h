//
//  HTMLWebView.h
//  XiaoYuanSheQu
//
//  Created by 戴维保 on 16/9/9.
//  Copyright © 2016年 北京嗅美科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface HTMLWebView : WKWebView

//KVO获取网页高度回调
@property(nonatomic,copy)void (^WebviewHeight)(CGFloat wheight);
//网页加载完成
@property(nonatomic,copy)void (^webviewFinishLoad)(CGFloat  height);

//block回调，控制器里调用
-(void)htmlWebViewHtml:(NSString*)stringhtml Type:(NSString*)typeString htmlHeightKVO:(void (^)(CGFloat webHeight))htmlHeight FinishLoadeEnd:(void (^)(CGFloat endHeight))FinishLoadeEnd;

@end
