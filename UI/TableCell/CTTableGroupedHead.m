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
@synthesize titleLabel;


//
// dynamic
//
@dynamic tintColor;


// 初期化
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // ヘッダビュー
        [self setCellView:[[CTControl alloc] initWithText:@""]];
        [[[self cellView] callStyle] addStyleDictionary:@{
//         @"left"            :@"9",
//         @"top"             :@"0",
         @"width"           :@"320",
         @"height"          :@"24",
         @"text-align"      :@"left",
         @"text-shadow"     :@"0 -1 1 666666",
         @"font-weight"     :@"bold",
         @"font-size"       :@"16",
         @"color"           :@"FFFFFF",
         @"padding"         :@"0 0 0 16",
//         @"margin"          :@"8 8 8 0",
         
         
         @"background-color":@"008080",
//         @"border-color"    :@"A1A7AD",
//         @"border-width"    :@"1 1 0 1",
//         @"border-radius"   :@"0 16 16 0",
//         @"background-image" :@"linear-gradient(rgba(1.00, 1.00, 1.00, 0.75) 0.00, rgba(0.75, 0.75, 0.75, 0.25) 0.05, rgba(0.50, 0.50, 0.50, 0.25) 0.95, rgba(0.25, 0.25, 0.25, 0.75) 1.00)",
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
        [[self cellView] setText:textString];
    }
    return self;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
