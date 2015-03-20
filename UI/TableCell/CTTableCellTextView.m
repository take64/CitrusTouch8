//
//  CTTableCellTextView.m
//  CitrusTouch
//
//  Created by TAKEMOTO KOUHEI on 2012/11/27.
//  Copyright (c) 2012年 citrus.tk. All rights reserved.
//

#import "CTTableCellTextView.h"

@implementation CTTableCellTextView

//
// synthesize
//
@synthesize textView;
@synthesize _didEndEditingTarget;
@synthesize _didEndEditingSelector;


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 未レイアウトの場合
    if([self isSubLayout] == NO)
    {
        [[self textView] setFrame:[self contentFrame]];
        
        
        // レイアウト済み
        [self setSubLayout:YES];
    }
}




#pragma mark -
#pragma mark UITextViewDelegate
//
// UITextViewDelegate
//

// 編集開始前
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    [self activate];
    return YES;
}
//- (BOOL)textViewShouldEndEditing:(UITextView *)textView;
//- (void)textViewDidBeginEditing:(UITextView *)textView;
// 編集終了後
- (void)textViewDidEndEditing:(UITextView *)textView
{
    [self deactivate];
    
    // 編集後処理が登録されていて、呼べれば呼ぶ
    if([[self _didEndEditingTarget] respondsToSelector:[self _didEndEditingSelector]] == YES)
    {
        [[self _didEndEditingTarget] performSelector:[self _didEndEditingSelector]];
    }
    
}
//- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text;
//- (void)textViewDidChange:(UITextView *)textView;
//- (void)textViewDidChangeSelection:(UITextView *)textView;




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
        [self setTextView:[[CTTextView alloc] initWithFrame:CGRectZero]];
        [[self textView] setFont:[UIFont systemFontOfSize:16.0]];
        [[self textView] setAutocapitalizationType:UITextAutocapitalizationTypeNone];
        [[self textView] setReturnKeyType:UIReturnKeyDone];
        [[self textView] setAutoresizingMask:(UIViewAutoresizingFlexibleLeftMargin |
                                              UIViewAutoresizingFlexibleRightMargin |
                                              UIViewAutoresizingFlexibleTopMargin |
                                              UIViewAutoresizingFlexibleBottomMargin |
                                              UIViewAutoresizingFlexibleWidth	|
                                              UIViewAutoresizingFlexibleHeight)];
        [[self textView] setDelegate:self];
        [self setResponder:[self textView]];
        [[self contentView] addSubview:[self textView]];
        
        [[self textView] setBackgroundColor:[UIColor clearColor]];
        
        
        // セル選択
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        // ツールバー(配置)
        [[self textView] setInputAccessoryView:[self toolbar]];
    }
    return self;
}

// 初期化
- (id) initWithPrefix:(NSString *)prefixString content:(NSString *)textString suffix:(NSString *)suffixString reuseIdentifier:(NSString *)reuseIdentifier
{
    
    self = [self initWithPrefix:prefixString suffix:suffixString reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [[self textView] setText:textString];
    }
    return self;
}

// テキスト取得
- (NSString *) contentText
{
    return [[self textView] text];
}
// テキスト設定
- (void) setContentText:(NSString *)stringValue
{
    [[self textView] setText:stringValue];
}

// テキスト編集完了時
- (void) setDidEndEditingTarget:(id)target selector:(SEL)selector
{
    [self set_didEndEditingTarget:target];
    [self set_didEndEditingSelector:selector];
}

@end
