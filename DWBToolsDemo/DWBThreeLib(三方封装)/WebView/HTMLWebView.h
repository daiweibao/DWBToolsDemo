//
//  HTMLWebView.h
//  XiaoYuanSheQu
//
//  Created by 戴维保 on 16/9/9.
//  Copyright © 2016年 潮汐科技有限公司. All rights reserved.
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


/*
 
 
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
 if (indexPath.row == 0) {
 if (self.model.info.length>0) {
 static NSString * reuseID=@"stringnew";
 UITableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:reuseID];
 if (!cell) {
 cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseID];
 if (!self.webView) {
 
 
 #pragma mark ====================调用封装的Webview 加载 html============================
 _webView = [[HTMLWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
 [_webView htmlWebViewHtml:self.model.info Type:nil htmlHeightKVO:^(CGFloat webHeight) {
 
 //                        NSLog(@"网页高度回调");
 
 self.webView.frame = CGRectMake(0, 0, SCREEN_WIDTH, webHeight);
 self.webHeight = webHeight;
 
 [self.tableView reloadData];
 
 } FinishLoadeEnd:^(CGFloat endHeight){
 //                        NSLog(@"网页加载完成");
 
 }];
 
 [cell.contentView addSubview:_webView];
 
 
 }
[cell setSelectionStyle:UITableViewCellSelectionStyleNone];

}

cell.tag = indexPath.row;
return cell;
}else{
    static NSString * reuseID=@"cell";
    UITableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:reuseID];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseID];
        //忽略点击效果
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
    }
    return cell;
}

}else{
    
    static NSString * reuseID=@"goodscell";
    UITableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:reuseID];
    
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseID];
        //忽略点击效果
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    //先移除
    for (UIView * view in cell.subviews) {
        [view removeFromSuperview];
    }
    
    [self createMall:cell];
    
    return cell;
    
}

}

*/
