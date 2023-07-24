//
//  DragEnableButton.h
//  ZuiMeiXinNiang
//
//  Created by 戴维保 on 2016/12/22.
//  Copyright © 2016年 zmxn. All rights reserved.
//

#import <UIKit/UIKit.h>
//必须用继承，不能用拓展类，否则会影响全局
@interface DragEnableButton : UIButton
/**
 button的拖拽
 */
@property(nonatomic,assign,getter = isDragEnable)   BOOL dragEnable;
/**
 button的吸附
 */
@property(nonatomic,assign,getter = isAdsorbEnable) BOOL adsorbEnable;




@property(nonatomic,strong) UITableView *TableView;

@end
