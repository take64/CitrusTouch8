//
//  CTTableCellSegmentedControl.m
//  ProtoRegi02
//
//  Created by take64 on 11/12/21.
//  Copyright (c) 2011 citrus.tk. All rights reserved.
//

#import "CTTableCellSegmentedControl.h"

#import "CitrusTouchUI.h"
#import "CitrusTouchPlatform.h"

@implementation CTTableCellSegmentedControl

//
// synthesize
//
@synthesize _keys;
@synthesize _vals;
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
    
    // Configure the view for the selected state
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 未レイアウトの場合
    if([self _isLayout] == NO)
    {
        // セルの調整
        CGRect mainRect = [self frame];
        //        mainRect.origin.x = 24;
        //        mainRect.size.width -= 24;
        [self setFrame:mainRect];
        
        // コンテンツビューの調整
        CGRect contentRect = [self bounds];
        contentRect.origin.x = 10;
        contentRect.size.width -= 20;
        [[self contentView] setFrame:contentRect];
        
        // テキストフィールドの調整
        CGRect segmentRect = [[self contentView] bounds];
        segmentRect.origin.x = 40 + [self prefixWidth];
        segmentRect.origin.y =  5;
        segmentRect.size.width  -= (segmentRect.origin.x + 40);
        segmentRect.size.height -=  10;
        [[self _segmentedControl] setFrame:segmentRect];
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

// データ当て込み
- (void) bindDataKeys:(NSArray *)keys vals:(NSArray *)vals
{
    // データセット
    [self set_keys:keys];
    [self set_vals:vals];
    
    // セグメントコントロール
    [self set_segmentedControl:[[UISegmentedControl alloc] initWithItems:[self _vals]]];
}

// データ当て込み
- (void) bindData:(NSArray *)datas
{
    NSMutableArray *keys = [@[] mutableCopy];
    NSMutableArray *vals = [@[] mutableCopy];
    
    for(NSDictionary *one in datas)
    {
        [keys addObject:[[one allKeys] objectAtIndex:0]];
        [vals addObject:[[one allValues] objectAtIndex:0]];
    }
    [self bindDataKeys:keys vals:vals];
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
        return [[self _keys] objectAtIndex:[[self _segmentedControl] selectedSegmentIndex]];
    }
}

// 選択中の値を取得
- (id) selectedValue
{
    if([[self _segmentedControl] selectedSegmentIndex] == -1)
    {
        return nil;
    }
    else
    {
        return [[self _vals] objectAtIndex:[[self _segmentedControl] selectedSegmentIndex]];
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
    [[self _segmentedControl] setSelectedSegmentIndex:[[self _keys] indexOfObject:key]];
}

// イベント設定
- (void)addTarget:(id)idValue action:(SEL)selValue forControlEvents:(UIControlEvents)controlEventsValue
{
    [[self _segmentedControl] addTarget:idValue action:selValue forControlEvents:controlEventsValue];
}

@end;