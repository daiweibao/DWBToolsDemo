//
//  AlretCXSheetView.h
//  AiHenDeChaoXi
//
//  Created by chaoxi on 2018/4/20.
//  Copyright © 2018年 chaoxi科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ActionBlockAtIndex)(NSInteger index);

@interface AlretCXSheetView : UIView
//回调经按钮tage
@property (nonatomic, copy) ActionBlockAtIndex actionBlockAtIndex;

//外部传入的值
@property (nonatomic,strong)UIViewController * controller;//控制器
@property (nonatomic, copy) NSString *titleText;//标题
@property (nonatomic,strong)NSArray * array;//除去取消按钮数组
@property(nonatomic,assign)NSInteger redIndex;//让哪一个按钮变红
@property(nonatomic,assign)BOOL isShow;//是否展示取消按钮
@property (nonatomic, copy) NSString * cancetitle;//取消按钮的标题
@property (nonatomic, assign) NSInteger type;//类型
//创建UI
- (void)setUpContentViewAray:(NSArray*)array;

@end
