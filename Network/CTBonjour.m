//
//  CTBonjour.m
//  Bonjour
//
//  Created by take64 on 2014/02/16.
//  Copyright (c) 2014年 citrus.tk. All rights reserved.
//

#import "CTBonjour.h"

@implementation CTBonjour

// サービス名を取得
+ (NSString *) callServiceNameFromName:(NSString *)serviceName
{
    static NSDictionary *serviceNameDic;
    if(serviceNameDic == nil)
    {
        serviceNameDic = @{
                           @"smb"           :@"Server Message Block over TCP/IP",
                           @"ldap"          :@"Lightweight Directory Access Protocol",
                           @"od-master"     :@"OpenDirectory Master",
                           @"apple-sasl"    :@"Apple Password Server",
                           @"osxsvr"        :@"Mac OS X Server",
                           @"servermgr"     :@"Mac OS X Server Admin",
                           @"workstation"   :@"Workgroup Manager",
                           @"net-assistant" :@"Apple Remote Desktop",
                           @"adisk"         :@"Automatic Disk Discovery",
                           @"sleep-proxy"   :@"Sleep Proxy Server",
//                           @"acp-sync"      :@"acp-sync",
                           @"airport"       :@"AirPort Base Station",
                           @"afpovertcp"    :@"Apple File Sharing",
                           @"ssh"           :@"SSH Remote Login Protocol",
                           @"sftp-ssh"      :@"Secure File Transfer Protocol over SSH",
                           @"rfb"           :@"Remote Frame Buffer",
                           @"ipp"           :@"Internet Printing Protocol",
//                           @"icloud-ds"     :@"Apple iCloud",
                           @"daap"          :@"Digital Audio Access Protocol (iTunes)",
                           @"home-sharing"  :@"iTunes Home Sharing",
                           @"cvspserver"    :@"CVS PServer",
                           @"ftp"           :@"File Transfer",
                           @"http"          :@"World Wide Web HTML-over-HTTP",
                           @"pdl-datastream":@"Printer Page Description Language Data Stream",
                           @"printer"       :@"Spooler (more commonly known as \"LPR printing\" or \"LPD printing\")",
                           @"rsp"           :@"Recipe Sharing Protocol",
                           @"scanner"       :@"Bonjour Scanning",
//                           @"ipps"          :@"Internet Printing Protocol",
                           @""              :@"",
                           };
    }
    
    if([serviceName hasPrefix:@"_"] == YES)
    {
        serviceName = [serviceName substringFromIndex:1];
    }
    
    if([serviceNameDic objectForKey:serviceName] != nil)
    {
        serviceName = [serviceNameDic objectForKey:serviceName];
    }
    
    return serviceName;
}
@end
