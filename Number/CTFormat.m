//
//  CTFormat.m
//  CitrusTouch
//
//  Created by TAKEMOTO KOUHEI on 2013/02/09.
//  Copyright (c) 2013年 citrus.tk. All rights reserved.
//

#import "CTFormat.h"

@implementation CTFormat

// NSDecimalNUmberから金額フォーマット文字列を作成
+ (NSString *) formatMoneyWithDecimal:(NSDecimalNumber *)decimalValue prefix:(NSString *)prefixString suffix:(NSString *)suffixString;
{
    static NSNumberFormatter *numberFormat;
    if(numberFormat == nil)
    {
        numberFormat = [[NSNumberFormatter alloc] init];
        [numberFormat setNumberStyle:NSNumberFormatterDecimalStyle];
        [numberFormat setGroupingSeparator:@","];
        [numberFormat setGroupingSize:3];
    }
    prefixString = [CTEmptyVL compare:prefixString replace:@""];
    suffixString = [CTEmptyVL compare:suffixString replace:@""];
    
    [numberFormat setPositivePrefix:prefixString];
    [numberFormat setPositiveSuffix:suffixString];
    [numberFormat setNegativePrefix:[NSString stringWithFormat:@"-%@", prefixString]];
    [numberFormat setNegativeSuffix:suffixString];
    
    return [numberFormat stringForObjectValue:decimalValue];
}

// NSDecimalNUmberから金額フォーマット文字列を作成
+ (NSString *) formatMoneyWithDecimal:(NSDecimalNumber *)decimalValue
{
    return [self formatMoneyWithDecimal:decimalValue prefix:nil suffix:nil];
}

@end
