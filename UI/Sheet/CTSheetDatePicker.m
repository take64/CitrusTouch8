//
//  CTSheetDatePicker.m
//  CitrusTouch
//
//  Created by TAKEMOTO KOUHEI on 2012/11/27.
//  Copyright (c) 2012年 citrus.tk. All rights reserved.
//

#import "CTSheetDatePicker.h"

@implementation CTSheetDatePicker

//
// synthesize
//

@synthesize _datePicker;
@synthesize _toolbar;
@synthesize _segmentedPrevNext;
@synthesize _responderPrev;
@synthesize _responderNext;

// 初期化
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // ツールバー
        [self set_toolbar:[[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)]];
        [[self _toolbar] setBarStyle:UIBarStyleBlackOpaque];
        [[self _toolbar] setTranslucent:YES];
        // ツールバー(前後ボタン)
        [self set_segmentedPrevNext:[[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"前へ", @"次へ", nil]]];
//        [[self _segmentedPrevNext] setSegmentedControlStyle:UISegmentedControlStyleBar];
        [[self _segmentedPrevNext] addTarget:self action:@selector(onChangeSegmentedPrevNext:) forControlEvents:UIControlEventValueChanged];
        UIBarButtonItem *barButtonPrevNext = [[UIBarButtonItem alloc] initWithCustomView:[self _segmentedPrevNext]];
        
        // ツールバー(スペーサー)
        UIBarButtonItem *barSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        // ツールバー(閉じるボタン)
        UIBarButtonItem *barButtonDone = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(onTapBarButtonDone)];
        // ツールバー(アイテム配置)
        [[self _toolbar] setItems:[NSArray arrayWithObjects:barButtonPrevNext, barSpacer, barButtonDone, nil]];
        [self addSubview:[self _toolbar]];
        
        // 日付ピッカー
        [self set_datePicker:[[UIDatePicker alloc] initWithFrame:CGRectMake(0, 44, 320, 216)]];
        [self addSubview:[self _datePicker]];
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
