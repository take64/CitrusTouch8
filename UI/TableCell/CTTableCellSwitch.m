//
//  CTTableCellSwitch.m
//  CitrusTouch
//
//  Created by TAKEMOTO KOUHEI on 2012/11/27.
//  Copyright (c) 2012年 citrus.tk. All rights reserved.
//

#import "CTTableCellSwitch.h"

@implementation CTTableCellSwitch

//
// synthesize
//
@synthesize _switch;


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 未レイアウトの場合
    if([self isSubLayout] == NO)
    {
        CGPoint centerPoint = [[self contentView] center];
        centerPoint.x += CL8(14);
        
        [[self _switch] setCenter:centerPoint];
//        [[self _switch] setFrame:CGRectOffset(CGRectInset([self contentFrame], 8, 4), 0, -2)];
        
        // レイアウト済み
        [self setSubLayout:YES];
    }
}


#pragma mark -
#pragma mark method
//
// method
//

// 初期化
- (id) initWithPrefix:(NSString *)prefixString suffix:(NSString *)suffixString reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithPrefix:prefixString suffix:suffixString reuseIdentifier:reuseIdentifier];
    if(self)
    {
        // ボタン
        [self set_switch:[[UISwitch alloc] initWithFrame:CGRectZero]];
        [[self contentView] addSubview:[self _switch]];
        
        // テキストフィールド
        [[self _switch] setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
//        [[self _switch] setAutoresizingMask:(UIViewAutoresizingFlexibleLeftMargin |
//                                                UIViewAutoresizingFlexibleRightMargin |
//                                                UIViewAutoresizingFlexibleTopMargin |
//                                                UIViewAutoresizingFlexibleBottomMargin |
//                                                UIViewAutoresizingFlexibleWidth	|
//                                                UIViewAutoresizingFlexibleHeight)];
        [[self contentView] addSubview:[self _switch]];
        
        
        // セル選択
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        // タッチイベントは透過
//        [self setUserInteractionEnabled:NO];
    }
    return self;
}

// 初期化
- (id) initWithPrefix:(NSString *)prefixString content:(BOOL)boolValue reuseIdentifier:(NSString *)reuseIdentifier
{
    
    self = [self initWithPrefix:prefixString suffix:nil reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self setOn:boolValue];
    }
    return self;
}

// 値取得
- (BOOL)isON
{
    return [[self _switch] isOn];
}
// 値設定
- (void)setOn:(BOOL)boolValue
{
    [[self _switch] setOn:boolValue];
}

// イベント設定
- (void)addTarget:(id)idValue action:(SEL)selValue forControlEvents:(UIControlEvents)controlEventsValue
{
    [[self _switch] addTarget:idValue action:selValue forControlEvents:controlEventsValue];
}

@end
