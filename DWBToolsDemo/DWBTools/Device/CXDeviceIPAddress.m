//
//  CXDeviceIPAddress.m
//  aaa
//
//  Created by 季文斌 on 2023/8/31.
//  Copyright © 2023 Alibaba. All rights reserved.
//

#import "CXDeviceIPAddress.h"
#import "Reachability.h"//网络

//获取IP地址
#include <ifaddrs.h>
#include <arpa/inet.h>
#include <net/if.h>

#define IOS_CELLULAR    @"pdp_ip0" //未知
#define IOS_WIFI        @"en0"     //wifi
#define IOS_4_3G        @"en2"     //移动网络
#define IOS_VPN         @"utun0"   //vpn
#define IP_ADDR_IPv4    @"ipv4"
#define IP_ADDR_IPv6    @"ipv6"

@implementation CXDeviceIPAddress


/// 获取IP地址
+ (NSString *)getIPAddress{
    //依照这些key，去取出相对应的IP地址 优先获取IPv6
    NSArray *searchArray = @[];
    Reachability *reachability   = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    NetworkStatus status = [reachability currentReachabilityStatus];
    if (status == ReachableViaWiFi) {
        //wifi
        searchArray = @[IOS_WIFI @"/" IP_ADDR_IPv6,
                        IOS_WIFI @"/" IP_ADDR_IPv4,
                        IOS_CELLULAR @"/" IP_ADDR_IPv6,
                        IOS_CELLULAR @"/" IP_ADDR_IPv4 ];
    }else{
        //非wifi都默认是蜂窝移动
        searchArray = @[IOS_CELLULAR @"/" IP_ADDR_IPv6,
                        IOS_CELLULAR @"/" IP_ADDR_IPv4,
                        IOS_WIFI @"/" IP_ADDR_IPv6,
                        IOS_WIFI @"/" IP_ADDR_IPv4 ];
    }
    
    __block NSDictionary *addresses = [self getIPAddressArray];
    DebugLog(@"获取到的整个IP信息addresses: %@", addresses);
    __block NSString *address;
    [searchArray enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL *stop)
    {
         address = addresses[key];
         if ([key rangeOfString:@"ipv6"].length > 0  && ![[NSString stringWithFormat:@"%@",addresses[key]] hasPrefix:@"(null)"] ) {
             if ( ![addresses[key] hasPrefix:@"fe80"]) {
                 DebugLog(@"是ivp6，退出循环，打印当前IP:%@",address);
                 *stop = YES;
              }
         }else{
             if([self isValidatIP:address]) {
                 DebugLog(@"是ivp4，退出循环，打印当前IP:%@",address);
                 *stop = YES;
             }
         }
     } ];
    return address ? address : @"";
}

/// 获取IP相关信息
+ (NSDictionary *)getIPAddressArray{
    NSMutableDictionary *addresses = [NSMutableDictionary dictionaryWithCapacity:8];
    // retrieve the current interfaces - returns 0 on success
    struct ifaddrs *interfaces;
    if(!getifaddrs(&interfaces)) {
        // Loop through linked list of interfaces
        struct ifaddrs *interface;
        for(interface=interfaces; interface; interface=interface->ifa_next) {
            if(!(interface->ifa_flags & IFF_UP) /* || (interface->ifa_flags & IFF_LOOPBACK) */ ) {
                continue; // deeply nested code harder to read
            }
            const struct sockaddr_in *addr = (const struct sockaddr_in*)interface->ifa_addr;
            char addrBuf[ MAX(INET_ADDRSTRLEN, INET6_ADDRSTRLEN) ];
            if(addr && (addr->sin_family==AF_INET || addr->sin_family==AF_INET6)) {
                NSString *name = [NSString stringWithUTF8String:interface->ifa_name];
                NSString *type;
                if(addr->sin_family == AF_INET) {
                    if(inet_ntop(AF_INET, &addr->sin_addr, addrBuf, INET_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv4;
                    }
                } else {
                    const struct sockaddr_in6 *addr6 = (const struct sockaddr_in6*)interface->ifa_addr;
                    if(inet_ntop(AF_INET6, &addr6->sin6_addr, addrBuf, INET6_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv6;
                    }
                }
                if(type) {
                    NSString *key = [NSString stringWithFormat:@"%@/%@", name, type];
                    addresses[key] = [NSString stringWithUTF8String:addrBuf];
                }
            }
        }
        // Free memory
        freeifaddrs(interfaces);
    }
    return [addresses count] ? addresses : nil;
}

/// 判断当前网络IP是否是Ipv4,如果是YES  否则NO
/// @param ipAddress ip地址
+ (BOOL)isValidatIP:(NSString *)ipAddress {
    if (ipAddress.length == 0) {
        return NO;
    }
    NSString *urlRegEx = @"^([01]?\\d\\d?|2[0-4]\\d|25[0-5])\\."
    "([01]?\\d\\d?|2[0-4]\\d|25[0-5])\\."
    "([01]?\\d\\d?|2[0-4]\\d|25[0-5])\\."
    "([01]?\\d\\d?|2[0-4]\\d|25[0-5])$";
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:urlRegEx options:0 error:&error];
    if (regex != nil) {
        NSTextCheckingResult *firstMatch=[regex firstMatchInString:ipAddress options:0 range:NSMakeRange(0, [ipAddress length])];
        if (firstMatch) {
            NSRange resultRange = [firstMatch rangeAtIndex:0];
            NSString *result=[ipAddress substringWithRange:resultRange];
            DebugLog(@"%@",result);
            return YES;
        }
    }
    return NO;
}



@end
