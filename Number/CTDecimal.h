//
//  CTDecimal.h
//  CitrusTouch
//
//  Created by TAKEMOTO KOUHEIon 12/01/20.
//  Copyright (c) 2012 citrus.tk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTDecimal : NSObject

// 切り上げ、切り捨て、四捨五入
+ (NSDecimalNumber *) decimalRoundingMode:(NSRoundingMode) roundingMode decimal:(NSDecimalNumber *)decimalValue scale:(short)scale;

// 切り上げ
+ (NSDecimalNumber *) decimalRoundUpWithDecimal:(NSDecimalNumber *) decimalValue;

// 切り上げ
+ (NSDecimalNumber *) decimalRoundUpWithDecimal:(NSDecimalNumber *) decimalValue scale:(short)scale;

// 切り捨て
+ (NSDecimalNumber *) decimalRoundDownWithDecimal:(NSDecimalNumber *) decimalValue;

// 切り捨て
+ (NSDecimalNumber *) decimalRoundDownWithDecimal:(NSDecimalNumber *) decimalValue scale:(short)scale;

// 四捨五入
+ (NSDecimalNumber *) decimalRoundPlainWithDecimal:(NSDecimalNumber *) decimalValue;

// 四捨五入
+ (NSDecimalNumber *) decimalRoundPlainWithDecimal:(NSDecimalNumber *) decimalValue scale:(short)scale;

// intからの変換
+ (NSDecimalNumber *) decimalWithInt:(int)intValue;

// doubleからの変換
+ (NSDecimalNumber *) decimalWithDouble:(double)doubleValue;

// NSStringからの変換
+ (NSDecimalNumber *) decimalWithString:(NSString *)stringValue;

@end
