//
//  CTTableCellTextFieldInnerTextField.m
//  CitrusTouch
//
//  Created by TAKEMOTO KOUHEIon 11/12/07.
//  Copyright (c) 2011 citrus.tk. All rights reserved.
//

#import "CTTableCellTextFieldInnerTextField.h"

@implementation CTTableCellTextFieldInnerTextField

//
// synthesize
//
@synthesize enableMenu;
@synthesize editingEndBlock;



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


#pragma mark -
#pragma mark method
//
// method
//

// ボタン押下時ブロック
- (void) setOnEditingEndComplete:(CTTableCellTextFieldInnerTextFieldEditingEndBlock)completeBlock
{
    // 設定
    [self setEditingEndBlock:completeBlock];
    [self addTarget:self action:@selector(onEditingEndTextField:) forControlEvents:UIControlEventEditingDidEnd];
}

// ボタン押下時
- (void) onEditingEndTextField:(CTTableCellTextFieldInnerTextField *)textFieldValue
{
    if(self.editingEndBlock != nil)
    {
        self.editingEndBlock(textFieldValue);
    }
}

@end
