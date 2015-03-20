//
//  CTLabel.m
//  Panel15
//
//  Created by TAKEMOTO KOUHEI on 2012/09/30.
//  Copyright (c) 2012年 citrus.tk. All rights reserved.
//

#import "CTLabel.h"

#import "CitrusTouchUI.h"

@implementation CTLabel

//
// synthesize
//


// 初期化
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUserInteractionEnabled:NO];
    }
    return self;
}


// 表示設定
- (void)setText:(NSString *)textString
{
    [super setText:textString];
    [self setNeedsDisplay];
}


@end
