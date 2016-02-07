//
//  CTCrypt.m
//  CitrusTouch
//
//  Created by take64 on 2013/01/22.
//  Copyright (c) 2013年 citrus.tk. All rights reserved.
//

#import "CTCrypt.h"

@implementation CTCrypt

// AES暗号化復号化
+ (NSData *) AES128Crypt:(NSData *)sourceData operation:(CCOperation)operation key:(NSString *)key initialVector:(NSString *)initialVector
{
    // キー
    char keyPointer[kCCKeySizeAES128 + 1];
    memset(keyPointer, 0, sizeof(keyPointer));
    [key getCString:keyPointer maxLength:sizeof(keyPointer) encoding:NSUTF8StringEncoding];
    
    // ブロック
    char ivPointer[kCCBlockSizeAES128 + 1];
    memset(ivPointer, 0, sizeof(ivPointer));
    [initialVector getCString:ivPointer maxLength:sizeof(ivPointer) encoding:NSUTF8StringEncoding];
    
    // データセット
    NSUInteger dataLength = [sourceData length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    // 変換
    size_t numBytesCrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(operation,
                                          kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding,
                                          keyPointer,
                                          kCCBlockSizeAES128,
                                          ivPointer,
                                          [sourceData bytes],
                                          dataLength,
                                          buffer,
                                          bufferSize,
                                          &numBytesCrypted);
    if (cryptStatus == kCCSuccess)
    {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesCrypted];
    }
    return nil;
}


// AES暗号化
+ (NSData *) AES128Encrypt:(NSData *)sourceData key:(NSString *)key initialVector:(NSString *)initialVector
{
    return [self AES128Crypt:sourceData operation:kCCEncrypt key:key initialVector:initialVector];
}

// AES復号化
+ (NSData *) AES128Decrypt:(NSData *)sourceData key:(NSString *)key initialVector:(NSString *)initialVector
{
    return [self AES128Crypt:sourceData operation:kCCDecrypt key:key initialVector:initialVector];
}


// base64エンコードする
+ (NSString *) base64EncodeFromString:(NSString *)stringValue
{
    NSData *result = [CTCrypt base64EncodeFromData:[stringValue dataUsingEncoding:NSUTF8StringEncoding]];
    return [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
}

// base64デコードする
+ (NSString *) base64DecodeFromString:(NSString *)stringValue
{
    NSData *result = [CTCrypt base64DecodeFromData:[stringValue dataUsingEncoding:NSUTF8StringEncoding]];
    return [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
}

// base64エンコードする
+ (NSData *) base64EncodeFromData:(NSData *)dataValue
{
    return [dataValue base64EncodedDataWithOptions:NSDataBase64Encoding64CharacterLineLength];
}

// base64デコードする
+ (NSData *) base64DecodeFromData:(NSData *)dataValue
{
    return [[NSData alloc] initWithBase64EncodedData:dataValue options:NSDataBase64DecodingIgnoreUnknownCharacters];
}

@end
