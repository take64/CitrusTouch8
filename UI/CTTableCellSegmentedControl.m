//
//  CTTableCellSegmentedControl.m
//  ProtoRegi02
//
//  Created by TAKEMOTO KOUHEIon 11/12/21.
//  Copyright (c) 2011 citrus.tk. All rights reserved.
//

#import "CTTableCellSegmentedControl.h"

#import "CitrusTouchUI.h"
#import "CitrusTouchPlatform.h"

@implementation CTTableCellSegmentedControl

//
// synthesize
//
@synthesize _data;
@synthesize _segmentedControl;
@synthesize _isLayout;

#pragma mark -
#pragma mark UITableViewCell method
//
// UITableViewCell method
//

// 初期化
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        // 選択できないように
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 未レイアウトの場合
    if([self _isLayout] == NO)
    {
        // コンテンツビューフレーム
        CGRect frame = [[self contentView] frame];
        
        // 幅
        CGFloat widthCaption    = 0;            // キャプション幅
        CGFloat widthSegmented  = 0;            // セグメント幅
        CGFloat offsetSegmented  = 0;            // セグメント幅
        CGRect  rectCaption     = CGRectZero;   // キャプションサイズ
        CGRect  rectSegmented   = CGRectZero;   // セグメントサイズ
//        CGRect  rectSuffix      = CGRectZero;   // サフィックスサイズ
        
        // キャプションが有る場合
        if([[[self textLabel] text] length] > 0)
        {
            frame.size.width -= 20;
            
            if([CTPlatformDevice isIPhone] == YES)
            {
                widthCaption = 80;
            }
            else
            {
                widthCaption = 120;
            }
        }
        else
        {
            offsetSegmented = 4;
        }
        
        // テキストフィールド幅調整
        widthSegmented = frame.size.width - widthCaption - 70;

        
        
        // 配置(キャプション)
        rectCaption = [[self textLabel] frame];
        rectCaption.size.width = widthCaption;
        [[self textLabel] setFrame:rectCaption];
        
        // 配置(セグメント)
        rectSegmented = CGRectMake((rectCaption.origin.x + rectCaption.size.width + offsetSegmented),
                                   4,
                                   widthSegmented - (offsetSegmented * 2),
                                   frame.size.height - 10);
        [[self _segmentedControl] setFrame:rectSegmented];
        [[self contentView] addSubview:[self _segmentedControl]];
        
        
        // レイアウト済み
        [self set_isLayout:YES];
    }
}



#pragma mark -
#pragma mark extends method
//
// extends method
//

// 初期化
- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    return [self initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
}

// データ当て込み
- (void) bindData:(NSDictionary *)data
{
    // データセット
    [self set_data:data];
    
    // セグメントコントロール
    [self set_segmentedControl:[[UISegmentedControl alloc] initWithItems:[data allValues]]];
//    [[self _segmentedControl] setSegmentedControlStyle:UISegmentedControlStyleBar];
}

// 選択中のキーを取得
- (id) selectedKey
{
    if([[self _segmentedControl] selectedSegmentIndex] == -1)
    {
        return nil;
    }
    else
    {
        return [[[self _data] allKeys] objectAtIndex:[[self _segmentedControl] selectedSegmentIndex]];
    }
    
}

// 選択設定
- (void) setSelectedSegmentIndex:(NSInteger)index;
{
    [[self _segmentedControl] setSelectedSegmentIndex:index];
}

// 選択設定
- (void) setSelectedKey:(id)key;
{
    [[self _segmentedControl] setSelectedSegmentIndex:[[[self _data] allKeys] indexOfObject:key]];
}

// ターゲット
- (void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents
{
    [[self _segmentedControl] addTarget:target action:action forControlEvents:controlEvents];
}

@end
