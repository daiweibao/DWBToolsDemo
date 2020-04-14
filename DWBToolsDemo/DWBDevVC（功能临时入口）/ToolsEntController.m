//
//  ToolsEntController.m
//  DWBToolsDemo
//
//  Created by 戴维保 on 2018/9/8.
//  Copyright © 2018年 潮汐科技有限公司. All rights reserved.
//

#import "ToolsEntController.h"
#import "LabelActionController.h"

#import "DWBAPPManager.h"

#import "MyCenterMainController.h"

#import "RedpeopleCenterController.h"


#import "DWBJXMainController.h"

//视频详情，横屏
#import "VideoDetailsController.h"
#import "YYTextViewController.h"

#import "CXWebViewController.h"

#import "NSObject+Test.h"

#import "MNPerson.h"
#import "LabelHostWordsController.h"
#define MIN(A,B) (A) < (B) ? (A) : (B)

@interface ToolsEntController ()<UITableViewDelegate,UITableViewDataSource>
//创建tableview
@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,assign)NSInteger currentPage;

@property (strong,nonatomic)  NSString *rStr;
@property (copy, nonatomic)  NSString *cStr;

@property (nonatomic, strong) NSString *now;



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
    
  
   
//    [self testGCD];
    
    
//    //在控制器里调用打印如下
//
//    [NSObject test1];//打印bbb
//
//     [ClassA test1];//打印bbb
//
//    [[[NSObject alloc]init]  test];//打印aaa
//
//    [[[ClassA alloc]init]  test];//打印aaa
    
//
//    float a = 1.0;
//
//    float b = MIN(a++, 1.5);
//
//    NSLog(@"a===%f,b==%f",a,b);
    
//    (a++) < (1.5) ? (a++) : (1.5)
    
    

    
    
//    [self syncMain];
    
//    _now = @"12";
//
//    [self addObserver:self forKeyPath:@"now" options:NSKeyValueObservingOptionNew context:nil];
//
//     _now = @"120";
//
//    NSLog(@"1");
//    [self willChangeValueForKey:@"now"];//手动触发self.now的KVO，必写。
//    NSLog(@"2");
//    [self didChangeValueForKey:@"now"];//手动触发self.now的KVO，必写。
//    NSLog(@"4");
    
    
    NSLog(@"得到字符串：%@",[self getString]);//打印：h
    id cls = [MNPerson class];
    void * obj = &cls;
    [(__bridge id)obj print];
    
    
    UIView * d;
   
    
   
}

-(NSString *)getString{
    return (__bridge NSString*)CFStringCreateWithCString(NULL, "你好\ndd%h", kCFStringEncodingUTF8);
}


//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
//    NSLog(@"3");
//}


//执行顺序
- (void)syncMain{
    dispatch_queue_t queue = dispatch_queue_create("serial", nil);
    dispatch_async(queue, ^(void){
        NSLog(@"1");
    });
   
    dispatch_sync(queue, ^(void){
        NSLog(@"2");
    });
    dispatch_async(queue, ^(void){
        NSLog(@"3");
        dispatch_sync(queue, ^(void){
            NSLog(@"4");
        });

    });
   
}







/**
 是否有网，返回NO代表没网，YES有网
 
 @return 结果
 */
+ (BOOL)isNetwork {
    return [AFNetworkReachabilityManager sharedManager].reachable;
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
        NSLog(@"%f",MC_NavHeight);
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
    }else if (indexPath.row==1) {
        cell.textLabel.text = @"一行代码实现label点击指定文字";
    }else if (indexPath.row==2) {
        NSString * str = @"【YYLabel】YYTextViewController";
        cell.textLabel.text = str;
    }else if (indexPath.row==3) {
        NSString * str = @"多个tableview上下左右可拖动";
        cell.textLabel.text = str;
    }else if (indexPath.row==4) {
       
        cell.textLabel.text = @"push到swift";
    }else if (indexPath.row==5) {
        
        cell.textLabel.text = @"红人个人中心";
    }else if (indexPath.row==6) {
        
        cell.textLabel.text = @"网络请求";
        
    }else if (indexPath.row==7) {
        
        cell.textLabel.text = @"自定义滚动头Base";
    }else if (indexPath.row==8) {
        
        cell.textLabel.text = @"H5";
    }else if (indexPath.row==9) {
        cell.textLabel.font = [UIFont boldSystemFontOfSize:20];
        cell.textLabel.textColor = COLOR_Main;
        cell.textLabel.text = @"赋值字符串，比如微信登录";
    }else if (indexPath.row==10) {
        
        cell.textLabel.text = @"底部aleat";
    }else if (indexPath.row==11) {
        
        cell.textLabel.text = @"控制器模态";
    }else if (indexPath.row==12) {
        
        cell.textLabel.text = @"流布局标签";
    }
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        
    }else if (indexPath.row==1){
        LabelActionController * VC = [[LabelActionController alloc]init];
        [self.navigationController pushViewController:VC animated:YES];
    }else if (indexPath.row==2){
        YYTextViewController * VC = [[YYTextViewController alloc]init];
        [self.navigationController pushViewController:VC animated:YES];
       
    }else if (indexPath.row==3){
        MyCenterMainController * VC = [[MyCenterMainController alloc]init];
        [self.navigationController pushViewController:VC animated:YES];
    }else if (indexPath.row==4){
        //push到swift
        DWBSwiftTestController * VC = [[DWBSwiftTestController alloc]init];
        [self.navigationController pushViewController:VC animated:YES];
        
    }else if (indexPath.row==5){
        RedpeopleCenterController * VC = [[RedpeopleCenterController alloc]init];
        [self.navigationController pushViewController:VC animated:YES];
    }else if (indexPath.row==6){
        //请求数据
        [self loadData];
        
    }else if (indexPath.row==7){
        DWBJXMainController * VC = [[DWBJXMainController alloc]init];
        [self.navigationController pushViewController:VC animated:YES];
    }else if (indexPath.row==8){
       
      
//        http://getimageonline.xyz/csb
        
        CXWebViewController * VC = [[CXWebViewController alloc]init];
        VC.urlWebStr = @"http://getimageonline.xyz/csb";
        [self.navigationController pushViewController:VC animated:YES];
        
        
      
        
    }else if (indexPath.row==9){
        //只是
        [NSString copyCXString:@"wxcc077fbc97d571f0://wapoauth?m=Kzg2MTc2MTEzMDIzMDg%3D&t=636136"];
        [MBProgressHUD showSuccess:@"复制成功"];
        
    }else if (indexPath.row==10){
    
        [DWBSystemAlertSheet AlertMySystemAlertSheetWithTitle:@"" otherItemArrays:@[@"确定",@"删除"] ShowRedindex:-1 isShowCancel:YES CancelTitle:@"取消了" Type:-1 handler:^(NSInteger index) {
            NSLog(@"点击角标：%ld",(long)index);
            
        }];
    }else if(indexPath.row==11){
        //模态
        VideoDetailsController * VC = [[VideoDetailsController alloc]init];
        [self presentViewController:VC animated:YES completion:nil];
    }else if(indexPath.row==12){
        
        LabelHostWordsController * VC = [[LabelHostWordsController alloc]init];
         [self.navigationController pushViewController:VC animated:YES];
    }
}


//请求数据
- (void)loadData {
    //请求数据
    NSDictionary * dict = @{@"platform":@{}};//这个要传才能请求到
    [DWBAFNetworking POST:DWBPromotion parameters:dict controller:self type:nil success:^(id  _Nullable responseObject) {
        NSLog(@"数据：%@",responseObject);
        
    } failure:^(NSError * _Nullable error) {
        NSLog(@"请求数据失败");
    }];
}


//将要出现
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
//将要消失
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    
    
}


//控制器pop的时候走这里
- (void)didMoveToParentViewController:(UIViewController*)parent{
    [super didMoveToParentViewController:parent];
    //    NSLog(@"%s,%@",__FUNCTION__,parent);
    if(!parent){
        NSLog(@"测试页面pop成功了");
    }
}

-(void)dealloc{
    NSLog(@"测试控制器走了dealloc");
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
