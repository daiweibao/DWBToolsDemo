//
//  CategoryViewController.m
//  DWBToolsDemo
//
//  Created by chaoxi on 2019/3/7.
//  Copyright © 2019 chaoxi科技有限公司. All rights reserved.
//

#import "CategoryViewController.h"

@interface CategoryViewController ()

@end

@implementation CategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.backButton.hidden = YES;
    self.titleNavLabel.text = @"分类";
}


//将要出现
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
  
}
//将要小时
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

-(void)dealloc{
    
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
