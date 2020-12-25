//
//  ViewController.m
//  DWBToolsDemo
//
//  Created by chaoxi on 2018/9/5.
//  Copyright © 2018年 chaoxi科技有限公司. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSDictionary *dataData = @{};//后台返回的数据
    NSDictionary *dict = DWBSafeDic(dataData[@"info"]);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
