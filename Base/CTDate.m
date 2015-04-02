//
//  CTDate.m
//  CitrusTouch
//
//  Created by TAKEMOTO KOUHEI on 2012/09/30.
//  Copyright (c) 2012年 citrus.tk. All rights reserved.
//

#import "CTDate.h"

#import <mach/mach_time.h>
#import <time.h>
#import <sqlite3.h>

@implementation CTDate

// 日付フォーマットを自動識別して取得
+ (NSDate *)dateWithString:(NSString *)stringValue
{
    sqlite3 *db = NULL;
    sqlite3_open(":memory:", &db);
    sqlite3_stmt *statement = NULL;
    sqlite3_prepare_v2(db, "SELECT strftime('%s', ?);", -1, &statement, NULL);
    
    sqlite3_bind_text(statement, 1, stringValue.UTF8String, -1, SQLITE_STATIC);
    sqlite3_step(statement);
    sqlite3_int64 timestamp = sqlite3_column_int64(statement, 0);
    
    NSDate *dateValue = [NSDate dateWithTimeIntervalSince1970:timestamp];
    
    sqlite3_clear_bindings(statement);
    sqlite3_reset(statement);
    
    return dateValue;
}

// 日付フォーマットからNSDateを取得
+ (NSDate *) dateWithString:(NSString *)stringValue format:(NSString *)formatString
{
    return [self dateWithString:stringValue format:formatString locale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
}

// 日付フォーマットからNSDateを取得(LOCALE指定)
+ (NSDate *) dateWithString:(NSString *)stringValue format:(NSString *)formatString locale:(NSLocale *)localeValue
{
    return [self dateWithString:stringValue format:formatString locale:localeValue timeZone:[NSTimeZone defaultTimeZone]];
}

// 日付フォーマットからNSDateを取得(LOCALE指定/タイムゾーン指定)
+ (NSDate *) dateWithString:(NSString *)stringValue format:(NSString *)formatString locale:(NSLocale *)localeValue timeZone:(NSTimeZone *)timeZoneValue
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:localeValue];
    [formatter setTimeZone:timeZoneValue];
    [formatter setDateFormat:formatString];
    NSDate *date = [formatter dateFromString:stringValue];
    
    return date;
}

// 日付フォーマットされた文字列を取得
+ (NSString *)stringWithDate:(NSDate *)dateValue format:(NSString *)formatString
{
    return [self stringWithDate:dateValue format:formatString locale:[NSLocale currentLocale]];
}

// 日付フォーマットされた文字列を取得(LOCALE指定)
+ (NSString *)stringWithDate:(NSDate *)dateValue format:(NSString *)formatString locale:(NSLocale *)localeValue
{
    return [self stringWithDate:dateValue format:formatString locale:localeValue timeZone:[NSTimeZone defaultTimeZone]];
}

// 日付フォーマットされた文字列を取得(LOCALE指定/タイムゾーン指定)
+ (NSString *)stringWithDate:(NSDate *)dateValue format:(NSString *)formatString locale:(NSLocale *)localeValue timeZone:(NSTimeZone *)timeZoneValue
{
    // フォーマット
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:timeZoneValue];
    [formatter setLocale:localeValue];
    [formatter setDateFormat:formatString];
    
    // 変換
    return [formatter stringFromDate:dateValue];
}

// タイムスタンプ文字列
+ (NSString *)stringUnixTime:(NSDate *)dateValue
{
    return [NSString stringWithFormat:@"%f", [dateValue timeIntervalSince1970]];
}

// タイムスタンプ文字列からNSDateに
+ (NSDate *) dateWithUnixTimeString:(NSString *)stringValue
{
    return [NSDate dateWithTimeIntervalSince1970:[stringValue intValue]];
}

// 日付から時分秒をとる
+ (NSDate *) dateRemoveHHIISSWithDate:(NSDate *)dateValue
{
    return [self dateRemoveHHIISSWithDate:dateValue locale:[NSLocale currentLocale]];
}

// 日付から時分秒をとる
+ (NSDate *) dateRemoveHHIISSWithDate:(NSDate *)dateValue locale:(NSLocale *)localeValue
{
    return [self dateRemoveHHIISSWithDate:dateValue locale:localeValue timeZone:[NSTimeZone defaultTimeZone]];
}

// 日付から時分秒をとる
+ (NSDate *) dateRemoveHHIISSWithDate:(NSDate *)dateValue locale:(NSLocale *)localeValue timeZone:(NSTimeZone *)timeZoneValue
{
    static NSCalendar *calendar;
    if(calendar == nil)
    {
        calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        [calendar setLocale:localeValue];
        [calendar setTimeZone:timeZoneValue];
    }
    NSDateComponents *components = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSWeekdayCalendarUnit) fromDate:dateValue];
    [components setHour:0];
    [components setMinute:0];
    [components setSecond:0];
    
    return [calendar dateFromComponents:components];
}

// 本日日付
+ (NSDate *)todayDate
{
    static NSCalendar *calendar;
    if(calendar == nil)
    {
        calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        [calendar setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"ja_JP"]];
        [calendar setTimeZone:[NSTimeZone systemTimeZone]];
    }
    NSDateComponents *components = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSWeekdayCalendarUnit) fromDate:[NSDate date]];
    [components setHour:0];
    [components setMinute:0];
    [components setSecond:0];
    
    return [calendar dateFromComponents:components];
}

// 日付から年を取得
+ (NSInteger)yearWithDate:(NSDate *)dateValue
{
    static NSCalendar *calendar;
    if(calendar == nil)
    {
        calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        [calendar setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"ja_JP"]];
        [calendar setTimeZone:[NSTimeZone systemTimeZone]];
    }
    NSDateComponents *components = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSWeekdayCalendarUnit) fromDate:dateValue];
    
    return [components year];
}

// 日付から月を取得
+ (NSInteger)monthWithDate:(NSDate *)dateValue
{
    static NSCalendar *calendar;
    if(calendar == nil)
    {
        calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        [calendar setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"ja_JP"]];
        [calendar setTimeZone:[NSTimeZone systemTimeZone]];
    }
    NSDateComponents *components = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSWeekdayCalendarUnit) fromDate:dateValue];
    
    return [components month];
}

// 日付から日を取得
+ (NSInteger)dayWithDate:(NSDate *)dateValue
{
    static NSCalendar *calendar;
    if(calendar == nil)
    {
        calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        [calendar setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"ja_JP"]];
        [calendar setTimeZone:[NSTimeZone systemTimeZone]];
    }
    NSDateComponents *components = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSWeekdayCalendarUnit) fromDate:dateValue];
    
    return [components day];
}

// 月の初めを取得
+ (NSDate *)monthFirstWithDate:(NSDate *)dateValue
{
    static NSCalendar *calendar;
    if(calendar == nil)
    {
        calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        [calendar setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"ja_JP"]];
        [calendar setTimeZone:[NSTimeZone systemTimeZone]];
    }
    NSDateComponents *components = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSWeekdayCalendarUnit) fromDate:dateValue];
    [components setDay:1];
    [components setHour:0];
    [components setMinute:0];
    [components setSecond:0];
    
    return [calendar dateFromComponents:components];
}


//// NSDateから日付だけのNSDateを取得
//+ (NSDate *) dateOnlyWithDate:(NSDate *)dateValue
//{
//    return [self dateWithString:[self stringWithDate:dateValue format:@"yyyy/MM/dd"] format:@"yyyy/MM/dd"];
//}

@end
