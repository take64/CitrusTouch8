//
//  CTTableCellButtonNumberPad.h
//  CitrusTouch
//
//  Created by take64 on 2012/11/27.
//  Copyright (c) 2012年 citrus.tk. All rights reserved.
//

#import "CTTableCell.h"

@class CTTableCellTextFieldInnerTextField;

@interface CTTableCellButtonNumberPad : CTTableCellNumberPad <UITextFieldDelegate>
{
    // ボタン
    CTButton *removeButton;
    CTButton *selectButton;
}

//
// property
//
@property (nonatomic, retain) CTButton *removeButton;
@property (nonatomic, retain) CTButton *selectButton;



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
