//
//  CXUUIDHelp.m
//  ZuiMeiXinNiang
//
//  Created by 爱恨的潮汐 on 2017/3/27.
//  Copyright © 2017年 zmxn. All rights reserved.
//

#import "CXUUIDHelp.h"

#define  KEY_USERNAME_PASSWORD @"com.company.app.usernamepassword"
//#define  KEY_USERNAME @"com.company.app.username"
//#define  KEY_PASSWORD @"com.company.app.password"

@implementation CXUUIDHelp


+ (NSMutableDictionary *)getKeychainQuery:(NSString *)service {
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
            (id)kSecClassGenericPassword,(id)kSecClass,
            service, (id)kSecAttrService,
            service, (id)kSecAttrAccount,
            (id)kSecAttrAccessibleAfterFirstUnlock,(id)kSecAttrAccessible,
            nil];
}

//将该uuid保存到keychain钥匙串
+ (void)save:(NSString *)service data:(id)data {
    //Get search dictionary
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    //Delete old item before add new item
    SecItemDelete((CFDictionaryRef)keychainQuery);
    //Add new object to search dictionary(Attention:the data format)
    [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:data] forKey:(id)kSecValueData];
    //Add item to keychain with the search dictionary
    SecItemAdd((CFDictionaryRef)keychainQuery, NULL);
}


//读取保存的UUID
+ (id)load:(NSString *)service {
    id ret = nil;
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    //配置搜索设置
    //因为在我们简单的例子中，我们只期望返回一个属性(密码)，所以可以将属性kSecReturnData设置为kCFBooleanTrue
    [keychainQuery setObject:(id)kCFBooleanTrue forKey:(id)kSecReturnData];
    [keychainQuery setObject:(id)kSecMatchLimitOne forKey:(id)kSecMatchLimit];
    CFDataRef keyData = NULL;
    if (SecItemCopyMatching((CFDictionaryRef)keychainQuery, (CFTypeRef *)&keyData) == noErr) {
        @try {
            ret = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge NSData *)keyData];
        } @catch (NSException *e) {
            NSLog(@"Unarchive of %@ failed: %@", service, e);
        } @finally {
        }
    }
    if (keyData)
        CFRelease(keyData);
    return ret;
}

//删除存储的UUID
//+ (void)deleteKeyData:(NSString *)service {
//    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
//    SecItemDelete((CFDictionaryRef)keychainQuery);
//}


/**
 得到UUID

 @return 卸载后也不回变的UUID
 */
+(NSString *)getUUID
{
    NSString * strUUID = (NSString *)[CXUUIDHelp load:KEY_USERNAME_PASSWORD];
    
    //首次执行该方法时，uuid为空
    if ([strUUID isEqualToString:@""] || !strUUID)
    {
        //生成一个uuid的方法
        CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
        
        strUUID = (NSString *)CFBridgingRelease(CFUUIDCreateString (kCFAllocatorDefault,uuidRef));
        
        //将该uuid保存到keychain钥匙串
        [CXUUIDHelp save:KEY_USERNAME_PASSWORD data:strUUID];
        
    }
//    NSLog(@"卸载后也不回变得UUID：%@",strUUID);
    return strUUID;
}


@end

