//
//  KeyChainManager.h
//  AiHenDeChaoXi
//
//  Created by chaoxi on 2018/5/28.
//  Copyright © 2018年 chaoxi科技有限公司. All rights reserved.
//

//Keychain钥匙串存储数据，App卸载后数据也能读取到，也可以用于2个或者多个app之间传值。间书地址：https://www.jianshu.com/p/781f394baf61
#import <Foundation/Foundation.h>

@interface KeyChainManager : NSObject
/*!
 保存数据
 
 @data  要存储的数据
 @identifier 存储数据的标示
 */
+(BOOL) keyChainSaveData:(id)data withIdentifier:(NSString*)identifier ;

/*!
 读取数据
 
 @identifier 存储数据的标示
 */
+(id) keyChainReadData:(NSString*)identifier ;


/*!
 更新数据
 
 @data  要更新的数据
 @identifier 数据存储时的标示
 */
+(BOOL)keyChainUpdata:(id)data withIdentifier:(NSString*)identifier ;

/*!
 删除数据
 
 @identifier 数据存储时的标示
 */
+(void) keyChainDelete:(NSString*)identifier ;

@end
