//
//  CTTableCellNumberPicker.h
//  CitrusTouch
//
//  Created by take64 on 2016/02/07.
//  Copyright © 2016年 citrus.tk. All rights reserved.
//

#import "CTTableCellTextField.h"

@interface CTTableCellNumberPicker : CTTableCellTextField <UIPickerViewDataSource, UIPickerViewDelegate>
{
    // ピッカー
    UIPickerView *numberPicker;
    
    // データリスト
    NSArray *dataList;
    
    // フォーマット
    NSString *displayFormat;
    
    // パッキングビュー
    UIView *inputPackingView;
}

//
// property
//
@property (nonatomic, retain) UIPickerView *numberPicker;
@property (nonatomic, retain) NSArray *dataList;
@property (nonatomic, retain) NSString *displayFormat;
@property (nonatomic, retain) UIView *inputPackingView;


//
// method
//

// 初期化
- (id) initWithPrefix:(NSString *)prefixString suffix:(NSString *)suffixString reuseIdentifier:(NSString *)reuseIdentifier;
// 初期化
- (id) initWithPrefix:(NSString *)prefixString content:(NSNumber *)numberValue data:(NSArray *)dataValue format:(NSString *)format suffix:(NSString *)suffixString reuseIdentifier:(NSString *)reuseIdentifier;

// 値設定
- (void)setNumber:(NSNumber *)numberValue;
// 値取得
- (NSNumber *)number;

@end
