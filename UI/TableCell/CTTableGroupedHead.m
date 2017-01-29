//
//  CTTableGroupedHead.m
//  CitrusTouch
//
//  Created by take64 on 2013/02/16.
//  Copyright (c) 2013年 citrus.tk. All rights reserved.
//

#import "CTTableGroupedHead.h"

@implementation CTTableGroupedHead

//
// synthesize
//
@synthesize cellView;

// 初期化
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // ヘッダビュー
        [self setCellView:[[CTControl alloc] initWithText:@""]];
        [[[self cellView] callStyle] addStyleDictionary:@{
         @"width"           :@"320",
         @"height"          :@"24",
         @"text-align"      :@"left",
         @"text-shadow"     :@"0 -1 1 666666",
         @"font-weight"     :@"bold",
         @"font-size"       :@"16",
         @"color"           :@"FFFFFF",
         @"padding"         :@"0 0 0 16",
         @"background-color":@"008080",
         }];
        [self addSubview:[self cellView]];
    }
    return self;
}

// 初期化
- (id) initWithText:(NSString *)textString
{
    self = [self initWithFrame:CGRectZero];
    if(self)
    {
        // タイトル
        [self setText:textString];
    }
    return self;
    
}

// テキストの設定
- (void)setText:(NSString *)textString
{
    [[self cellView] setText:textString];
}

// 色の設定
- (void)setTintColor:(NSString *)tintColorString
{
    [[[self cellView] callStyle] addStyleKey:@"background-color" value:tintColorString];
}

- (void)layoutSubviews
{
    // 自動で高さ調節しておく
    CGRect rect = [self frame];
    CGFloat height = rect.size.height;
    [[[self cellView] callStyle] addStyleKey:@"height" value:CTStringFromFloat(height)];
}

@end
