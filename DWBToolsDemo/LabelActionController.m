//
//  LabelActionController.m
//  DWBToolsDemo
//
//  Created by 戴维保 on 2018/9/12.
//  Copyright © 2018年 潮汐科技有限公司. All rights reserved.
//

#import "LabelActionController.h"


@interface LabelActionController ()

@end

@implementation LabelActionController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
       self.titleNavLabel.text = @"点击指定文字";
    
     self.titleNavLabel.text = @"点击指定 文字";
    UILabel * label = [[UILabel alloc]init];
    label.frame = CGRectMake(10, 100, 340, 100);
//    label.backgroundColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:label];
    
    NSString * string1 = @"雪儿";
     NSString * string2 = nil;
     NSString * string3 = @"爱恨的潮汐";
     NSString * string4 = @"说到：";
     NSString * string5 = @"你在干么呢?";
    
    NSString * dsdsa = @"测试";
    
    
     NSArray * array1 = @[string1,[UIColor redColor],[UIFont systemFontOfSize:12]];
     NSArray * array2 = @[string2,[UIFont boldSystemFontOfSize:20]];
     NSArray * array3 = @[string3];
     NSArray * array4 = @[string4,[UIFont systemFontOfSize:12]];
     NSArray * array5 = @[string5,[UIColor blueColor],[UIFont systemFontOfSize:19]];
    
    NSArray * arrayEnd = @[array1,array2,array3,array4,array5];
    label.attributedText = [NSString getLabelAttributedStringWithALLArray:arrayEnd AndLineSpacing:6 AndIShowBottonLine:YES];
    
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
    labelHtml.font = [UIFont systemFontOfSize:20];
    labelHtml.textColor = [UIColor yellowColor];
    labelHtml.attributedText = [NSString getLabelChangColoerArrayWithText:@"我是a，你是B,我是谁，我是谁999？" AndChangeArray:@[@"ww",@"是",@"B",@"99",@"99"] andChangeFont:[UIFont systemFontOfSize:30] AndChangeColor:[UIColor redColor] AndLineSpacing:10];
    labelHtml.numberOfLines = 0;
    [labelHtml sizeToFit];
    labelHtml.backgroundColor = [UIColor blueColor];
    [self.view addSubview:labelHtml];
    [labelHtml dwb_addAttributeTapActionWithStrings:@[@"是"] tapClicked:^(NSString *string, NSRange range, NSInteger index) {
        DWBAlertShow(@"点击了文字");
    }];
    

    
}

-(void)dealloc{
    NSLog(@"富文本控制器走了dealloc");
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
