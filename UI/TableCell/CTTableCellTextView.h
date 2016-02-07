//
//  CTTableCellTextView.h
//  CitrusTouch
//
//  Created by take64 on 2012/11/27.
//  Copyright (c) 2012年 citrus.tk. All rights reserved.
//

#import "CTTableCell.h"

@interface CTTableCellTextView : CTTableCell <UITextViewDelegate>
{
    // テキストビュー
    CTTextView *textView;
    
    // Did End Editing
    id _didEndEditingTarget;
    SEL _didEndEditingSelector;
}

//
// property
//
@property (nonatomic, retain) CTTextView *textView;
@property (nonatomic) id _didEndEditingTarget;
@property (nonatomic) SEL _didEndEditingSelector;



//
// method
//

// 初期化
- (id) initWithPrefix:(NSString *)prefixString content:(NSString *)textString suffix:(NSString *)suffixString reuseIdentifier:(NSString *)reuseIdentifier;

// テキスト取得
- (NSString *) contentText;
// テキスト設定
- (void) setContentText:(NSString *)stringValue;

// テキスト編集完了時
- (void) setDidEndEditingTarget:(id)target selector:(SEL)selector;

@end
