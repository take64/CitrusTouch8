//
//  CTSheetDatePicker.h
//  CitrusTouch
//
//  Created by TAKEMOTO KOUHEI on 2012/11/27.
//  Copyright (c) 2012年 citrus.tk. All rights reserved.
//

#import "CTSheetView.h"

@interface CTSheetDatePicker : CTSheetView
{
    // ピッカー
    UIDatePicker *_datePicker;
    
    // 処理用ツールバー
    UIToolbar *_toolbar;
    
    // 処理用ツールバー内前後ボタン
    UISegmentedControl *_segmentedPrevNext;
    
    // 処理用ツールバー内前後ボタンポインター
    UIResponder *_responderPrev;
    UIResponder *_responderNext;
}

//
// property
//
@property (nonatomic, retain) UIDatePicker *_datePicker;
@property (nonatomic, retain) UIToolbar *_toolbar;
@property (nonatomic, retain) UISegmentedControl *_segmentedPrevNext;
@property (nonatomic, retain) UIResponder *_responderPrev;
@property (nonatomic, retain) UIResponder *_responderNext;

@end
