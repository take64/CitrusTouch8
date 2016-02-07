//
//  CTNetwork.m
//  LorsPOS
//
//  Created by take64 on 12/01/14.
//  Copyright (c) 2012年 citrus.tk. All rights reserved.
//

#import "CTNetwork.h"


#include <ifaddrs.h>
#include <arpa/inet.h>
#include <netinet/in.h>
#include <net/if.h>
#include <sys/socket.h>
#include <SystemConfiguration/SystemConfiguration.h>

@implementation CTNetwork

// デバイスのIPアドレスを取得
+ (NSString *) ipAddressV4
{
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0; 
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces); 
    if (success == 0) { 
        // Loop through linked list of interfaces 
        temp_addr = interfaces; 
        while(temp_addr != NULL) 
        {
            if(temp_addr->ifa_addr->sa_family == AF_INET)
            {
                // Check if interface is en0 which is the wifi connection on the iPhone 
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"])
                {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory 
    freeifaddrs(interfaces);
    
    return address;
}

// 渡された文字列がIPアドレスの形式か？
+ (BOOL) isIPAddressString:(NSString *)ipAddress;
{
    NSString *pattern = @"^([0-9]|[01]?[0-9]{2}|2[0-4][0-9]|25[0-5])\\.([0-9]|[01]?[0-9]{2}|2[0-4][0-9]|25[0-5])\\.([0-9]|[01]?[0-9]{2}|2[0-4][0-9]|25[0-5])\\.([0-9]|[01]?[0-9]{2}|2[0-4][0-9]|25[0-5])$";
    if([CTRegexp matchOfPattern:pattern context:ipAddress] == 1)
    {
        return YES; 
    }
    else
    {
        return NO;
    }
}


// ローカルWIFIに接続しているか？
+ (BOOL) isConnectionLocalWIFI
{
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    BOOL result = NO;
    if(getifaddrs(&interfaces) != 0)
    {
        return NO;
    }
    // Loop through linked list of interfaces 
    temp_addr = interfaces; 
    while(temp_addr != NULL) 
    {
        if(temp_addr->ifa_addr->sa_family == AF_INET && !(temp_addr->ifa_flags & IFF_LOOPBACK))
        {
            if (strcmp(temp_addr->ifa_name, "en0") == 0)
            {
                result = YES;
            }
        }
        temp_addr = temp_addr->ifa_next;
    }
    // Free memory 
    freeifaddrs(interfaces);
    
    return result;
}

// IPアドレス文字列の取得
+ (NSString *)ipAddressWithData:(NSData *)dataValue
{
    NSString *ipAddress = @"";
    
    char buffer[256];
    
    // ip v4
    if([dataValue length] == 16)
    {
        struct sockaddr *socketAddress = (struct sockaddr *)[dataValue bytes];
        
        if (inet_ntop(AF_INET, &((struct sockaddr_in *)socketAddress)->sin_addr, buffer, sizeof(buffer))) {
            ipAddress = [NSString stringWithCString:buffer encoding:NSASCIIStringEncoding];
        }
        
    }
    // ip v6
    else if([dataValue length] == 28)
    {
        struct sockaddr *socketAddress = (struct sockaddr *)[dataValue bytes];
        
        if (inet_ntop(AF_INET6, &((struct sockaddr_in6 *)socketAddress)->sin6_addr, buffer, sizeof(buffer))) {
            ipAddress = [NSString stringWithCString:buffer encoding:NSASCIIStringEncoding];
        }
        
        
    }
    return ipAddress;
}
@end
