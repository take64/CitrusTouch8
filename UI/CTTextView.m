//
//  CTTextView.m
//  CitrusTouch
//
//  Created by take64 on 2013/02/05.
//  Copyright (c) 2013年 citrus.tk. All rights reserved.
//

#import "CTTextView.h"

@implementation CTTextView


//
// synthesize
//
@synthesize enableMenu;

// 初期化
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // メニュー表示ON
        [self setEnableMenu:YES];
    }
    return self;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if([self enableMenu] == NO)
    {
        [[UIMenuController sharedMenuController] setMenuVisible:NO];
        [self resignFirstResponder];
    }
    return [super canPerformAction:action withSender:sender];
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
