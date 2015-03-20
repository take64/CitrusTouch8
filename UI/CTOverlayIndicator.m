//
//  CTOverlayIndicator.m
//  CitrusTouch
//
//  Created by TAKEMOTO KOUHEI on 2013/02/01.
//  Copyright (c) 2013年 citrus.tk. All rights reserved.
//

#import "CTOverlayIndicator.h"

#import "CTStyle.h"
#import "CTLabel.h"

@implementation CTOverlayIndicator

//
// synthesize
//
@synthesize activityIndicator;
@synthesize titleLabel;
@synthesize messageLabel;
@synthesize _parentView;

// 初期化
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // 背景
        [[self callStyle] addStyleDictionary:@{
         @"background-color":@"0000007F",
        }];
        
        // パネル
        CTControl *panel = [[CTControl alloc] initWithFrame:CGRectZero];
        [[panel callStyle] addStyleDictionary:@{
         @"top"             :[CTString stringFromInt:((frame.size.height / 2) - (160 / 2))],
         @"left"            :[CTString stringFromInt:((frame.size.width / 2) - (240 / 2))],
         @"width"           :@"240",
         @"height"          :@"160",
         @"background-color":@"0000007F",
         @"border-radius"   :@"8",
         
//         @"background-color":@"FF0000",
        }];
        [self addSubview:panel];
        
        // タイトル
        [self setTitleLabel:[[CTLabel alloc] initWithFrame:CGRectZero]];
        [[[self titleLabel] callStyle] addStyleDictionary:@{
         @"top"             :@"0",
         @"left"            :@"0",
         @"width"           :@"240",
         @"height"          :@"32",
         @"font-size"       :@"16",
         @"font-weight"     :@"bold",
         
//         @"background-color":@"00FF00",
        }];
        [panel addSubview:[self titleLabel]];
        
        // アクティビティインジケーター
        [self setActivityIndicator:[[UIActivityIndicatorView alloc] initWithFrame:CGRectZero]];
        [[self activityIndicator] setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [[self activityIndicator] setCenter:CGPointMake(CL8(15), CL8(10))];
        [panel addSubview:[self activityIndicator]];
        
        // メッセージ
        [self setMessageLabel:[[CTLabel alloc] initWithFrame:CGRectZero]];
        [[[self messageLabel] callStyle] addStyleDictionary:@{
         @"top"             :@"128",
         @"left"            :@"0",
         @"width"           :@"240",
         @"height"          :@"32",
         @"font-size"       :@"14",
         
//         @"background-color":@"FF00FF",
         }];
        [panel addSubview:[self messageLabel]];
        
    }
    return self;
}


#pragma mark -
#pragma mark method
//
// method
//

// 初期化
- (id) initWithParentView:(UIView *)parentView
{
    CGRect parentFrame = [parentView frame];
    CGFloat width;
    CGFloat height;
    if([[UIDevice currentDevice] orientation] == UIDeviceOrientationPortrait)
    {
        width   = MIN(parentFrame.size.width, parentFrame.size.height);
        height  = MAX(parentFrame.size.width, parentFrame.size.height);
    }
    else
    {
        width   = MAX(parentFrame.size.width, parentFrame.size.height);
        height  = MIN(parentFrame.size.width, parentFrame.size.height);
    }
    if(parentFrame.size.width != width)
    {
        parentFrame.origin.y = 0;
        parentFrame.origin.x = 0;
    }
    
    parentFrame.size.width = width;
    parentFrame.size.height = height;
    
    self = [self initWithFrame:parentFrame];
    if(self)
    {
        // 親ビュー
        [self set_parentView:parentView];
        
    }
    return self;
}


// 表示
- (void) show
{
    // 回転開始
    [[self activityIndicator] startAnimating];
    
    // 表示
    [[self _parentView] addSubview:self];
}

// 非表示
- (void) hide
{
    // 回転停止
    [[self activityIndicator] stopAnimating];
    
    // 非表示
    [self removeFromSuperview];
}

// タイトル
- (void) setTitle:(NSString *) stringValue
{
    [[self titleLabel] setText:stringValue];
}

// メッセージ
- (void) setMessage:(NSString *) stringValue
{
    [[self messageLabel] setText:stringValue];
}


@end
