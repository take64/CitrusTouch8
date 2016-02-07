//
//  CTFormat.h
//  CitrusTouch
//
//  Created by take64 on 2013/02/09.
//  Copyright (c) 2013年 citrus.tk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTFormat : NSObject

// NSDecimalNUmberから金額フォーマット文字列を作成
+ (NSString *) formatMoneyWithDecimal:(NSDecimalNumber *)decimalValue prefix:(NSString *)prefixString suffix:(NSString *)suffixString;

// NSDecimalNUmberから金額フォーマット文字列を作成
+ (NSString *) formatMoneyWithDecimal:(NSDecimalNumber *)decimalValue;

@end
