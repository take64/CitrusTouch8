//
//  CTTableCellDatePicker.h
//  CitrusTouch
//
//  Created by TAKEMOTO KOUHEI on 2012/11/28.
//  Copyright (c) 2012年 citrus.tk. All rights reserved.
//


#import "CTTableCellTextField.h"

typedef NS_ENUM(NSInteger, CTTableCellDatePickerMode) {
    CTTableCellDatePickerModeNone,
    CTTableCellDatePickerModeStandard
};

@interface CTTableCellDatePicker : CTTableCellTextField
{
    // ピッカー
    UIDatePicker *datePicker;
    
    // フォーマット
    NSDateFormatter *dateFormatter;
    
    // ピッカーモード
    CTTableCellDatePickerMode _pickerMode;
    
    // パッキングビュー
    UIView *inputPackingView;
}

//
// property
//
@property (nonatomic, retain) UIDatePicker *datePicker;
@property (nonatomic, retain) NSDateFormatter *dateFormatter;
@property (nonatomic) CTTableCellDatePickerMode _pickerMode;
@property (nonatomic, retain) UIView *inputPackingView;


//
// method
//

// 初期化
- (id) initWithPrefix:(NSString *)prefixString content:(NSDate *)dateValue suffix:(NSString *)suffixString reuseIdentifier:(NSString *)reuseIdentifier;

// 設定(ピッカーモード)
- (void) setPickerMode:(CTTableCellDatePickerMode)pickerModeValue;

// 取得(日付)
- (NSDate *) date;
// 設定(日付)
- (void) setDate:(NSDate *)dateValue;


@end
