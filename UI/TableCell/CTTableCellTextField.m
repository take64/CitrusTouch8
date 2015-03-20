//
//  CTTableCellTextField.m
//  CitrusTouch
//
//  Created by TAKEMOTO KOUHEI on 2012/11/27.
//  Copyright (c) 2012年 citrus.tk. All rights reserved.
//

#import "CTTableCellTextField.h"

@implementation CTTableCellTextField

//
// synthesize
//
@synthesize textField;


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 未レイアウトの場合
    if([self isSubLayout] == NO)
    {
        [[self textField] setFrame:[self contentFrame]];
        
        CGRect textFieldRect = [[self textField] frame];
        textFieldRect.size.width -= 8;
        textFieldRect.origin.x += 8;
        [[self textField] setFrame:textFieldRect];
        
        // レイアウト済み
        [self setSubLayout:YES];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    if(selected == YES)
    {
        if([[self textField] canBecomeFirstResponder] == YES)
        {
            [[self textField] becomeFirstResponder];
        }
    }
}




#pragma mark -
#pragma mark UITextFieldDelegate
//
// UITextFieldDelegate
//

// 編集開始前
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textFieldValue
{
    [self activate];
    return YES;
}
//- (void)textFieldDidBeginEditing:(UITextField *)textField;
//- (BOOL)textFieldShouldEndEditing:(UITextField *)textField;
// 編集終了後
- (void)textFieldDidEndEditing:(UITextField *)textFieldValue
{
    [self deactivate];
}
//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
//- (BOOL)textFieldShouldClear:(UITextField *)textField;
//- (BOOL)textFieldShouldReturn:(UITextField *)textField;




#pragma mark -
#pragma mark method
//
// method
//

// 初期化
- (id) initWithPrefix:(NSString *)prefixString suffix:(NSString *)suffixString reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithPrefix:prefixString suffix:suffixString reuseIdentifier:reuseIdentifier];
    if(self)
    {
        // テキストフィールド
        [self setTextField:[[CTTableCellTextFieldInnerTextField alloc] initWithFrame:CGRectZero]];
        [[self textField] setFont:[UIFont systemFontOfSize:16.0]];
        [[self textField] setClearButtonMode:UITextFieldViewModeWhileEditing];
        [[self textField] setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        [[self textField] setAutocapitalizationType:UITextAutocapitalizationTypeNone];
        [[self textField] setReturnKeyType:UIReturnKeyDone];
        [[self textField] setAutoresizingMask:(UIViewAutoresizingFlexibleLeftMargin |
                                                UIViewAutoresizingFlexibleRightMargin |
                                                UIViewAutoresizingFlexibleTopMargin |
                                                UIViewAutoresizingFlexibleBottomMargin |
                                                UIViewAutoresizingFlexibleWidth	|
                                                UIViewAutoresizingFlexibleHeight)];
        [[self textField] setDelegate:self];
        [self setResponder:[self textField]];
        [[self contentView] addSubview:[self textField]];
        
        
        // セル選択
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        
        // ツールバー(配置)
        [[self textField] setInputAccessoryView:[self toolbar]];
    }
    return self;
}

// 初期化
- (id) initWithPrefix:(NSString *)prefixString content:(NSString *)textString suffix:(NSString *)suffixString reuseIdentifier:(NSString *)reuseIdentifier
{
    
    self = [self initWithPrefix:prefixString suffix:suffixString reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [[self textField] setText:textString];
    }
    return self;
}

// テキスト取得
- (NSString *) contentText
{
    if([[self textField] text] == nil)
    {
        return @"";
    }
    return [[self textField] text];
}
// テキスト設定
- (void) setContentText:(NSString *)stringValue
{
    [[self textField] setText:stringValue];
}

@end
