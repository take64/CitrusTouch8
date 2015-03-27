//
//  CTTableCellSlider.h
//  CitrusTouch
//
//  Created by TAKEMOTO KOUHEI on 2012/11/27.
//  Copyright (c) 2012年 citrus.tk. All rights reserved.
//

#import "CTTableCell.h"

@interface CTTableCellSlider : CTTableCell
{
    // ボタン
    UISlider *slider;
}

//
// property
//
@property (nonatomic, retain) UISlider *slider;



//
// method
//

// 初期化
- (id) initWithPrefix:(NSString *)prefixString content:(NSString *)textString suffix:(NSString *)suffixString reuseIdentifier:(NSString *)reuseIdentifier;

// 値取得
- (float) value;
// 値設定
- (void) setValue:(float)floatValue;

// 値取得
- (float) minimumValue;
// 値設定
- (void) setMinimumValue:(float)floatValue;

// 値取得
- (float) maximumValue;
// 値設定
- (void) setMaximumValue:(float)floatValue;
@end
