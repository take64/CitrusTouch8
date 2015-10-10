//
//  CTPopupDialog.m
//  CitrusTouch
//
//  Created by TAKEMOTO KOUHEI on 2014/03/15.
//  Copyright (c) 2014年 citrus.tk. All rights reserved.
//

#import "CTPopupDialog.h"

@implementation CTPopupDialog

//
// synthesize
//
@synthesize contentView;
@synthesize contentArea;
@synthesize _parentView;
@synthesize successBlock;
@synthesize failureBlock;
@synthesize successButton;
@synthesize failureButton;

// 初期化
- (id)initWithFrame:(CGRect)frame
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self = [super initWithFrame:[[appDelegate window] frame]];
    if (self)
    {
        // 背景
        [self setBackgroundColor:[CTColor colorWithHEXString:@"3333337F"]];
        
        CGRect insetFrame = frame;
        
        // コンテンツエリア
        [self setContentArea:CGRectMake(CL8(1), CL8(1), (insetFrame.size.width - CL8(2)), (insetFrame.size.height - CL8(9)))];
        
        [self setContentView:[[CTControl alloc] initWithFrame:insetFrame]];
        [[[self contentView] callStyle] addStyleDictionary:@{
                                                             @"border-width"    :@"4",
                                                             @"border-color"    :@"FFFFFF",
                                                             @"border-radius"   :@"4",
                                                             @"background-color":@"333333",
                                                             
                                                             }];
        [self addSubview:[self contentView]];
        
        
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
                                                               @"left"            :@"2",
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
                                                               @"left"            :@"150",
                                                               @"background-color":@"FF0000",
                                                              }];
        [[[self failureButton] callStyleHighlighted] addStyleDictionary:@{
                                                                          @"background-image":@"linear-gradient(rgba(0.10, 0.10, 0.10, 0.90) 0.00, rgba(0.10, 0.10, 0.10, 0.50) 0.05, rgba(0.10, 0.10, 0.10, 0.50) 0.95, rgba(0.10, 0.10, 0.10, 0.90) 1.00)",
                                                                         }];
        
        [[self failureButton] addTarget:self action:@selector(onTapButtonFailure) forControlEvents:UIControlEventTouchUpInside];
        [[self contentView] addSubview:[self failureButton]];
    }
    return self;
}

// 表示
- (void)showWithParentView:(UIView *)parentView
{
    [self set_parentView:parentView];
    
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

@end
