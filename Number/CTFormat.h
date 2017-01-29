//
//  CTFormat.h
//  CitrusTouch
//
//  Created by take64 on 2013/02/09.
//  Copyright (c) 2013年 citrus.tk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTFormat : NSObject

// NSDecimalNumberから金額フォーマット文字列を作成
+ (NSString *)formatMoneyWithDecimal:(NSDecimalNumber *)decimalValue prefix:(NSString *)prefixString suffix:(NSString *)suffixString;

// NSDecimalNumberから金額フォーマット文字列を作成
+ (NSString *)formatMoneyWithDecimal:(NSDecimalNumber *)decimalValue;

// NSDecimalNumberから数値フォーマット文字列を生成
+ (NSString *)formatNumberWithDecimal:(NSDecimalNumber *)decimalValue prefix:(NSString *)prefixString suffix:(NSString *)suffixString scale:(int)scale;

// NSDecimalNumberから数値フォーマット文字列を生成
+ (NSString *)formatNumberWithDecimal:(NSDecimalNumber *)decimalValue scale:(int)scale;

@end
