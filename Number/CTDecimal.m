//
//  CTDecimal.m
//  CitrusTouch
//
//  Created by take64 on 12/01/20.
//  Copyright (c) 2012 citrus.tk. All rights reserved.
//

#import "CTDecimal.h"

@implementation CTDecimal



// 切り上げ、切り捨て、四捨五入
+ (NSDecimalNumber *) decimalRoundingMode:(NSRoundingMode)roundingMode decimal:(NSDecimalNumber *)decimalValue scale:(short)scale
{
    NSDecimalNumberHandler *handler = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:roundingMode
                                                                                             scale:scale
                                                                                  raiseOnExactness:YES
                                                                                   raiseOnOverflow:YES
                                                                                  raiseOnUnderflow:YES
                                                                               raiseOnDivideByZero:YES];
    return [decimalValue decimalNumberByRoundingAccordingToBehavior:handler];
}

// 切り上げ
+ (NSDecimalNumber *) decimalRoundUpWithDecimal:(NSDecimalNumber *) decimalValue
{
    return [CTDecimal decimalRoundingMode:NSRoundUp decimal:decimalValue scale:0];
}

// 切り上げ
+ (NSDecimalNumber *) decimalRoundUpWithDecimal:(NSDecimalNumber *) decimalValue scale:(short)scale
{
    return [CTDecimal decimalRoundingMode:NSRoundUp decimal:decimalValue scale:scale];
}

// 切り捨て
+ (NSDecimalNumber *) decimalRoundDownWithDecimal:(NSDecimalNumber *) decimalValue
{
    return [CTDecimal decimalRoundingMode:NSRoundDown decimal:decimalValue scale:0];
}

// 切り捨て
+ (NSDecimalNumber *) decimalRoundDownWithDecimal:(NSDecimalNumber *) decimalValue scale:(short)scale
{
    return [CTDecimal decimalRoundingMode:NSRoundDown decimal:decimalValue scale:scale];
}

// 四捨五入
+ (NSDecimalNumber *) decimalRoundPlainWithDecimal:(NSDecimalNumber *) decimalValue
{
    return [CTDecimal decimalRoundingMode:NSRoundPlain decimal:decimalValue scale:0];
}

// 四捨五入
+ (NSDecimalNumber *) decimalRoundPlainWithDecimal:(NSDecimalNumber *) decimalValue scale:(short)scale
{
    return [CTDecimal decimalRoundingMode:NSRoundPlain decimal:decimalValue scale:scale];
}

// intからの変換
+ (NSDecimalNumber *) decimalWithInt:(int)intValue
{
    return [NSDecimalNumber decimalNumberWithDecimal:[[NSNumber numberWithInt:intValue] decimalValue]];
}

// doubleからの変換
+ (NSDecimalNumber *) decimalWithDouble:(double)doubleValue
{
    return [NSDecimalNumber decimalNumberWithDecimal:[[NSNumber numberWithDouble:doubleValue] decimalValue]];
}

// NSStringからの変換
+ (NSDecimalNumber *) decimalWithString:(NSString *)stringValue
{
    NSDecimalNumber *decimalValue = [NSDecimalNumber zero];
    @try
    {
        decimalValue = [NSDecimalNumber decimalNumberWithString:stringValue];
    }
    @catch (NSException *exception)
    {
        decimalValue = [self decimalWithDouble:[stringValue doubleValue]];
    }
    @finally {}
    return decimalValue;
}

// NSNumberからの変換
+ (NSDecimalNumber *) decimalWithNumber:(NSNumber *)numberValue
{
    return [NSDecimalNumber decimalNumberWithDecimal:[numberValue decimalValue]];
}

// 最大値の取得
+ (NSDecimalNumber *) maxWidhList:(NSArray *)listValue
{
    NSDecimalNumber *result = [NSDecimalNumber zero];
    for(NSDecimalNumber *one in listValue)
    {
        if([result compare:one] == NSOrderedAscending)
        {
            result = one;
        }
    }
    return result;
}

// 平均値の取得
+ (NSDecimalNumber *) avgWidhList:(NSArray *)listValue
{
    NSDecimalNumber *count = [NSDecimalNumber zero];
    NSDecimalNumber *total = [NSDecimalNumber zero];
    for(NSDecimalNumber *one in listValue)
    {
        count = [count decimalNumberByAdding:[NSDecimalNumber one]];
        total = [total decimalNumberByAdding:one];
    }
    if([total compare:[NSDecimalNumber zero]] == NSOrderedSame)
    {
        return [NSDecimalNumber zero];
    }
    return [total decimalNumberByDividingBy:count];
}

// 比較して最大値を取得する
+ (NSDecimalNumber *)max:(NSDecimalNumber *)decimal1 with:(NSDecimalNumber *)decimal2
{
    if([decimal1 compare:decimal2] == NSOrderedDescending)
    {
        return decimal1;
    }
    return decimal2;
}

// 比較して最小値を取得する
+ (NSDecimalNumber *)min:(NSDecimalNumber *)decimal1 with:(NSDecimalNumber *)decimal2
{
    if([decimal1 compare:decimal2] == NSOrderedAscending)
    {
        return decimal1;
    }
    return decimal2;
}

@end
