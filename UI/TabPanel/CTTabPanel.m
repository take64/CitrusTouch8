//
//  CTTabPanel.m
//  SocialGameTimer
//
//  Created by take64 on 2013/03/23.
//  Copyright (c) 2013年 citrus.tk. All rights reserved.
//

#import "CTTabPanel.h"

#import "CTButton.h"
#import "CTStyle.h"

@implementation CTTabPanel

//
// synthesize
//
@synthesize tabButtons;
@synthesize tabPanes;
@synthesize tabViews;
@synthesize tabColorStrings;
@synthesize scrollPane;
@synthesize tabButtonHeight;

// 初期化
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // 背景
        [self setBackgroundColor:[UIColor blueColor]];
        
        // 初期化
        [self setTabButtons:        [NSMutableArray arrayWithCapacity:1]];
        [self setTabPanes:          [NSMutableArray arrayWithCapacity:1]];
        [self setTabColorStrings:   [NSMutableArray arrayWithCapacity:1]];
        
        // タブボタン高さ
        [self setTabButtonHeight:32];
        
        // スクロール
        [self setScrollPane:[[UIScrollView alloc] initWithFrame:CGRectMake(frame.origin.x, [self tabButtonHeight], frame.size.width, (frame.size.height - [self tabButtonHeight]))]];
        [[self scrollPane] setContentSize:CGSizeMake(frame.size.width, (frame.size.height - [self tabButtonHeight]))];
        [[self scrollPane] setPagingEnabled:YES];
        [[self scrollPane] setBounces:NO];
        [self addSubview:[self scrollPane]];
        
    }
    return self;
}


-(void) setNeedsDisplay
{
    [super setNeedsDisplay];
}


#pragma mark -
#pragma mark method
//
// method
//

// タブ追加
- (void) addWithTitle:(NSString *)title tabView:(UIView *)tabView colorString:(NSString *)colorString
{
    // 追加場所のindex
    NSUInteger index = [[self tabButtons] count];
    
//    // 場所
//    CGFloat buttonWidth = ([self frame].size.width) / (index + 1);
//    CGFloat buttonLeft = (buttonWidth * index);
    
    
    // ボタン
    CTButton *tabButton = [[CTButton alloc] initWithText:title];
    [[tabButton callStyle] addStyleDictionary:@{
     @"left"                :@"0",
     @"top"                 :@"0",
     @"width"               :@"320",
     @"height"              :[CTString stringFromFloat:[self tabButtonHeight] + 2],
     
     @"font-size"           :@"16",
     @"font-weight"         :@"bold",
     @"text-shadow"         :@"0 1 1 333333",
     @"background-color"    :colorString,
     @"border-color"        :@"FFFFFF",
     @"border-width"        :@"1",
     @"border-radius"       :@"8 8 0 0",
     @"margin"              :@"0 4 0 4",
     @"box-shadow"          :@"0 1 4 000000",
     @"background-image"    :@"linear-gradient(rgba(1.00, 1.00, 1.00, 0.75) 0.00, rgba(0.75, 0.75, 0.75, 0.25) 0.05, rgba(0.50, 0.50, 0.50, 0.25) 0.95, rgba(0.25, 0.25, 0.25, 0.75) 1.00)",
     }];
    [[tabButton callStyleHighlighted] addStyleDictionary:@{
     @"background-image":@"linear-gradient(rgba(0.10, 0.10, 0.10, 0.90) 0.00, rgba(0.10, 0.10, 0.10, 0.50) 0.05, rgba(0.10, 0.10, 0.10, 0.50) 0.95, rgba(0.10, 0.10, 0.10, 0.90) 1.00)"
     }];
    [tabButton addTarget:self action:@selector(onTapTabButton:) forControlEvents:UIControlEventTouchUpInside];
    [[self tabButtons] addObject:tabButton];
    [self addSubview:tabButton];
    
    
    
    // ペーン
    CTControl *tabPane = [[CTControl alloc] initWithFrame:CGRectZero];
    [[tabPane callStyle] setStyleDictionary:@{
     @"left"    :[CTString stringFromFloat:([self frame].size.width * index)],
     @"top"     :@"0",
     @"width"   :[CTString stringFromFloat:[[self scrollPane] frame].size.width],
     @"height"  :[CTString stringFromFloat:[[self scrollPane] frame].size.height],
     @"border-color"        :@"FFFFFF",
     @"border-width"        :@"1",
     @"background-color"    :colorString,
     @"background-image"    :@"linear-gradient(rgba(0.50, 0.50, 0.50, 0.25) 0.00, rgba(0.50, 0.50, 0.50, 0.25) 1.00)",
     }];
    [[self tabPanes] addObject:tabPane];
    [[self scrollPane] addSubview:tabPane];
    
    // ビュー
    [tabPane addSubview:tabView];
    
    // 色
    [[self tabColorStrings] addObject:colorString];
    
    
    // ボタンの再配置
    [self resizeTabButtons];
    
    // ペーン再配置
    [self resizeTabPanes];
}

// タブのリサイズ
- (void) resizeTabButtons
{
    // タブ数
    NSUInteger count = [[self tabButtons] count];
    
    // 場所
    CGFloat buttonWidth = [self frame].size.width / count;
    CGFloat buttonLeft;
    
    // 対象
    CTButton *tabButton;
    
    for(int i = 0; i < count; i++)
    {
        buttonLeft = (buttonWidth * i);
        
        tabButton = [[self tabButtons] objectAtIndex:i];
        [[tabButton callStyle] setStyleDictionary:@{
         @"left"    :[CTString stringFromFloat:buttonLeft],
         @"width"   :[CTString stringFromFloat:buttonWidth],
         }];
    }
}

// ペーンのリサイズ
- (void) resizeTabPanes
{
    // タブ数
    NSUInteger count = [[self tabButtons] count];
    
    // 場所
//    CGFloat paneWidth = [self frame].size.width / count;
    CGFloat paneLeft;
    
    // 対象
    CTControl *tabPane;
    
    for(int i = 0; i < count; i++)
    {
        paneLeft = ([self frame].size.width * i);
        
        tabPane = [[self tabPanes] objectAtIndex:i];
        [[tabPane callStyle] setStyleDictionary:@{
         @"left"    :[CTString stringFromFloat:paneLeft],
         @"top"     :@"0",
         @"width"   :[CTString stringFromFloat:[[self scrollPane] frame].size.width],
         @"height"  :[CTString stringFromFloat:[[self scrollPane] frame].size.height],
         }];
    }
    
    CGSize scrollSize = [[self scrollPane] contentSize];
    scrollSize.width = ([self frame].size.width * count);
    [[self scrollPane] setContentSize:scrollSize];
    
    // 再配置
    [[self scrollPane] removeFromSuperview];
    [self addSubview:[self scrollPane]];
}

// ボタン押下時(タブボタン)
- (void) onTapTabButton:(CTButton *)tabButton
{
    // index
    NSUInteger index = [[self tabButtons] indexOfObject:tabButton];
    
    // スクロールさせる
    [[self scrollPane] setContentOffset:CGPointMake(([self frame].size.width * index), 0) animated:YES];
}

@end
