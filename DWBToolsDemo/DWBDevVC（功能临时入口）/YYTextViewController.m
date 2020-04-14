//
//  YYTextViewController.m
//  DWBToolsDemo
//
//  Created by 戴维保 on 2020/4/14.
//  Copyright © 2020 潮汐科技有限公司. All rights reserved.
//

#import "YYTextViewController.h"
#import <YYText/YYText.h>
@interface YYTextViewController ()
@property (nonatomic , strong)   YYLabel *yyLabel;
@property (nonatomic , assign) BOOL isSelect;
@end

@implementation YYTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _yyLabel = [[YYLabel alloc]initWithFrame:CGRectMake(20, 100, self.view.bounds.size.width - 40, 40)];
       _yyLabel.textVerticalAlignment = YYTextVerticalAlignmentCenter;
       _yyLabel.textAlignment = NSTextAlignmentCenter;
       [self.view addSubview:_yyLabel];
       [self protocolIsSelect:NO];
}
- (void)protocolIsSelect:(BOOL)isSelect{
    //设置整段字符串的颜色
    UIColor *color = self.isSelect ? [UIColor blackColor] : [UIColor lightGrayColor];
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Regular" size:12], NSForegroundColorAttributeName: color};
    NSString *fff1 =@"  注册即表示同意《用户协议》和《隐私政策》";
    NSString *fff1Son =@"《用户协议》";
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:fff1 attributes:attributes];
    [text yy_setFont:[UIFont boldSystemFontOfSize:16] range:[fff1 rangeOfString:fff1Son]];
    //设置指定内容背景色
//    [text yy_setBackgroundColor:[UIColor redColor] range:[fff1 rangeOfString:fff1Son]];
    
    //设置指定内容圆角和背景色
    YYTextBorder *border = [YYTextBorder new];
    border.cornerRadius = 10;//圆角
    border.strokeWidth = 0.5;//边框宽度
    border.strokeColor = [UIColor blackColor];//边框颜色
    border.insets = UIEdgeInsetsMake(-5, -5, -5, -5);//边框放大
    border.lineStyle = YYTextLineStyleSingle;//边框样式
    border.fillColor = [UIColor orangeColor];//边框里面填充色
    [text yy_setTextBackgroundBorder:border range:[fff1 rangeOfString:fff1Son]];
  
//    NSShadow *shadow = [NSShadow new];
//    shadow.shadowBlurRadius = 5;
//    [text yy_setShadow:shadow range:[fff1 rangeOfString:fff1Son]];
    
    //设置高亮色和点击事件
    [text yy_setTextHighlightRange:[fff1 rangeOfString:@"《用户协议》"] color:[UIColor greenColor] backgroundColor:[UIColor clearColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        NSLog(@"点击了《用户协议》");
        DWBAlertShow(@"点击了《用户协议》")
    }];
    //设置高亮色和点击事件
    [text yy_setTextHighlightRange:[[text string] rangeOfString:@"《隐私政策》"] color:[UIColor orangeColor] backgroundColor:[UIColor clearColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        NSLog(@"点击了《隐私政策》");
         DWBAlertShow(@"点击了《隐私政策》")

    }];
    //添加图片
    UIImage *image = [UIImage imageNamed:self.isSelect == NO ? @"unSelectIcon" : @"selectIcon"];
    NSMutableAttributedString *attachment = [NSMutableAttributedString yy_attachmentStringWithContent:image contentMode:UIViewContentModeCenter attachmentSize:CGSizeMake(12, 12) alignToFont:[UIFont fontWithName:@"PingFangSC-Regular"  size:12] alignment:(YYTextVerticalAlignment)YYTextVerticalAlignmentCenter];
    //将图片放在最前面
    [text insertAttributedString:attachment atIndex:0];
    //添加图片的点击事件
    [text yy_setTextHighlightRange:[[text string] rangeOfString:[attachment string]] color:[UIColor clearColor] backgroundColor:[UIColor clearColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        __weak typeof(self) weakSelf = self;
        weakSelf.isSelect = !weakSelf.isSelect;
        [weakSelf protocolIsSelect:self.isSelect];
         DWBAlertShow(@"点击了图片")
        
    }];
    _yyLabel.attributedText = text;
    //居中显示一定要放在这里，放在viewDidLoad不起作用
    _yyLabel.textAlignment = NSTextAlignmentCenter;

}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
