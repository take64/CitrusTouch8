//
//  CTString.h
//  CitrusTouch
//
//  Created by take64 on 2012/11/14.
//  Copyright (c) 2012年 citrus.tk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>

@interface CTString : NSObject


// URLエンコードする
+ (NSString *) urlEncodeFromString:(NSString *)stringValue;

// URLデコードする
+ (NSString *) urlDecodeFromString:(NSString *)stringValue;

// MD5ハッシュを取得する
+ (NSString *) md5FromString:(NSString *)stringValue;

// 数字から数字文字列に変更
+ (NSString *) stringFromInt:(NSInteger)intValue;

// 数字から数字文字列に変更
+ (NSString *) stringFromFloat:(float)floatValue;

// 数字から数字文字列に変更
+ (NSString *) stringFromLongLong:(long long)longLongValue;

// NSDecimalNumberからNSStringに変更
+ (NSString *) stringFromDecimal:(NSDecimalNumber *)decimalValue;

// サイズ取得
+ (CGSize) sizeWithString:(NSString *)stringValue font:(UIFont *)font constrainedToSize:(CGSize)constrainedToSize;

@end
