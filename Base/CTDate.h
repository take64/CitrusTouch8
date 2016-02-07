//
//  CTDate.h
//  CitrusTouch
//
//  Created by take64 on 2012/09/30.
//  Copyright (c) 2012年 citrus.tk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CTDate : NSObject

// 日付フォーマットを自動識別して取得
+ (NSDate *)dateWithString:(NSString *)stringValue;

// 日付フォーマットからNSDateを取得
+ (NSDate *) dateWithString:(NSString *)stringValue format:(NSString *)formatString;

// 日付フォーマットからNSDateを取得(LOCALE指定)
+ (NSDate *) dateWithString:(NSString *)stringValue format:(NSString *)formatString locale:(NSLocale *)localeValue;

// 日付フォーマットからNSDateを取得(LOCALE指定/タイムゾーン指定)
+ (NSDate *) dateWithString:(NSString *)stringValue format:(NSString *)formatString locale:(NSLocale *)localeValue timeZone:(NSTimeZone *)timeZoneValue;

// 日付フォーマットされた文字列を取得
+ (NSString *)stringWithDate:(NSDate *)dateValue format:(NSString *)formatString;

// 日付フォーマットされた文字列を取得(LOCALE指定)
+ (NSString *)stringWithDate:(NSDate *)dateValue format:(NSString *)formatString locale:(NSLocale *)localeValue;

// 日付フォーマットされた文字列を取得(LOCALE指定/タイムゾーン指定)
+ (NSString *)stringWithDate:(NSDate *)dateValue format:(NSString *)formatString locale:(NSLocale *)localeValue timeZone:(NSTimeZone *)timeZoneValue;

// タイムスタンプ文字列
+ (NSString *) stringUnixTime:(NSDate *)dateValue;

// タイムスタンプ文字列からNSDateに
+ (NSDate *) dateWithUnixTimeString:(NSString *)stringValue;

// 日付から時分秒をとる
+ (NSDate *) dateRemoveHHIISSWithDate:(NSDate *)dateValue;

// 日付から時分秒をとる
+ (NSDate *) dateRemoveHHIISSWithDate:(NSDate *)dateValue locale:(NSLocale *)localeValue;

// 日付から時分秒をとる
+ (NSDate *) dateRemoveHHIISSWithDate:(NSDate *)dateValue locale:(NSLocale *)localeValue timeZone:(NSTimeZone *)timeZoneValue;
//// NSDateから日付だけのNSDateを取得
//+ (NSDate *) dateOnlyWithDate:(NSDate *)dateValue;

// 本日日付
+ (NSDate *)todayDate;

// 日付から年を取得
+ (NSInteger)yearWithDate:(NSDate *)dateValue;

// 日付から月を取得
+ (NSInteger)monthWithDate:(NSDate *)dateValue;

// 日付から日を取得
+ (NSInteger)dayWithDate:(NSDate *)dateValue;

// 月の初めを取得
+ (NSDate *)monthFirstWithDate:(NSDate *)dateValue;

// コンポーネントの取得
+ (NSDateComponents *)componentsWithDate:(NSDate *)dateValue;

// 日付の取得
+ (NSDate *)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second;

//// 月の終わりを取得
//+ (NSDate *)monthLastWithDate:(NSDate *)dateValue;

@end
