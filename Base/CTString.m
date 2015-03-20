//
//  CTString.m
//  CitrusTouch
//
//  Created by TAKEMOTO KOUHEI on 2012/11/14.
//  Copyright (c) 2012年 citrus.tk. All rights reserved.
//

#import "CTString.h"

#import <CommonCrypto/CommonCrypto.h>
//#import <Security/Security.h>

@implementation CTString

// URLエンコードする
+ (NSString *) urlEncodeFromString:(NSString *)stringValue
{
    NSString *encodedString = (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)stringValue, NULL, (CFStringRef)@"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8);
    return encodedString;
}

// URLデコードする
+ (NSString *) urlDecodeFromString:(NSString *)stringValue
{
    NSString *decodedString = (__bridge NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL, (CFStringRef)stringValue,                                                                                                            CFSTR(""), kCFStringEncodingUTF8);
    return decodedString;
}

// MD5ハッシュを取得する
+ (NSString *) md5FromString:(NSString *)stringValue
{
    NSData *dataValue = [stringValue dataUsingEncoding:NSUTF8StringEncoding];
    
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5([dataValue bytes], (CC_LONG)[dataValue length], digest);
    char md5cstring[CC_MD5_DIGEST_LENGTH*2];
    
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
    {
        sprintf(md5cstring+i*2, "%02x", digest[i]);
    }
    
    return [NSString stringWithCString:md5cstring encoding:NSUTF8StringEncoding];
}




// 数字から数字文字列に変更
+ (NSString *) stringFromInt:(NSInteger)intValue
{
    return [NSString stringWithFormat:@"%ld", (long)intValue];
}

// 数字から数字文字列に変更
+ (NSString *) stringFromFloat:(float)floatValue
{
    return [NSString stringWithFormat:@"%f", floatValue];
}

// 数字から数字文字列に変更
+ (NSString *) stringFromLongLong:(long long)longLongValue
{
    return [NSString stringWithFormat:@"%lld", longLongValue];
}

// NSDecimalNumberからNSStringに変更
+ (NSString *) stringFromDecimal:(NSDecimalNumber *)decimalValue
{
    NSString *stringValue = @"0";
    @try
    {
        stringValue = [decimalValue stringValue];
    }
    @catch (NSException *exception)
    {
        stringValue = [NSString stringWithFormat:@"%@", decimalValue];
    }
    @finally { }
    return stringValue;
}

// サイズ取得
+ (CGSize) sizeWithString:(NSString *)stringValue font:(UIFont *)font constrainedToSize:(CGSize)constrainedToSize
{
    // 文字列要素
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    // パラグラフ
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    [attributes addEntriesFromDictionary:@{NSParagraphStyleAttributeName:paragraph}];
    [attributes addEntriesFromDictionary:@{NSFontAttributeName:font}];
    [paragraph setLineBreakMode:NSLineBreakByWordWrapping];
    [paragraph setAlignment:NSTextAlignmentLeft];
    
    CGSize contentSize = [stringValue boundingRectWithSize:constrainedToSize options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine) attributes:attributes context:nil].size;
    
    contentSize.height = ceil(contentSize.height);
    contentSize.width = ceil(contentSize.width);
    
    return contentSize;
}

@end
