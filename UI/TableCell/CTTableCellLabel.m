//
//  CTTableCellLabel.m
//  CitrusTouch
//
//  Created by TAKEMOTO KOUHEI on 2012/11/27.
//  Copyright (c) 2012年 citrus.tk. All rights reserved.
//

#import "CTTableCellLabel.h"

@implementation CTTableCellLabel

//
// synthesize
//
@synthesize label;


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 未レイアウトの場合
    if([self isSubLayout] == NO)
    {
        [[self label] setFrame:[self contentFrame]];
        
        CGRect labelRect = [[self label] frame];
        labelRect.size.width -= 16;
        labelRect.origin.x += 8;
        [[self label] setFrame:labelRect];
        
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
        // ラベル
        [self setLabel:[[CTLabel alloc] initWithText:@""]];
        [[[self label] callStyle] addStyleDictionary:@{
                                                       @"font-size" :@"16",
                                                       @"color"     :@"000000",
                                                       @"text-align":@"right",
                                                       @"line-break":@"clipping",
                                                       }];
        [[self label] setAutoresizingMask:(UIViewAutoresizingFlexibleLeftMargin |
                                           UIViewAutoresizingFlexibleRightMargin |
                                           UIViewAutoresizingFlexibleTopMargin |
                                           UIViewAutoresizingFlexibleBottomMargin |
                                           UIViewAutoresizingFlexibleWidth |
                                           UIViewAutoresizingFlexibleHeight)];
        [[self contentView] addSubview:[self label]];
        
        
        // セル選択
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        // タッチイベントは透過
        [[self label] setUserInteractionEnabled:NO];
    }
    return self;
}



// 初期化
- (id) initWithPrefix:(NSString *)prefixString content:(NSString *)textString suffix:(NSString *)suffixString reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [self initWithPrefix:prefixString suffix:suffixString reuseIdentifier:reuseIdentifier];
    if(self)
    {
        if(textString == nil)
        {
            textString = @"";
        }
        [[self label] setText:textString];
    }
    return self;
}

// 初期化
- (id) initWithPrefix:(NSString *)prefixString reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [self initWithPrefix:prefixString content:nil suffix:nil reuseIdentifier:reuseIdentifier];
    if(self)
    {
        
    }
    return self;
}


// テキスト取得
- (NSString *) contentText
{
    return [[self label] text];
}
// テキスト設定
- (void) setContentText:(NSString *)stringValue
{
    [[self label] setText:stringValue];
}

@end
