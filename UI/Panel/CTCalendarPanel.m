//
//  CTCalendarPanel.m
//  HanayuAccountBook2
//
//  Created by take64 on 2014/03/05.
//  Copyright (c) 2014年 citrus.tk. All rights reserved.
//

#import "CTCalendarPanel.h"

#import "CitrusTouchUI.h"

@implementation CTCalendarPanel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

// 読み込み
- (void)loadYear:(NSNumber *)yearNumber month:(NSNumber *)monthNumber
{
    NSUInteger monthFirstWeekday= 0;    // 月の初め
    NSUInteger monthLastWeekday = 0;    // 月の終わり
    NSUInteger monthLastDay     = 0;    // 月の最終日
    
    
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setYear:[yearNumber integerValue]];
    [components setMonth:[monthNumber integerValue]];
    [components setDay:1];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    // 対象日付
    NSDate *firstDate = [calendar dateFromComponents:components];
    
    // 最終日
    NSDateComponents *betweenComponents = [[NSDateComponents alloc] init];
    [betweenComponents setYear:[yearNumber integerValue]];
    [betweenComponents setMonth:([monthNumber integerValue] + 1)];
    [betweenComponents setDay:0];
    [betweenComponents setHour:23];
    [betweenComponents setMinute:59];
    [betweenComponents setSecond:59];
//    NSDate *toDate = [calendar dateFromComponents:betweenComponents];
    
    
    // 月 最終日取得
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:firstDate];
    monthLastDay = range.length;
    
    // 月初めの曜日、月終わりの曜日
    NSUInteger weekday = [[calendar components:NSCalendarUnitWeekday fromDate:firstDate] weekday] - 1;
    monthFirstWeekday = weekday;
    monthLastWeekday = (monthFirstWeekday + monthLastDay) % 7;
    
    // 曜日
    for(int i = 0; i < 7; i++)
    {
        NSString *weekName = @"";
        NSString *weekFontColor = @"";
        NSString *weekBackColor = @"";
        switch (i) {
            case 0: weekName = @"日"; weekFontColor = @"FFFFFF"; weekBackColor = @"FF0000"; break;
            case 1: weekName = @"月"; weekFontColor = @"333333"; weekBackColor = @"FFFFFF"; break;
            case 2: weekName = @"火"; weekFontColor = @"333333"; weekBackColor = @"FFFFFF"; break;
            case 3: weekName = @"水"; weekFontColor = @"333333"; weekBackColor = @"FFFFFF"; break;
            case 4: weekName = @"木"; weekFontColor = @"333333"; weekBackColor = @"FFFFFF"; break;
            case 5: weekName = @"金"; weekFontColor = @"333333"; weekBackColor = @"FFFFFF"; break;
            case 6: weekName = @"土"; weekFontColor = @"FFFFFF"; weekBackColor = @"0000FF"; break;
            default: break;
        }
        
        CTLabel *weekLabel = [[CTLabel alloc] initWithText:weekName];
        [[weekLabel callStyle] addStyleDictionary:@{
                                                    @"left"             :[@((i*46)-i+2) stringValue],
                                                    @"top"              :@"0",
                                                    @"width"            :@"46",
                                                    @"height"           :@"20",
                                                    @"font-weight"      :@"bold",
                                                    @"color"            :weekFontColor,
                                                    @"border-color"     :@"333333",
                                                    @"border-width"     :@"1",
                                                    @"background-color" :weekBackColor,
                                                    }];
        [self addSubview:weekLabel];
    }
    
    NSUInteger rowLimit = ceil((double)(monthLastDay + monthFirstWeekday) / 7);
    
    NSUInteger day = 0;
    NSString *dayString = @"";
    for(int i = 0; i < rowLimit; i++)
    {
        for(int j = 0; j < 7; j++)
        {
            if(i > 0 || j >= monthFirstWeekday)
            {
                day++;
            }
            
            if(day > 0 && day <= monthLastDay)
            {
                dayString = [@(day) stringValue];
            }
            else
            {
                dayString = @"";
            }
            
            
            
            CTLabel *cell = [[CTLabel alloc] initWithText:dayString];
            [[cell callStyle] addStyleDictionary:@{
                                                   @"left"             :[@(j*46 -j+2) stringValue],
                                                   @"top"              :[@(i*40 + 17 -i+2) stringValue],
                                                   @"width"            :@"46",
                                                   @"height"           :@"40",
                                                   @"font-weight"      :@"bold",
                                                   @"color"            :@"333333",
                                                   @"border-color"     :@"333333",
                                                   @"border-width"     :@"1",
                                                   }];
            [self addSubview:cell];
            
        }
    }
    
}

@end
