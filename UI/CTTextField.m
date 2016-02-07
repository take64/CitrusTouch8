//
//  CTTextField.m
//  CitrusTouch
//
//  Created by take64 on 11/12/07.
//  Copyright (c) 2011 citrus.tk. All rights reserved.
//

#import "CTTextField.h"

@implementation CTTextField

//
// synthesize
//
@synthesize enableMenu;
@synthesize toolbar;



// 初期化
- (id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        // メニュー表示ON
        [self setEnableMenu:YES];
        
        // ツールバー
        [self setToolbar:[[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)]];
        [[self toolbar] setBarStyle:UIBarStyleBlackOpaque];
        [[self toolbar] setTranslucent:YES];
        
        // ツールバーパーツ
        UIBarButtonItem *barSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        UIBarButtonItem *barButtonDone = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(onTapBarButtonDone)];
        [barButtonDone setTintColor:[UIColor whiteColor]];
        [[self toolbar] setItems:@[ barSpacer, barButtonDone ]];
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

- (void)onTapBarButtonDone
{
    if([self canResignFirstResponder] == YES)
    {
        [self resignFirstResponder];
    }
}

@end
