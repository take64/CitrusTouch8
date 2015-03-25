//
//  CTEditFoot.m
//  LorsPOS2
//
//  Created by Take on 13/12/29.
//  Copyright (c) 2013年 naissance sapporo co,.Ltd. All rights reserved.
//

#import "CTEditFoot.h"

#import "CitrusTouchUI.h"

@implementation CTEditFoot

//
// synthesize
//
@synthesize removeButton;
@synthesize rebirthButton;
@synthesize status;


// 初期化
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [[self callStyle] addStyleDictionary:@{
         @"top"             :@"0",
         @"left"            :@"0",
//         @"width"           :@"160",
         @"height"          :@"128",
         }];
        
        
        // 削除ボタン
        [self setRemoveButton:[[CTButton alloc] initWithText:@"削除"]];
        [[[self removeButton] callStyle] addStyleDictionary:@{
         @"top"             :@"0",
         @"left"            :@"0",
         @"width"           :@"320",
         @"height"          :@"64",
         @"font-size"       :@"20",
         @"font-weight"     :@"bold",
         @"text-shadow"     :@"0 -1 1 333333",
         @"background-color":@"FF0000",
         @"border-color"    :@"FFFFFF",
         @"border-width"    :@"1",
         @"border-radius"   :@"8",
         @"margin"          :@"4 48 12 48",
         @"box-shadow"      :@"0 1 4 000000",
         @"background-image":@"linear-gradient(rgba(1.00, 1.00, 1.00, 0.75) 0.00, rgba(0.75, 0.75, 0.75, 0.50) 0.05, rgba(0.50, 0.50, 0.50, 0.50) 0.95, rgba(0.25, 0.25, 0.25, 0.75) 1.00)",
         }];
        [[[self removeButton] callStyleHighlighted] addStyleDictionary:@{
         @"background-image":@"linear-gradient(rgba(0.10, 0.10, 0.10, 0.90) 0.00, rgba(0.10, 0.10, 0.10, 0.50) 0.05, rgba(0.10, 0.10, 0.10, 0.50) 0.95, rgba(0.10, 0.10, 0.10, 0.90) 1.00)",
         }];
        [[[self removeButton] callStyleDisabled] addStyleDictionary:@{
         @"color"           :@"999999",
         @"background-image":@"linear-gradient(rgba(0.10, 0.10, 0.10, 0.90) 0.00, rgba(0.10, 0.10, 0.10, 0.50) 0.05, rgba(0.10, 0.10, 0.10, 0.50) 0.95, rgba(0.10, 0.10, 0.10, 0.90) 1.00)",
         }];
        [self addSubview:[self removeButton]];
        
        // 復活ボタン
        [self setRebirthButton:[[CTButton alloc] initWithText:@"復活"]];
        [[[self rebirthButton] callStyle] addStyleDictionary:@{
         @"top"             :@"64",
         @"left"            :@"0",
         @"width"           :@"320",
         @"height"          :@"64",
         @"font-size"       :@"20",
         @"font-weight"     :@"bold",
         @"text-shadow"     :@"0 -1 1 333333",
         @"background-color":@"0000FF",
         @"border-color"    :@"FFFFFF",
         @"border-width"    :@"1",
         @"border-radius"   :@"8",
         @"margin"          :@"4 48 12 48",
         @"box-shadow"      :@"0 1 4 000000",
         @"background-image":@"linear-gradient(rgba(1.00, 1.00, 1.00, 0.75) 0.00, rgba(0.75, 0.75, 0.75, 0.50) 0.05, rgba(0.50, 0.50, 0.50, 0.50) 0.95, rgba(0.25, 0.25, 0.25, 0.75) 1.00)",
         }];
        [[[self rebirthButton] callStyleHighlighted] addStyleDictionary:@{
         @"background-image":@"linear-gradient(rgba(0.10, 0.10, 0.10, 0.90) 0.00, rgba(0.10, 0.10, 0.10, 0.50) 0.05, rgba(0.10, 0.10, 0.10, 0.50) 0.95, rgba(0.10, 0.10, 0.10, 0.90) 1.00)",
         }];
        [[[self rebirthButton] callStyleDisabled] addStyleDictionary:@{
         @"color"           :@"999999",
         @"background-image":@"linear-gradient(rgba(0.10, 0.10, 0.10, 0.90) 0.00, rgba(0.10, 0.10, 0.10, 0.50) 0.05, rgba(0.10, 0.10, 0.10, 0.50) 0.95, rgba(0.10, 0.10, 0.10, 0.90) 1.00)",
         }];
        [self addSubview:[self rebirthButton]];

    }
    return self;
}

#pragma mark -
#pragma mark method
//
// method
//

// ステータスの設定
- (void)loadStatus:(NSNumber *)numberValue
{
    [self setStatus:numberValue];
    
    // 正常時
    if([numberValue compare:@0] == NSOrderedSame)
    {
        [[self removeButton] setEnabled:YES];
        [[self removeButton] setHidden:NO];
        [[self rebirthButton] setHidden:YES];
    }
    // 削除時
    else if([numberValue compare:@9] == NSOrderedSame)
    {
        [[self removeButton] setEnabled:NO];
        [[self removeButton] setHidden:NO];
        [[self rebirthButton] setHidden:NO];
    }
}

@end
