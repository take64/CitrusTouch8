//
//  CTTableCellSwitch.h
//  CitrusTouch
//
//  Created by TAKEMOTO KOUHEI on 2012/11/27.
//  Copyright (c) 2012年 citrus.tk. All rights reserved.
//

#import "CTTableCell.h"

@interface CTTableCellSwitch : CTTableCell
{
    // ボタン
    UISwitch *_switch;
}

//
// property
//
@property (nonatomic, retain) UISwitch *_switch;



//
// method
//

// 初期化
- (id) initWithPrefix:(NSString *)prefixString content:(BOOL)boolValue reuseIdentifier:(NSString *)reuseIdentifier;

// 値取得
- (BOOL) onBool;
// 値設定
- (void) setOn:(BOOL)boolValue;

// イベント設定
- (void) addTarget:(id)idValue action:(SEL)selValue forControlEvents:(UIControlEvents)controlEventsValue;

@end
