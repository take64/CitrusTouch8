//
//  CTTextField.m
//  CitrusTouch
//
//  Created by TAKEMOTO KOUHEIon 11/12/07.
//  Copyright (c) 2011 citrus.tk. All rights reserved.
//

#import "CTTextField.h"

@implementation CTTextField

//
// synthesize
//
@synthesize enableMenu;



// 初期化
- (id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
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

@end
