//
//  CTPlatformDevice.m
//  ProtoRegi02
//
//  Created by take64 on 11/12/16.
//  Copyright (c) 2011 citrus.tk. All rights reserved.
//

#import "CTPlatformDevice.h"

#import <UIKit/UIKit.h>

#include <sys/sysctl.h>

@implementation CTPlatformDevice

// Retinaディスプレイ
+ (BOOL) isRetinaDisplay
{
    if([UIScreen instanceMethodForSelector:@selector(scale)] && [[UIScreen mainScreen] scale] == 2.0f)
    {
        return YES;
    }
    return NO;
}

// iPhone?
+ (BOOL) isIPhone
{
    NSString *platform = [CTPlatformDevice platform];
    
    if([platform hasPrefix:@"iPhone"] == YES)
    {
        return YES;
    }
    return NO;
}

// iPad?
+ (BOOL) isIPad
{
    NSString *platform = [CTPlatformDevice platform];
    
    if([platform hasPrefix:@"iPad"] == YES)
    {
        return YES;
    }
    return NO;
}

// iPod touch?
+ (BOOL) isIPodTouch
{
    NSString *platform = [CTPlatformDevice platform];
    
    if([platform hasPrefix:@"iPod"] == YES)
    {
        return YES;
    }
    return NO;
}

// プラットフォームを取得
+ (NSString *) platform
{
//    return [CTPlatformDevice getSystemInfByName:"hw.machine"];
    return [[UIDevice currentDevice] model];
}

// モデルを取得
+ (NSString *) model
{
//    return [CTPlatformDevice getSystemInfByName:"hw.model"];
    return [[UIDevice currentDevice] model];
}

// システム情報取得
+ (NSString *) getSystemInfByName:(char *)typeSpecifier
{
    // バッファサイズ取得
    size_t size;
    sysctlbyname(typeSpecifier, NULL, &size, NULL, 0);
    
    // データ格納
    char *answer = malloc(size);
    sysctlbyname(typeSpecifier, answer, &size, NULL, 0);
    
    // NSString型に変更
    NSString *results = [NSString stringWithCString:answer encoding: NSUTF8StringEncoding];
    
    free(answer);
    return results;
}

// ランダムなUUIDの生成
+ (NSString *) createUUID
{
    CFUUIDRef uuidObj = CFUUIDCreate(NULL);
    NSString *uuidString = (__bridge NSString *)CFUUIDCreateString(NULL, uuidObj);
    CFRelease(uuidObj);
    
    return uuidString;
}

@end
