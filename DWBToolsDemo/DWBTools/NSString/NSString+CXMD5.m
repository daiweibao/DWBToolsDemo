//
//  NSString+CXMD5.m
//  AiHenDeChaoXi
//
//  Created by 爱恨的潮汐 on 2018/3/19.
//  Copyright © 2018年 潮汐科技有限公司. All rights reserved.
//

#import "NSString+CXMD5.h"
#import <CommonCrypto/CommonDigest.h>//加密要用到的头文件
@implementation NSString (CXMD5)
//加密后是大写字母
- (NSString *)MD5Hash
{
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result);
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]];
}

//加密后是小写字母
+ (NSString *)md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

//sha1 encode 加密，就是sha1，不是sha
+(NSString*) sha1:(NSString *)str{
    const char *cstr = [str cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:str.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (unsigned int)data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}


/**
 获取视频等大文件的MD5
 
 @param asset 视频的ALAsset
 @return MD5
 */
+(NSString *)fileMD5WithAsset:(ALAsset *)asset
{
    if (!asset) {
        return nil;
    }
    
    ALAssetRepresentation *rep = [asset defaultRepresentation];
    unsigned long readStep = 256;
    uint8_t *buffer = calloc(readStep, sizeof(*buffer));
    unsigned long long offset = 0;
    unsigned long long bytesRead = 0;
    NSError *error = nil;
    unsigned long long fileSize = [rep size];
    int chunks = (int)((fileSize + readStep - 1)/readStep);
    unsigned long long lastChunkSize = fileSize%readStep;
    
    CC_MD5_CTX md5;
    CC_MD5_Init(&md5);
    BOOL isExp = NO;
    int currentChunk = 0;
    while(!isExp && currentChunk < chunks){
        @try {
            if(currentChunk < chunks - 1){
                bytesRead = [rep getBytes:buffer fromOffset:offset length:(unsigned long)readStep error:&error];
            }else{
                bytesRead = [rep getBytes:buffer fromOffset:offset length:(unsigned long)lastChunkSize error:&error];
            }
            NSData * fileData = [NSData dataWithBytesNoCopy:buffer length:(unsigned long)bytesRead freeWhenDone:NO];
            CC_MD5_Update(&md5, [fileData bytes], (CC_LONG)[fileData length]);
            offset += readStep;
        } @catch(NSException * exception) {
            isExp = YES;
            free(buffer);
        }
        currentChunk += 1;
    }
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5_Final(digest, &md5);
    NSString * s = [NSString stringWithFormat: @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                    digest[0], digest[1],
                    digest[2], digest[3],
                    digest[4], digest[5],
                    digest[6], digest[7],
                    digest[8], digest[9],
                    digest[10], digest[11],
                    digest[12], digest[13],
                    digest[14], digest[15]];
    return s;
}
@end
