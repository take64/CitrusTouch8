//
//  CTTableCellSegmentedControl.h
//  ProtoRegi02
//
//  Created by take64 on 11/12/21.
//  Copyright (c) 2011 citrus.tk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CTTableCellSegmentedControl : CTTableCell
{
    // 選択データ
    NSArray *_keys;
    NSArray *_vals;
    
    // セグメントコントロール
    UISegmentedControl *_segmentedControl;
    
    // レイアウト済みか否か(YES:済, NO:未)
    BOOL _isLayout;
}

//
// property
//
@property (nonatomic, retain) NSArray *_keys;
@property (nonatomic, retain) NSArray *_vals;
@property (nonatomic, retain) UISegmentedControl *_segmentedControl;
@property (nonatomic) BOOL _isLayout;



//
// method
//

// データ当て込み
- (void) bindDataKeys:(NSArray *)keys vals:(NSArray *)vals;

// データ当て込み
- (void) bindData:(NSArray *)datas;

// 選択中のキーを取得
- (id) selectedKey;

// 選択中の値を取得
- (id) selectedValue;

// 選択設定
- (void) setSelectedSegmentIndex:(NSInteger)index;

// 選択設定
- (void) setSelectedKey:(id)key;

// イベント設定
- (void)addTarget:(id)idValue action:(SEL)selValue forControlEvents:(UIControlEvents)controlEventsValue;

@end
