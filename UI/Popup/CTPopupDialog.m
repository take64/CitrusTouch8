//
//  CTPopupDialog.m
//  CitrusTouch
//
//  Created by take64 on 2014/03/15.
//  Copyright (c) 2014年 citrus.tk. All rights reserved.
//

#import "CTPopupDialog.h"

@implementation CTPopupDialog

//
// synthesize
//
@synthesize contentView;
@synthesize contentFrame;
@synthesize innerFrame;
@synthesize titleLabel;
@synthesize _parentView;
@synthesize successBlock;
@synthesize failureBlock;
@synthesize successButton;
@synthesize failureButton;
@synthesize dialogType;

// 初期化
- (id)initWithFrame:(CGRect)frame
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self = [super initWithFrame:[[appDelegate window] bounds]];
    if (self)
    {
        // 背景
        [self setBackgroundColor:[CTColor colorWithHEXString:@"3333337F"]];
        
        CGRect insetFrame = frame;
        
        // コンテンツエリア
        [self setContentFrame:insetFrame];
        
        [self setContentView:[[CTControl alloc] initWithFrame:insetFrame]];
        [[[self contentView] callStyle] addStyleDictionary:@{
                                                             @"border-width"    :@"4",
                                                             @"border-color"    :@"FFFFFF",
                                                             @"border-radius"   :@"4",
                                                             @"background-color":@"333333",
                                                             }];
        [self addSubview:[self contentView]];
        
        // 内部エリア
        [self setInnerFrame:CGRectMake((4 + 4), (4 + 24 + 8), (insetFrame.size.width - (4 + 4 + 4 + 4)), (insetFrame.size.height - (4 + 4 + 24 + 60 + 8)))];
        
        // タイトル
        [self setTitleLabel:[[CTLabel alloc] initWithText:@""]];
        [[[self titleLabel] callStyle] addStyleDictionary:@{
                                                            @"top"              :@"4",
                                                            @"left"             :@"4",
                                                            @"width"            :[@(insetFrame.size.width - (4 + 4)) stringValue],
                                                            @"height"           :@"32",
                                                            @"font-size"        :@"20",
                                                            @"font-weight"      :@"bold",
                                                            @"color"            :@"FFFFFFFF",
//                                                            @"background-color" :@"FF0000FF",
                                                            }];
        [[self contentView] addSubview:[self titleLabel]];
        
        // ボタンスタイル
        CTStyle *buttonStyle = [[CTStyle alloc] initWithStyleDictionary:@{
                                                                          @"top"             :[@(insetFrame.size.height - 64) stringValue],
                                                                          @"width"           :@"152",
                                                                          @"height"          :@"64",
                                                                          @"font-size"       :@"20",
                                                                          @"font-weight"     :@"bold",
                                                                          @"text-shadow"     :@"0 -1 1 333333",
                                                                          @"margin"          :@"8",
                                                                          @"border-color"    :@"FFFFFF",
                                                                          @"border-width"    :@"1",
                                                                          @"border-radius"   :@"2",
                                                                          @"box-shadow"      :@"0 1 4 000000",
                                                                          @"background-image":@"linear-gradient(rgba(1.00, 1.00, 1.00, 0.75) 0.00, rgba(0.75, 0.75, 0.75, 0.50) 0.05, rgba(0.50, 0.50, 0.50, 0.50) 0.95, rgba(0.25, 0.25, 0.25, 0.75) 1.00)",
                                                                          }];
        
        // ボタン(OK)
        [self setSuccessButton:[[CTButton alloc] initWithText:@"OK"]];
        [[self successButton] setStyle:buttonStyle];
        [[[self successButton] callStyle] addStyleDictionary:@{
                                                               @"left"            :@"150",
                                                               @"background-color":@"0000FF",
                                                               }];
        [[[self successButton] callStyleHighlighted] addStyleDictionary:@{
                                                                          @"background-image":@"linear-gradient(rgba(0.10, 0.10, 0.10, 0.90) 0.00, rgba(0.10, 0.10, 0.10, 0.50) 0.05, rgba(0.10, 0.10, 0.10, 0.50) 0.95, rgba(0.10, 0.10, 0.10, 0.90) 1.00)",
                                                                          }];
        [[self successButton] addTarget:self action:@selector(onTapButtonSuccess) forControlEvents:UIControlEventTouchUpInside];
        [[self contentView] addSubview:[self successButton]];
        
        // ボタン(キャンセル)
        [self setFailureButton:[[CTButton alloc] initWithText:@"キャンセル"]];
        [[self failureButton] setStyle:buttonStyle];
        [[[self failureButton] callStyle] addStyleDictionary:@{
                                                               @"left"            :@"2",
                                                               @"background-color":@"FF0000",
                                                              }];
        [[[self failureButton] callStyleHighlighted] addStyleDictionary:@{
                                                                          @"background-image":@"linear-gradient(rgba(0.10, 0.10, 0.10, 0.90) 0.00, rgba(0.10, 0.10, 0.10, 0.50) 0.05, rgba(0.10, 0.10, 0.10, 0.50) 0.95, rgba(0.10, 0.10, 0.10, 0.90) 1.00)",
                                                                         }];
        
        [[self failureButton] addTarget:self action:@selector(onTapButtonFailure) forControlEvents:UIControlEventTouchUpInside];
        [[self contentView] addSubview:[self failureButton]];
        
        // ダイアログ設定
        [self setDialogType:CTPopupDialogTypeYESNO];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame type:(NSString *)typeValue
{
    self = [self initWithFrame:frame];
    if(self)
    {
        // ダイアログタイプ変更
        [self setDialogType:typeValue];
    }
    return self;
}

// 表示
- (void)showWithParentView:(UIView *)parentView
{
    CGRect rect = [parentView bounds];
    rect.origin.y = 0;
    [parentView setBounds:rect];
    
    [self set_parentView:parentView];
    
    [[self contentView] setCenter:[parentView center]];
    
    [[self _parentView] addSubview:self];
}

// 非表示
- (void)hide
{
    [self removeFromSuperview];
}

// ボタン押下時(OK)
- (void)onTapButtonSuccess
{
    if(self.successBlock != nil)
    {
        self.successBlock();
    }
    
    [self hide];
}

// ボタン押下時(NG)
- (void)onTapButtonFailure
{
    if(self.failureBlock != nil)
    {
        self.failureBlock();
    }
    
    [self hide];
}

// タイトル設定
- (void)setTitle:(NSString *)titleValue
{
    if([self titleLabel] != nil)
    {
        [[self titleLabel] setText:titleValue];
    }
}

// ダイアログタイプ変更
- (void)setDialogType:(NSString *)typeValue
{
    if([typeValue isEqualToString:CTPopupDialogTypeOK] == YES)
    {
        [[self contentView] addSubview:[self successButton]];
        [[self failureButton] removeFromSuperview];
        
        [[[self successButton] callStyle] addStyleKey:@"left" value:@"2"];
        [[[self successButton] callStyle] addStyleKey:@"width" value:@"302"];
    }
    else if([typeValue isEqualToString:CTPopupDialogTypeYESNO] == YES)
    {
        [[self contentView] addSubview:[self successButton]];
        [[self contentView] addSubview:[self failureButton]];
        
        [[[self successButton] callStyle] addStyleKey:@"left" value:@"152"];
        [[[self successButton] callStyle] addStyleKey:@"width" value:@"150"];
        
        [[[self failureButton] callStyle] addStyleKey:@"left" value:@"2"];
        [[[self failureButton] callStyle] addStyleKey:@"width" value:@"150"];
    }
}

@end
