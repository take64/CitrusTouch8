//
//  CTTableCellButton.m
//  CitrusTouch
//
//  Created by take64 on 2012/11/27.
//  Copyright (c) 2012年 citrus.tk. All rights reserved.
//

#import "CTTableCellButton.h"

@implementation CTTableCellButton

//
// synthesize
//
@synthesize button;


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 未レイアウトの場合
    if([self isSubLayout] == NO)
    {
        [[self button] setFrame:CGRectOffset(CGRectInset([self contentFrame], 8, 4), 0, -2)];
        
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
        [self setButton:[[CTButton alloc] initWithText:@""]];
        [[[self button] callStyle] addStyleDictionary:@{
         @"font-size"       :@"16",
         @"font-weight"     :@"bold",
         @"text-shadow"     :@"0 -1 1 333333",
         @"background-color":@"0000FF",
         @"border-color"    :@"FFFFFF",
         @"border-width"    :@"1",
         @"border-radius"   :@"8",
         @"margin"          :@"4 12 4 12",
         @"box-shadow"      :@"0 1 4 000000",
         @"background-image":@"linear-gradient(rgba(1.00, 1.00, 1.00, 0.75) 0.00, rgba(0.75, 0.75, 0.75, 0.50) 0.05, rgba(0.50, 0.50, 0.50, 0.50) 0.95, rgba(0.25, 0.25, 0.25, 0.75) 1.00)",
         }];
        [[[self button] callStyleHighlighted] addStyleDictionary:@{
         @"background-image":@"linear-gradient(rgba(0.10, 0.10, 0.10, 0.90) 0.00, rgba(0.10, 0.10, 0.10, 0.50) 0.05, rgba(0.10, 0.10, 0.10, 0.50) 0.95, rgba(0.10, 0.10, 0.10, 0.90) 1.00)",
         }];
        [[[self button] callStyleDisabled] addStyleDictionary:@{
         @"background-color":@"666666",
         }];
        [[self contentView] addSubview:[self button]];
        
        // セル選択
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return self;
}

// 初期化
- (id) initWithPrefix:(NSString *)prefixString content:(NSString *)textString suffix:(NSString *)suffixString reuseIdentifier:(NSString *)reuseIdentifier
{
    
    self = [self initWithPrefix:prefixString suffix:suffixString reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [[self button] setText:textString];
    }
    return self;
}

// テキスト取得
- (NSString *) contentText
{
    return [[self button] text];
}
// テキスト設定
- (void) setContentText:(NSString *)stringValue
{
    [[self button] setText:stringValue];
}


@end
