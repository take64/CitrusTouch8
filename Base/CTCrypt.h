//
//  CTCrypt.h
//  CitrusTouch
//
//  Created by TAKEMOTO KOUHEI on 2013/01/22.
//  Copyright (c) 2013年 citrus.tk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CommonCrypto/CommonCryptor.h>

@interface CTCrypt : NSObject

// AES暗号化復号化
+ (NSData *) AES128Crypt:(NSData *)sourceData operation:(CCOperation)operation key:(NSString *)key initialVector:(NSString *)initialVector;

// AES暗号化
+ (NSData *) AES128Encrypt:(NSData *)sourceData key:(NSString *)key initialVector:(NSString *)initialVector;

// AES復号化
+ (NSData *) AES128Decrypt:(NSData *)sourceData key:(NSString *)key initialVector:(NSString *)initialVector;

// base64エンコードする
+ (NSString *) base64EncodeFromString:(NSString *)stringValue;

// base64エンコードする
+ (NSString *) base64EncodeFromString:(NSString *)stringValue separatedLine:(BOOL)separatedLine;

// base64デコードする
+ (NSString *) base64DecodeFromString:(NSString *)stringValue;

// base64エンコードする
+ (NSData *) base64EncodeFromData:(NSData *)dataValue;

// base64エンコードする
+ (NSData *) base64EncodeFromData:(NSData *)dataValue separatedLine:(BOOL)separatedLine;

// base64デコードする
+ (NSData *) base64DecodeFromData:(NSData *)dataValue;
@end
