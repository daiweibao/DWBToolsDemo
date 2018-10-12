//
//  ToolsEntController.m
//  DWBToolsDemo
//
//  Created by 戴维保 on 2018/9/8.
//  Copyright © 2018年 北京嗅美科技有限公司. All rights reserved.
//

#import "ToolsEntController.h"
#import "LabelActionController.h"
@interface ToolsEntController ()<UITableViewDelegate,UITableViewDataSource>
//创建tableview
@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,assign)NSInteger currentPage;

@end

@implementation ToolsEntController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.currentPage = 0;
    
    self.titleNavLabel.text = @"功能入口控制器";
    
    //创建tableview
    [self tableView];
    
    //刷新加载
    [self refresh];
    

    
    NSString * getStr = [KeyChainManager keyChainReadData:@"chaoxidwb"];
    
    NSLog(@"读取数据：%@",getStr);
    
    
    
    
    
}



// 上拉下拉刷新
- (void)refresh {
    //自己封装的MJ刷新
    [DWB_refreshHeader DWB_RefreshHeaderAddview:self.tableView RefreshType:nil refreshHeader:^{
        self.currentPage = 0;
        //数据请求
        [self loadCXData];
    }];
    
    //自己封装的MJ加载
    [DWB_refreshFooter DWB_RefreshFooterAddview:self.tableView refreshFooter:^{
        _currentPage++;
        //数据请求
        [self loadCXData];
    }];
}


//请求数据
-(void)loadCXData{
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        //结束刷新
        [self.tableView endRefresh_DWB];
    });
}

//tableView懒加载
- (UITableView *)tableView {
    if (!_tableView) {
        //        CGRectMake(0, MC_NavHeight, SCREEN_WIDTH, SCREEN_HEIGHT-MC_NavHeight)
        _tableView=[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        //iOS11、iPhoneX适配
        [UIView tablevieiOS11:_tableView isHaveTabbar:NO];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        //tableview拖动时收起键盘
        //        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        //去掉分割线
        //        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        
        [self.view addSubview:_tableView];
        
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.view);
            make.top.mas_equalTo(self.view).offset(MC_NavHeight);
            make.right.mas_equalTo(self.view);
            make.bottom.mas_equalTo(self.view).offset(0);
        }];
        
    }
    
    return _tableView;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 44;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.01;
}

//脚
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //关闭缓存
    UITableViewCell * cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    /* 忽略点击效果 */
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    if (indexPath.row==0) {
        cell.textLabel.text = @"功能1";
    } if (indexPath.row==1) {
        cell.textLabel.text = @"一行代码实现label点击指定文字";
    }
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        
    }else if (indexPath.row==1){
        LabelActionController * VC = [[LabelActionController alloc]init];
        [self.navigationController pushViewController:VC animated:YES];
        
    }
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
