//
//  CTSheetView.h
//  CitrusTouch
//
//  Created by take64 on 2012/11/27.
//  Copyright (c) 2012年 citrus.tk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CTSheetView : UIView



//
// method
//

// 表示
- (void) show;

// 非表示
- (void) hide;

// 値変更時(前後ボタン)
- (void) onChangeSegmentedPrevNext:(UISegmentedControl *)segmentedControl;

// レスポンダ設定(前へ)
- (void) setResponderPrev:(id)cellTextField;

// レスポンダ設定(次へ)
- (void) setResponderNext:(id)cellTextField;

// リフレッシュ(前後ボタン)
- (void) refreshSegmentedPrevNext;

@end
