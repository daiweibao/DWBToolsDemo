//
//  MyCenterSonView.m
//  DWBToolsDemo
//
//  Created by 戴维保 on 2018/11/24.
//  Copyright © 2018 潮汐科技有限公司. All rights reserved.
//

#import "MyCenterSonView.h"
@interface MyCenterSonView()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, copy) void(^scrollCallback)(UIScrollView *scrollView);
//创建tableview
@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,assign)NSInteger currentPage;
@property(nonatomic,strong)NSMutableArray * dataSouce;

//是否是第一次加载
@property (nonatomic, assign) BOOL isDataLoaded;

@end

@implementation MyCenterSonView
-(NSMutableArray *)dataSouce{
    if (!_dataSouce) {
        _dataSouce = [NSMutableArray array];
    }
    return _dataSouce;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //创建tableview
        [self tableView];
        
        [self refresh];
        
        
    }
    return self;
}


// 上拉下拉刷新
- (void)refresh {
    //自己封装的MJ刷新
    [DWB_refreshHeader DWB_RefreshHeaderAddview:self.tableView RefreshType:nil refreshHeader:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self.tableView endRefresh_DWB];
        });
    }];
    
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.tableView.frame = self.bounds;
}


- (void)loadDataForFirst {
    //第一次才加载，后续触发的不处理
    if (!self.isDataLoaded) {
        self.isDataLoaded = YES;
        //数据请求--只能在这里加载
        [self loadCXData];
    }
}


//请求数据
-(void)loadCXData{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.dataSouce removeAllObjects];
        for (int i = 0; i < 30; i++) {
            NSString * str = [NSString randomStringWithLength:20];
            [self.dataSouce addObject:str];
        }
        NSLog(@"加载了数据");
        //结束刷新
        [self.tableView endRefresh_DWB];
        [self.tableView reloadData];
        
    });
}

#pragma mark - UITableViewDataSource, UITableViewDelegate
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
        [self addSubview:_tableView];
        _tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.height);//坐标
        
    }
    
    return _tableView;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSouce.count;
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
    
    static NSString *reuseID = @"UITableViewCellSSC";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.font = [UIFont systemFontOfSize:17];
    
    cell.textLabel.text = self.dataSouce[indexPath.row];
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}





- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    self.scrollCallback(scrollView);
}


#pragma mark - JXPagingViewListViewDelegate

- (UIScrollView *)listScrollView {
    return self.tableView;
}

- (void)listViewDidScrollCallback:(void (^)(UIScrollView *))callback {
    self.scrollCallback = callback;
}

- (UIView *)listView {
    return self;
}
@end
