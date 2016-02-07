//
//  CTTableCell.m
//  CitrusTouch
//
//  Created by take64 on 2012/11/27.
//  Copyright (c) 2012年 citrus.tk. All rights reserved.
//

#import "CTTableCell.h"

#import "CitrusTouchPlatform.h"

@implementation CTTableCell

//
// synthesize
//
@synthesize prefixLabel;
@synthesize suffixLabel;
@synthesize prefixWidth;
@synthesize suffixWidth;
@synthesize contentFrame;
@synthesize layout;
@synthesize subLayout;
@synthesize responder;
@synthesize prevCell;
@synthesize nextCell;
@synthesize prevIndexPath;
@synthesize nextIndexPath;
@synthesize toolbar;
@synthesize segmentedPrevNext;
@synthesize prefixPriority;
@synthesize contentPriority;
@synthesize suffixPriority;
@synthesize bgView;

//
// dynamic
//
@synthesize activateColor;
@synthesize deactivateColor;


// 初期化
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        // 未レイアウト
        [self setLayout:NO];
        [self setSubLayout:NO];
        
        // 背景
        [self setBgView:[[CTControl alloc] initWithFrame:[self frame]]];
        [[self bgView] setUserInteractionEnabled:NO];
        [self addSubview:[self bgView]];
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    if(selected == YES)
    {
        [self activate];
    }
    else
    {
        [self deactivate];
    }
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 未レイアウトの場合
    if([self isLayout] == NO)
    {
        // コンテンツフレーム
        CGRect contentRect = [[self contentView] frame];
        
        
        // 背景
        [[self bgView] setFrame:contentRect];
        
        // アクセサリがある場合(アクセサリ分を縮める)
        if([self accessoryType] != UITableViewCellAccessoryNone)
        {
            contentRect.size.width -= 8;
        }
        else
        {
//            contentRect.size.width -= 8;
        }
        
        
        // プレフィックスサイズ
//        CGFloat prefixWidth = 0;
        if(([[self prefixLabel] text] != nil && [[[self prefixLabel] text] length] > 0) || [self prefixWidth] > 0)
        {
            // prefix優先度(非表示)
            if([self prefixPriority] == CTTableCellPartPriorityHidden)
            {
                [self setPrefixWidth:0];
            }
            // prefix優先度(高)
            else if([self prefixPriority] == CTTableCellPartPriorityHigh)
            {
                CGSize prefixFontSize = [[[self prefixLabel] text] sizeWithAttributes:@{ NSFontAttributeName :[[[self prefixLabel] callStyle] callFont] }];
                [self setPrefixWidth:prefixFontSize.width + 16];
            }
            // prefix優先度(中/低)
            else if([self prefixPriority] == CTTableCellPartPriorityMiddle || [self prefixPriority] == CTTableCellPartPriorityLow)
            {
                [self setPrefixWidth:8];
                if([CTPlatformDevice isIPad] == YES)
                {
                    [self setPrefixWidth:120];
                }
                else
                {
                    [self setPrefixWidth:80];
                }
            }
        }
        CGRect prefixRect = CGRectMake(16, 0, [self prefixWidth], contentRect.size.height);
        [[self prefixLabel] setFrame:prefixRect];
        
        
        // サフィックスサイズ
//        CGFloat suffixWidth = 16;
        if(([[self suffixLabel] text] != nil && [[[self suffixLabel] text] length] > 0) || [self suffixWidth] > 0)
        {
            // suffix優先度(高/中)
            if([self suffixPriority] == CTTableCellPartPriorityHigh || [self suffixPriority] == CTTableCellPartPriorityMiddle)
            {
                CGSize suffixFontSize = [[[self suffixLabel] text] sizeWithAttributes:@{ NSFontAttributeName:[[[self suffixLabel] callStyle] callFont] }];
                [self setSuffixWidth:suffixFontSize.width + 16];
            }
            // suffix優先度(低)
            else if([self suffixPriority] == CTTableCellPartPriorityLow)
            {
                CGSize suffixFontSize = [[[self suffixLabel] text] sizeWithAttributes:@{ NSFontAttributeName:[[[self suffixLabel] callStyle] callFont]}];
                [self setSuffixWidth:suffixFontSize.width];
            }
            // suffix優先度(非表示)
            else if([self suffixPriority] == CTTableCellPartPriorityHidden)
            {
                [self setSuffixWidth:0];
            }
        }
        CGRect suffixRect = CGRectMake(contentRect.size.width - [self suffixWidth] , 0, [self suffixWidth], contentRect.size.height);
        [[self suffixLabel] setFrame:suffixRect];
        
        
        // コンテンツサイズ変更
        contentRect.origin.x += [self prefixWidth];
        contentRect.size.width -= [self prefixWidth];
        contentRect.size.width -= [self suffixWidth];
        [self setContentFrame:contentRect];
        
        // レイアウト済み
        [self setLayout:YES];
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
    self = [self initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if(self)
    {
        // 優先度
        [self setPriorityPrefix:CTTableCellPartPriorityMiddle content:CTTableCellPartPriorityMiddle suffix:CTTableCellPartPriorityMiddle];
        
        // プレフィックス
        [self setPrefixLabel:[[CTLabel alloc] initWithText:prefixString]];
        [[[self prefixLabel] callStyle] addStyleDictionary:
         [NSDictionary dictionaryWithObjectsAndKeys:
          @"14",        @"font-size",
          @"333333",    @"color",
          @"left",      @"text-align",
          @"bold",      @"font-weight",
          nil]];
        [[self contentView] addSubview:[self prefixLabel]];
        
        // サフィックス
        [self setSuffixLabel:[[CTLabel alloc] initWithText:suffixString]];
        [[[self suffixLabel] callStyle] addStyleDictionary:
         [NSDictionary dictionaryWithObjectsAndKeys:
          @"14",        @"font-size",
          @"333333",    @"color",
          @"center",    @"text-align",
          nil]];
        [[self contentView] addSubview:[self suffixLabel]];
        
        
        
        // ツールバー
        [self setToolbar:[[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)]];
        [[self toolbar] setBarStyle:UIBarStyleBlackOpaque];
        [[self toolbar] setTranslucent:YES];
        [self setSegmentedPrevNext:[[UISegmentedControl alloc] initWithItems:@[@"前へ", @"次へ"]]];
//        [[self segmentedPrevNext] setSegmentedControlStyle:UISegmentedControlStyleBar];
        [[self segmentedPrevNext] addTarget:self action:@selector(onChangeSegmentedPrevNext:) forControlEvents:UIControlEventValueChanged];
        [[self segmentedPrevNext] setTintColor:[UIColor whiteColor]];
        UIBarButtonItem *barButtonPrevNext = [[UIBarButtonItem alloc] initWithCustomView:[self segmentedPrevNext]];
        
        // ツールバーパーツ
        UIBarButtonItem *barSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        UIBarButtonItem *barButtonDone = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(onTapBarButtonDone)];
        [barButtonDone setTintColor:[UIColor whiteColor]];
        [[self toolbar] setItems:[NSArray arrayWithObjects:barButtonPrevNext, barSpacer, barButtonDone, nil]];
        
    }
    return self;
}

// アクティブ
- (void) activate
{
    [self setBackgroundColor:[self activateColor]];
}

// デアクティブ
- (void) deactivate
{
    [self setBackgroundColor:[self deactivateColor]];
}

// ボタン押下時(キーボードDONE)
- (void) onTapBarButtonDone
{
    if([[self responder] canResignFirstResponder] == YES)
    {
        [[self responder] resignFirstResponder];
    }
}

// 値変更時(前後ボタン)
- (void) onChangeSegmentedPrevNext:(UISegmentedControl *)segmentedControl
{
    switch ([segmentedControl selectedSegmentIndex])
    {
        case 0: // 前へ
            if([self prevCell] != nil && [[self prevCell] responder] != nil && [[[self prevCell] responder] canBecomeFirstResponder] == YES)
            {
//                UITableView *tableView = (UITableView *)[self superview];
//                [tableView scrollToRowAtIndexPath:[self prevIndexPath] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
                [[[self prevCell] responder] becomeFirstResponder];
            }
            break;
        case 1: // 次へ
            if([self nextCell] != nil && [[self nextCell] responder] != nil && [[[self nextCell] responder] canBecomeFirstResponder] == YES)
            {
//                UITableView *tableView = (UITableView *)[self superview];
//                [tableView scrollToRowAtIndexPath:[self nextIndexPath] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
                [[[self nextCell] responder] becomeFirstResponder];
            }
        default:
            break;
    }
    
    // リフレッシュ
    [self refreshSegmentedPrevNext];
}

// リフレッシュ(前後ボタン)
- (void) refreshSegmentedPrevNext
{
    // 前後ボタン
    if([self prevCell] != nil && [[self prevCell] responder] != nil)
    {
        [[self segmentedPrevNext] setEnabled:YES forSegmentAtIndex:0];
    }
    else
    {
        [[self segmentedPrevNext] setEnabled:NO forSegmentAtIndex:0];
    }
    if([self nextCell] != nil && [[self nextCell] responder] != nil)
    {
        [[self segmentedPrevNext] setEnabled:YES forSegmentAtIndex:1];
    }
    else
    {
        [[self segmentedPrevNext] setEnabled:NO forSegmentAtIndex:1];
    }
    [[self segmentedPrevNext] setMomentary:YES];
}
// レスポンダ設定(前へ)
- (void) setPrevCellResponder:(CTTableCell *)tableCell
{
    if([tableCell isKindOfClass:[CTTableCellTextField class]] == YES
       || [tableCell isKindOfClass:[CTTableCellDatePicker class]] == YES
       || [tableCell isKindOfClass:[CTTableCellTextView class]] == YES)
    {
        // 後ポインタの設定
        [tableCell setNextCellResponder:self];
        
        // 前ポインタの設定
        [self setPrevCell:tableCell];
        
        // リフレッシュ
        [self refreshSegmentedPrevNext];
    }
}
// レスポンダ設定(次へ)
- (void) setNextCellResponder:(CTTableCell *)tableCell
{
    if([tableCell isKindOfClass:[CTTableCellTextField class]] == YES
       || [tableCell isKindOfClass:[CTTableCellDatePicker class]] == YES
       || [tableCell isKindOfClass:[CTTableCellTextView class]] == YES)
    {
        // 後ポインタの設定
        [self setNextCell:tableCell];
        
        // リフレッシュ
        [self refreshSegmentedPrevNext];
    }
}
// レスポンダ設定(前へ)
- (void) setPrevCellResponder:(CTTableCell *)tableCell indexPath:(NSIndexPath *)indexPath
{
    // IndexPath
    [self setPrevIndexPath:indexPath];
    
    // レスポンダ
    [self setPrevCellResponder:tableCell];
}
// レスポンダ設定(次へ)
- (void) setNextCellResponder:(CTTableCell *)tableCell indexPath:(NSIndexPath *)indexPath
{
    // IndexPath
    [self setNextIndexPath:indexPath];
    
    // レスポンダ
    [self setNextCellResponder:tableCell];
}

// 優先度設定
- (void) setPriorityPrefix:(CTTableCellPartPriority)prefix content:(CTTableCellPartPriority)content suffix:(CTTableCellPartPriority)suffix
{
    [self setPrefixPriority:prefix];
    [self setContentPriority:content];
    [self setSuffixPriority:suffix];
}

// アクティブ色
- (CTColor *) activateColor
{
    return nil;
}

// デアクティブ色
- (CTColor *) deactivateColor
{
    return nil;
}

@end
