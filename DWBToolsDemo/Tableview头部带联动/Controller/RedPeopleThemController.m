//

//  ZuiMeiXinNiang
//
//  Created by 爱淘包 on 16/6/13.
//  Copyright © 2016年 zmxn. All rights reserved.
//

#import "RedPeopleThemController.h"

@interface RedPeopleThemController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,assign)NSInteger currentPage;

@end

@implementation RedPeopleThemController

- (void)viewDidLoad {
    [super viewDidLoad];
     _currentPage = 0;
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    
    [self tableView];

    [self refresh];
    
    
}

//上拉下拉刷新
- (void)refresh {
    //自己封装的MJ刷新
    [DWB_refreshHeader DWB_RefreshHeaderAddview:self.tableView RefreshType:nil refreshHeader:^{
        self.currentPage=0;
      
        [self loadData];
        
    }];
}




- (void)loadData{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self.tableView endRefresh_DWB];
    });
    
}


//tableView懒加载
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-MC_NavHeight-42) style:UITableViewStyleGrouped];
        //iOS11、iPhoneX适配
        [UIView tablevieiOS11:_tableView isHaveTabbar:NO];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        //tableview拖动时收起键盘
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        //去掉cell之间的分割线
        self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        [self.view addSubview:_tableView];
        
    }
    
    return _tableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
    return 30;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.01;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *reuseID = @"UITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    [cell.contentView removeAllSubviews];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
     cell.backgroundColor = RGBA_Random;
    return cell;
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
   
}

@end
