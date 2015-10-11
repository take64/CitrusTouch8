//
//  CTTableCellLabel.h
//  CitrusTouch
//
//  Created by TAKEMOTO KOUHEI on 2012/11/27.
//  Copyright (c) 2012年 citrus.tk. All rights reserved.
//

#import "CTTableCell.h"

@interface CTTableCellLabel : CTTableCell
{
    // ラベル
    CTLabel *label;
}

//
// property
//
@property (nonatomic, retain) CTLabel *label;


//
// method
//

// 初期化
- (id) initWithPrefix:(NSString *)prefixString content:(NSString *)textString suffix:(NSString *)suffixString reuseIdentifier:(NSString *)reuseIdentifier;

// 初期化
- (id) initWithPrefix:(NSString *)prefixString reuseIdentifier:(NSString *)reuseIdentifier;

// テキスト取得
- (NSString *) contentText;
// テキスト設定
- (void) setContentText:(NSString *)stringValue;
// 文字寄せ
- (void)setTextAlignment:(NSTextAlignment)textAlignment;

@end
