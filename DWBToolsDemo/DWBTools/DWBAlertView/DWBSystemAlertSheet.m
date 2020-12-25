//
//  DWBSystemAlertSheet.m
//  DWBToolsDemo
//
//  Created by chaoxi on 2020/1/2.
//  Copyright © 2020 chaoxi科技有限公司. All rights reserved.
//

#import "DWBSystemAlertSheet.h"

@implementation DWBSystemAlertSheet

+ (void)AlertMySystemAlertSheetWithTitle:(NSString*)title otherItemArrays:(NSArray *)array ShowRedindex:(NSInteger )redIndex isShowCancel:(BOOL)isShow CancelTitle:(NSString*)cancetitle Type:(NSInteger)type handler:(void(^)(NSInteger index))blockAlert{
    if ([NSString isNULL:title]) {
        title = nil;
    }
    //创建弹窗
    UIAlertController *actionSheetController = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    for (int i = 0; i < array.count; i++) {
        [actionSheetController addAction:[UIAlertAction actionWithTitle:array[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            blockAlert(i);
        }]];
    }
    if (isShow==YES) {
        //取消样式
        [actionSheetController addAction:[UIAlertAction actionWithTitle:cancetitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            blockAlert(array.count);
        }]];
    }
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:actionSheetController animated:true completion:nil];
    
    
}

@end
