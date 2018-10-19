//
//  LabelActionController.m
//  DWBToolsDemo
//
//  Created by 戴维保 on 2018/9/12.
//  Copyright © 2018年 北京嗅美科技有限公司. All rights reserved.
//

#import "LabelActionController.h"


@interface LabelActionController ()

@end

@implementation LabelActionController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
       self.titleNavLabel.text = @"点击指定文字";
    
    
    UILabel * label = [[UILabel alloc]init];
    label.frame = CGRectMake(10, 100, 340, 100);
    [self.view addSubview:label];
    
    
    NSString * string1 = @"潮汐";
    NSString * string2 = @"@";
    NSString * string3 = @"潮汐";
    
    label.attributedText = [NSString getLabelChangeColor:[UIColor blueColor] andFont:[UIFont systemFontOfSize:30] andString1:string1 andChangeString:string2 andGetstring3:string3 andISetupSpacing:NO andIShowBottonLine:NO];
//    label.text = [NSString stringWithFormat:@"%@%@%@",string1,string2,string3];
//    点击指定汉子
    [label dwb_addAttributeTapActionWithStrings:@[string1,string3] tapClicked:^(NSString *string, NSRange range, NSInteger index) {
        
//        NSLog(@"点击了变大的内容");
        
        DWBAlertShow(@"点击了中间变大文字");
        NSLog(@"%@==%ld",string,(long)index);
    }];
    
    
    
    UIImageView * imageView = [[UIImageView alloc]init];
    [self.view addSubview:imageView];
    imageView.frame = CGRectMake(10, 300, 100, 100);
//    imageView.backgroundColor = [UIColor redColor];
    imageView.image =  [UIImage imageNamed:@"小黄车"];
    
    [imageView drawCornerRadius:50];
    
    
    
    //html处理文字颜色
    UILabel * labelHtml = [[UILabel alloc]init];
    labelHtml.frame = CGRectMake(10, 500, 340, 100);
    labelHtml.attributedText = [self getLabelAttributedHtmlString:@"我是中国人" AndChooseColor:@[@"我",@"人"]];
    labelHtml.font = [UIFont systemFontOfSize:20];
    labelHtml.numberOfLines = 0;
    [labelHtml sizeToFit];
    [self.view addSubview:labelHtml];
    
    
    
    
}

-(NSAttributedString *)getLabelAttributedHtmlString:(NSString *)htmlString AndChooseColor:(NSArray *)arrayRed{
    
  
    NSString * titleMoneyMunStr = htmlString.copy;
    
    NSString * getEndStr;
    for (int i = 0; i < arrayRed.count; i++) {
        NSString * redText = [arrayRed[i] copy];
        if ([htmlString containsString:redText]) {
            
            NSString * redTextHtml = [NSString stringWithFormat:@"<font color='#e53836'>%@</font>",redText];
            //替换
            getEndStr = [titleMoneyMunStr stringByReplacingOccurrencesOfString:redText withString:redTextHtml];
            titleMoneyMunStr = getEndStr;
        }
    }
    //设置默认背景色为白色
    NSString * stringHtml = [NSString stringWithFormat:@"<font color='#212121'>%@</font>",getEndStr];
    

    //     NSHTMLTextDocumentType设置为HTML类型（必须）
    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[stringHtml dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
    return attrStr;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
