//
//  CTNetwork.h
//  LorsPOS
//
//  Created by take64 on 12/01/14.
//  Copyright (c) 2012年 citrus.tk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTNetwork : NSObject

// デバイスのIPアドレスを取得
+ (NSString *) ipAddressV4;

// 渡された文字列がIPアドレスの形式か？
+ (BOOL) isIPAddressString:(NSString *)ipAddress;

// ローカルWIFIに接続しているか？
+ (BOOL) isConnectionLocalWIFI;

// IPアドレス文字列の取得
+ (NSString *)ipAddressWithData:(NSData *)dataValue;
@end
