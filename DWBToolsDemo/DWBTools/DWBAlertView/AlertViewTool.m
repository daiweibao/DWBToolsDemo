//
//  AlertViewTool.m
//  AlertActiionDemo
//
//  Created by Max on 16/8/30.
//  Copyright © 2016年 maxzhang. All rights reserved.
//

#import "AlertViewTool.h"

#import "CXAlretCXSheetView.h"//自己封装的底部弹窗

@implementation AlertViewTool

#pragma mark ==================AlertView=========================
//在中间提示的很多个按钮
+ (id)AlertAlertWithTitle:(NSString*)title Message:(NSString *)message otherItemArrays:(NSArray *)array viewController:(UIViewController *)controller handler:(ActionBlockAtIndex)block{
    
    return [[self alloc] initWithTitleCenter:title Message:message otherItemArrays:array viewController:controller handler:block];
}

//在中间提示的很多个按钮
- (instancetype)initWithTitleCenter:(NSString *)title Message:(NSString*)message otherItemArrays:(NSArray *)array viewController:(UIViewController *)controller handler:(id)sender{
    if ([self init]) {
        
        
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        self.actionBlockAtIndex = sender;
        
        
        if (![array isKindOfClass:[NSNull class]] && array != nil && array.count) {
            for (int i = 0; i < array.count; i++) {
                UIAlertAction *otherAction = [UIAlertAction actionWithTitle:array[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                    if (self.actionBlockAtIndex) {
                        self.actionBlockAtIndex(i);
                    }
                    
                    [alertC dismissViewControllerAnimated:YES completion:nil];
                }];
                [alertC addAction:otherAction];
            }
        }
        [controller presentViewController:alertC animated:YES completion:nil];
    }
    return self;
}



#pragma mark ==================AlertSheetTool=========================

+ (id)AlertSheetToolWithTitle:(NSString*)title Message:(NSString *)message otherItemArrays:(NSArray *)array viewController:(UIViewController *)controller handler:(ActionBlockAtIndex)block isShowCancel:(BOOL)isShow CancelTitle:(NSString*)cancetitle
{
    
    return [[self alloc] initWithCancelTitle:title Message:message otherItemArrays:array viewController:controller handler:block isShowCancel:isShow CancelTitle:cancetitle];
}


- (instancetype)initWithCancelTitle:(NSString *)title Message:(NSString*)message otherItemArrays:(NSArray *)array viewController:(UIViewController *)controller handler:(id)sender isShowCancel:(BOOL)isShowCancel CancelTitle:(NSString *)Cancetitle
{
    if ([self init]) {
        
        
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
        
        //(1)修改标题的内容，字号，颜色。使用的key值是“attributedTitle"  判空，否则崩溃
        if (title.length>0) {
            NSMutableAttributedString *attrTitle = [[NSMutableAttributedString alloc] initWithString:title];
            [attrTitle addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, [[attrTitle string] length])];
            [attrTitle addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#666666"] range:NSMakeRange(0, [[attrTitle string] length])];
            [alertC setValue: attrTitle forKey:@"attributedTitle"];
            
        }
        
        //(2)修改message,判空，否则崩溃
        if (message.length>0) {
            NSMutableAttributedString * attrMessage = [[NSMutableAttributedString alloc] initWithString:message];
            [attrMessage addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#666666"] range:NSMakeRange(0, [[attrMessage string] length])];
            [attrMessage addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, [[attrMessage string] length])];
            [alertC setValue: attrMessage forKey:@"attributedMessage"];
            
        }
        
        self.actionBlockAtIndex = sender;
        
        if (isShowCancel == YES) {
            
            UIAlertAction *cancelAction=[UIAlertAction actionWithTitle:Cancetitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                if (self.actionBlockAtIndex) {
                    self.actionBlockAtIndex(array.count);
                }
                [alertC dismissViewControllerAnimated:YES completion:nil];
            }];
            [alertC addAction:cancelAction];
        
            //修改按钮默认颜色，字体大小无法修改，如果要修改那就要自定义控件了
            [cancelAction setValue:[UIColor colorWithHexString:@"3f69e1"] forKey:@"_titleTextColor"];
            
        }
        
        
        
        
        if (![array isKindOfClass:[NSNull class]] && array != nil && array.count) {
            for (int i = 0; i < array.count; i++) {
                UIAlertAction *otherAction = [UIAlertAction actionWithTitle:array[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                    if (self.actionBlockAtIndex) {
                        self.actionBlockAtIndex(i);
                    }
                    
                    
                    [alertC dismissViewControllerAnimated:YES completion:nil];
                }];
                [alertC addAction:otherAction];
                //修改按钮默认颜色
                [otherAction setValue:[UIColor colorWithHexString:@"3f69e1"] forKey:@"titleTextColor"];
            }
        }
        
        [controller presentViewController:alertC animated:YES completion:nil];
    }
    return self;
}


#pragma mark ================ 用tableview封装的类似微信底部弹窗 =======================
/**
 用tableview封装的类似微信底部弹窗,redIndex为-1表示不显示红色按钮
 
 @param title 标题
 @param array 按钮数组
 @param block 回调block
 @param redIndex 让哪一个按钮变红
 @param cancetitle 取消按钮的汉字，为nil室不显示
 @return aler
 */

+(id)AlertWXSheetToolWithTitle:(NSString*)title otherItemArrays:(NSArray *)array ShowRedindex:(NSInteger )redIndex CancelTitle:(NSString*)cancetitle handler:(ActionBlockAtIndex)block{
    
    return [[self alloc]initWithAlertWXSheetToolWithTitle:title otherItemArrays:array handler:block ShowRedindex:redIndex CancelTitle:cancetitle];
}
//类似微信底部弹窗
- (instancetype)initWithAlertWXSheetToolWithTitle:(NSString*)title otherItemArrays:(NSArray *)array handler:(ActionBlockAtIndex)block ShowRedindex:(NSInteger )redIndex CancelTitle:(NSString*)cancetitle{
    if ([self init]) {
        //弹框是添加到这上面的(找到控件判断，不能存在才创建，防止重复创建)
        UIWindow * WXwindow = [[UIApplication sharedApplication] valueForKey:@"_statusBarWindow"];
        UIView * viewWX = (UIView*)[WXwindow viewWithTag:1314505];
        //控件不存在才创建
        if (viewWX==nil) {
            //创建窗
            JXActionSheet *sheet = [[JXActionSheet alloc] initWithTitle:title cancelTitle:cancetitle otherTitles:array];
            sheet.tag = 1314505;
            sheet.destructiveButtonIndex = redIndex;
            [sheet showView];
            //设置代理
            self.actionBlockAtIndex = block;
            
            [sheet dismissForCompletionHandle:^(NSInteger clickedIndex, BOOL isCancel) {
                if (self.actionBlockAtIndex) {
                    self.actionBlockAtIndex(clickedIndex);
                }
            }];
            
        }
        
    }
    
    return self;
}


@end
