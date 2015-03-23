//
//  CTTableCellSegmentedControl.h
//  ProtoRegi02
//
//  Created by TAKEMOTO KOUHEI on 11/12/21.
//  Copyright (c) 2011 citrus.tk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CTTableCellSegmentedControl : UITableViewCell
{
    // 選択データ
    NSDictionary *_data;
    
    // セグメントコントロール
    UISegmentedControl *_segmentedControl;
    
    // レイアウト済みか否か(YES:済, NO:未)
    BOOL _isLayout;
}

//
// property
//
@property (nonatomic, retain) NSDictionary *_data;
@property (nonatomic, retain) UISegmentedControl *_segmentedControl;
@property (nonatomic) BOOL _isLayout;



//
// method
//

// 初期化
- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier;

// データ当て込み
- (void) bindData:(NSDictionary *)data;

// 選択中のキーを取得
- (id) selectedKey;

// 選択設定
- (void) setSelectedSegmentIndex:(NSInteger)index;

// 選択設定
- (void) setSelectedKey:(id)key;

// ターゲット
- (void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;

@end
