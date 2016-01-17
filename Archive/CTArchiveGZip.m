//
//  CTArchiveGZip.m
//  CitrusTouch
//
//  Created by TAKEMOTO KOUHEI on 2016/01/11.
//  Copyright © 2016年 citrus.tk. All rights reserved.
//

#import "CTArchiveGZip.h"

#import <zlib.h>

@implementation CTArchiveGZip

// 圧縮
+ (NSData *)archive:(NSData *)dataValue level:(int)level
{
    Bytef buffer[131072];
    
    // 初期化
    z_stream zStream;
    zStream.zalloc = Z_NULL;
    zStream.zfree = Z_NULL;
    zStream.opaque = Z_NULL;
    
    deflateInit(&zStream, level);
    
    zStream.avail_in = (uInt)[dataValue length];
    zStream.next_in = (Bytef *)[dataValue bytes];
    
    
    // 圧縮
    NSMutableData *resultValue = [NSMutableData dataWithCapacity:0];
    do
    {
        zStream.next_out = buffer;
        zStream.avail_out = sizeof(buffer);
        deflate(&zStream, Z_FINISH);
        size_t length = sizeof(buffer) - zStream.avail_out;
        if (length > 0)
        {
            [resultValue appendBytes:buffer length:length];
        }
    }
    while(zStream.avail_out != sizeof(buffer));
    
    deflateEnd(&zStream);
    
    return [resultValue copy];
}

// 解凍
+ (NSData *)unarchive:(NSData *)dataValue
{
    Bytef buffer[131072];
    
    // 初期化
    z_stream zStream;
    zStream.zalloc = Z_NULL;
    zStream.zfree = Z_NULL;
    zStream.opaque = Z_NULL;
    
    inflateInit(&zStream);
    
    zStream.avail_in = (uInt)[dataValue length];
    zStream.next_in = (Bytef *)[dataValue bytes];
    
    // 解凍
    NSMutableData *resultValue = [NSMutableData dataWithCapacity:0];
    do
    {
        zStream.next_out = buffer;
        zStream.avail_out = sizeof(buffer);
        inflate(&zStream, Z_FINISH);
        size_t length = sizeof(buffer) - zStream.avail_out;
        if (length > 0)
        {
            [resultValue appendBytes:buffer length:length];
        }
    }
    while (zStream.avail_out != sizeof(buffer));
    
    inflateEnd(&zStream);
    
    return [resultValue copy];
}
@end
