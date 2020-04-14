//
//  LabelHostWordsController.m
//  DWBToolsDemo
//
//  Created by 戴维保 on 2020/4/14.
//  Copyright © 2020 潮汐科技有限公司. All rights reserved.
//

#import "LabelHostWordsController.h"

@interface LabelHostWordsController ()

@end

@implementation LabelHostWordsController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createLabelUI];
}

//创建标签流UI
-(void)createLabelUI{

#pragma mark ============== 标签流布局 S====================
    //父视图
    UIView * labelContentView = [[UIView alloc]init];
    [self.view addSubview:labelContentView];
    
    //标签相对父视图左边距
    CGFloat leftMarginLabel = 10;
    //标签相对父视图顶部距离
    CGFloat topMarginLabel =  0;
    //标签左右间距
    CGFloat horizontalSpace = 10;
    //标签上下间距
    CGFloat verticalSpace = 10;
    //标签的高度
     CGFloat labelHeight = 20;
    

    //下面这几个值不需要做修改
    //最大宽度，超过这个宽度就要换行
    CGFloat windthMax = SCREEN_WIDTH - leftMarginLabel * 2;
    //标签的起始X坐标（下面动态变化）
    CGFloat labelMinX = leftMarginLabel;
    //标签的起始Y坐标（下面动态变化）
    CGFloat labelMimY = topMarginLabel;
    //记录最后一个标签的最大Y，用来布局父视图
    CGFloat lastLabelMaxY = topMarginLabel;

    NSArray * array = @[@"法地方",@"法的鬼地方",@"第的鬼地方",@"法",@"1",@"rewe",@"fdagadgda发到付个人的",@"法地方",@"法的鬼地方",@"第的鬼地方",@"法",@"1",@"rewe",@"f"];
    for (int i = 0; i < array.count; i++) {
        UIButton* labelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [labelButton setTitleColor:[UIColor colorWithHexString:@"#aaaaaa"] forState:UIControlStateNormal];
        [labelButton setTitleColor:MAIN_COLOR forState:UIControlStateSelected];
        //根据文字计算标签的宽度，后面会多加上一点宽度，视情况而定
        NSDictionary * attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:15]};
        CGFloat labelWidth = [array[i] boundingRectWithSize:CGSizeMake(FLT_MAX, FLT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size.width + 20;
        //为标签赋值
        [labelButton setTitle:[NSString stringWithFormat:@"%@",array[i]] forState:UIControlStateNormal];
         //设置标签的frame
        if (labelWidth > windthMax) {//防止一行太长超出屏幕
            labelButton.frame = CGRectMake(labelMinX, labelMimY, windthMax, labelHeight);
        }else{
         labelButton.frame = CGRectMake(labelMinX, labelMimY, labelWidth, labelHeight);
        }
        labelButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 10);//设置内边距
        //当标签的位置超出屏幕边缘时换行（超出限制的最大宽度）
        if(labelMinX + labelWidth + horizontalSpace > windthMax){
            //换行时将w置为起始坐标
            labelMinX = leftMarginLabel;
            //距离父视图也变化
            labelMimY = labelMimY + labelButton.frame.size.height + verticalSpace;
            //重设button的frame
            if (labelWidth > windthMax) {//防止一行太长超出屏幕
                labelButton.frame = CGRectMake(labelMinX, labelMimY, windthMax, labelHeight);
            }else{
                labelButton.frame = CGRectMake(labelMinX, labelMimY, labelWidth, labelHeight);
            }
        }
        //多加的是两个标签之间的水平距离
        labelMinX = labelButton.frame.size.width + labelButton.frame.origin.x + horizontalSpace;
        labelButton.titleLabel.font = [UIFont systemFontOfSize:14];
        labelButton.tag = i+100;
        //标签的点击事件
        [labelButton addTarget:self action:@selector(labelButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [labelContentView addSubview:labelButton];
      
        if (i==array.count-1) {
            //拿到最后一个标签的位置
            lastLabelMaxY = labelButton.bottomY;
        }
        
    }
    
    //布局
    [labelContentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(MC_NavHeight+10);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(lastLabelMaxY);
    }];
#pragma mark ============== 标签流布局 E====================
}

-(void)labelButtonAction:(UIButton *)button{
    
    DWBAlertShow(button.titleLabel.text);
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
