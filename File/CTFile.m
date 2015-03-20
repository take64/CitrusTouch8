//
//  CTFile.m
//  EasyWeather
//
//  Created by TAKEMOTO KOUHEI on 9/20/14.
//  Copyright (c) 2014 citrus.tk. All rights reserved.
//

#import "CTFile.h"

@implementation CTFile

// Documentにファイルがあるか
+ (BOOL) existDocumentFile:(NSString *)filename
{
    NSData *dataValue = [self loadDocumentFile:filename];
    
    if(dataValue == nil)
    {
        return NO;
    }
    return YES;
}

// Documentのファイルを取得
+ (NSData *) loadDocumentFile:(NSString *)filename
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *directory = [paths objectAtIndex:0];
    NSString *filePath = [directory stringByAppendingPathComponent:filename];
    NSData *dataValue = [[NSData alloc] initWithContentsOfFile:filePath];
    return dataValue;
}

// Documentにファイルを保存
+ (void) saveDocument:(NSData *)dataValue filename:(NSString *)filename
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *directory = [paths objectAtIndex:0];
    NSString *filePath = [directory stringByAppendingPathComponent:filename];
    
    [dataValue writeToFile:filePath atomically:NO];
}

@end
