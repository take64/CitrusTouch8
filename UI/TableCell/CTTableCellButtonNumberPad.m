//
//  CTTableCellButtonNumberPad.m
//  CitrusTouch
//
//  Created by take64 on 2012/11/27.
//  Copyright (c) 2012年 citrus.tk. All rights reserved.
//

#import "CTTableCellButtonNumberPad.h"

@implementation CTTableCellButtonNumberPad

//
// synthesize
//
@synthesize removeButton;
@synthesize selectButton;


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 未レイアウトの場合
    if([self isSubLayout] == NO)
    {
//        [[self selectButton] setFrame:[[self prefixLabel] frame]];
        
        [[self textField] setFrame:[self contentFrame]];
        CGRect textFieldRect = [[self textField] frame];
        textFieldRect.size.width -= 88;
        textFieldRect.origin.x += 88;
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
    self = [super initWithPrefix:nil suffix:suffixString reuseIdentifier:reuseIdentifier];
    if(self)
    {
        // ボタン
        [self setRemoveButton:[[CTButton alloc] initWithText:@"×"]];
        [[[self removeButton] callStyle] addStyleDictionary:@{
                                                              @"left"               :@"0",
                                                              @"top"                :@"0",
                                                              @"width"              :@"48",
                                                              @"height"             :@"48",
                                                              @"font-size"          :@"38",
                                                              @"font-weight"        :@"bold",
                                                              @"color"              :@"FF0000",
                                                              @"background-color"   :@"FF9999",
                                                              @"border-color"       :@"FF0000",
                                                              @"border-width"       :@"1",
                                                              @"border-radius"      :@"12",
                                                              @"margin"             :@"12",
                                                              @"padding"            :@"-15 0 0 0",
                                                              }];
        [[[self removeButton] callStyleHighlighted] addStyleDictionary:@{
                                                                         @"background-image":@"linear-gradient(rgba(0.10, 0.10, 0.10, 0.90) 0.00, rgba(0.10, 0.10, 0.10, 0.50) 0.05, rgba(0.10, 0.10, 0.10, 0.50) 0.95, rgba(0.10, 0.10, 0.10, 0.90) 1.00)",
                                                                         }];
        [[[self removeButton] callStyleDisabled] addStyleDictionary:@{
                                                                      @"background-color":@"666666",
                                                                      }];
        [self addSubview:[self removeButton]];
        
        [self setSelectButton:[[CTButton alloc] initWithText:prefixString]];
        [[[self selectButton] callStyle] addStyleDictionary:@{
                                                              @"left"               :@"40",
                                                              @"width"              :@"80",
                                                              @"font-size"          :@"14",
                                                              @"font-weight"        :@"bold",
                                                              @"color"              :@"333333",
                                                              @"background-color"   :@"FFFFFF",
                                                              @"border-color"       :@"CCCCCC",
                                                              @"border-width"       :@"1",
                                                              @"border-radius"      :@"4",
                                                              @"margin"             :@"4",
                                                              }];
        [[[self selectButton] callStyleHighlighted] addStyleDictionary:@{
                                                                         @"background-image":@"linear-gradient(rgba(0.10, 0.10, 0.10, 0.90) 0.00, rgba(0.10, 0.10, 0.10, 0.50) 0.05, rgba(0.10, 0.10, 0.10, 0.50) 0.95, rgba(0.10, 0.10, 0.10, 0.90) 1.00)",
                                                                         }];
        [[[self selectButton] callStyleDisabled] addStyleDictionary:@{
                                                                      @"background-color":@"666666",
                                                                      }];
        [self addSubview:[self selectButton]];
        
        
        
        
        
//        // テキストフィールド
//        [self setTextField:[[CTTableCellTextFieldInnerTextField alloc] initWithFrame:CGRectZero]];
//        [[self textField] setFont:[UIFont systemFontOfSize:16.0]];
//        [[self textField] setClearButtonMode:UITextFieldViewModeWhileEditing];
//        [[self textField] setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
//        [[self textField] setAutocapitalizationType:UITextAutocapitalizationTypeNone];
//        [[self textField] setReturnKeyType:UIReturnKeyDone];
//        [[self textField] setAutoresizingMask:(UIViewAutoresizingFlexibleLeftMargin |
//                                                UIViewAutoresizingFlexibleRightMargin |
//                                                UIViewAutoresizingFlexibleTopMargin |
//                                                UIViewAutoresizingFlexibleBottomMargin |
//                                                UIViewAutoresizingFlexibleWidth	|
//                                                UIViewAutoresizingFlexibleHeight)];
//        [[self textField] setDelegate:self];
//        [self setResponder:[self textField]];
//        [[self contentView] addSubview:[self textField]];
        
        
        // セル選択
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        
//        // ツールバー(配置)
//        [[self textField] setInputAccessoryView:[self toolbar]];
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
