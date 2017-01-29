//
//  CTTableCellFavorite.m
//  ChinottoPod
//
//  Created by kouhei.takemoto on 2017/01/07.
//  Copyright © 2017年 citrus.live. All rights reserved.
//

#import "CTTableCellFavorite.h"

@implementation CTTableCellFavorite

//
// synthesize
//
@synthesize switchBlock;
@synthesize on;

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 未レイアウトの場合
    if([self isSubLayout] == NO)
    {
        
        
        // レイアウト済み
        [self setSubLayout:YES];
    }
}


#pragma mark - private
//
// private
//

// ボタン押下時
- (void)onTapButton
{
    [self toggleSwitch];
    
    if(self.switchBlock != nil)
    {
        self.switchBlock(@([self isOn]));
    }
}


#pragma mark - method
//
// method
//

// 初期化
- (id) initWithPrefix:(NSString *)prefixString reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithPrefix:prefixString suffix:@"☆" reuseIdentifier:reuseIdentifier];
    if(self)
    {
        // ☆マーク
        [[self suffixLabel] setUserInteractionEnabled:YES];
        [[[self suffixLabel] callStyle] addStyleDictionary:@{
                                                             @"color"       :@"FF9933",
                                                             @"font-size"   :@"22"
                                                             }];
        [[self suffixLabel] addTarget:self action:@selector(onTapButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

// スイッチ
- (void)toggleSwitch
{
    if([self isOn] == YES)
    {
        [self switchOn:NO];
    }
    else
    {
        [self switchOn:YES];
    }
}

// スイッチ
- (void)switchOn:(BOOL)onValue
{
    [self setOn:onValue];
    
    // 描画
    [self drawSwitch];
}

// 描画
- (void)drawSwitch
{
    if([self isOn] == YES)
    {
        [[self suffixLabel] setText:@"★"];
    }
    else
    {
        [[self suffixLabel] setText:@"☆"];
    }
    [[self suffixLabel] setNeedsLayout];
}


@end
