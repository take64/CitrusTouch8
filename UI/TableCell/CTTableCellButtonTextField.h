//
//  CTTableCellButtonTextField.h
//  CitrusTouch
//
//  Created by TAKEMOTO KOUHEI on 2012/11/27.
//  Copyright (c) 2012年 citrus.tk. All rights reserved.
//

#import "CTTableCell.h"

@class CTTableCellTextFieldInnerTextField;

@interface CTTableCellButtonTextField : CTTableCell <UITextFieldDelegate>
{
    // ボタン
    CTButton *removeButton;
    CTButton *selectButton;
    
    // テキストフィールド
    CTTableCellTextFieldInnerTextField *textField;
}

//
// property
//
@property (nonatomic, retain) CTButton *removeButton;
@property (nonatomic, retain) CTButton *selectButton;
@property (nonatomic, retain) CTTableCellTextFieldInnerTextField *textField;



//
// method
//

// 初期化
- (id) initWithPrefix:(NSString *)prefixString content:(NSString *)textString suffix:(NSString *)suffixString reuseIdentifier:(NSString *)reuseIdentifier;

// テキスト取得
- (NSString *) contentText;
// テキスト設定
- (void) setContentText:(NSString *)stringValue;

@end
