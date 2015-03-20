//
//  CTTableCell.h
//  CitrusTouch
//
//  Created by TAKEMOTO KOUHEI on 2012/11/27.
//  Copyright (c) 2012年 citrus.tk. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    CTTableCellPartPriorityHidden,
    CTTableCellPartPriorityHigh,
    CTTableCellPartPriorityMiddle,
    CTTableCellPartPriorityLow
} CTTableCellPartPriority;

@class CTColor;
@class CTLabel;
@class CTControl;

@interface CTTableCell : UITableViewCell
{
    // ActiveColor
    CTColor *activateColor;
    // deActiveColor
    CTColor *deactivateColor;
    
    // プレフィックスラベル
    CTLabel *prefixLabel;
    // サフィックスラベル
    CTLabel *suffixLabel;
    
    // コンテンツ用表示領域
    CGFloat prefixWidth;
    CGFloat suffixWidth;
    CGRect contentFrame;
    
    // レイアウト済み
    BOOL layout;
    // サブクラスレイアウト済み
    BOOL subLayout;
    
    // レスポンダー
    UIResponder *responder;
    CTTableCell *prevCell;
    CTTableCell *nextCell;
    
    // セル
    NSIndexPath *prevIndexPath;
    NSIndexPath *nextIndexPath;

    
    // 処理用ツールバー
    UIToolbar *toolbar;

    // 処理用ツールバー内前後ボタン
    UISegmentedControl *segmentedPrevNext;
    
    // 優先度
    CTTableCellPartPriority prefixPriority;
    CTTableCellPartPriority contentPriority;
    CTTableCellPartPriority suffixPriority;
    
    // 背景View
    CTControl *bgView;
}

//
// property
//
@property (nonatomic, retain) CTColor *activateColor;
@property (nonatomic, retain) CTColor *deactivateColor;
@property (nonatomic, retain) CTLabel *prefixLabel;
@property (nonatomic, retain) CTLabel *suffixLabel;
@property (nonatomic, assign) CGFloat prefixWidth;
@property (nonatomic, assign) CGFloat suffixWidth;
@property (nonatomic, assign) CGRect contentFrame;
@property (nonatomic, getter = isLayout) BOOL layout;
@property (nonatomic, getter = isSubLayout) BOOL subLayout;
@property (nonatomic, retain) UIResponder *responder;
@property (nonatomic, retain) CTTableCell *prevCell;
@property (nonatomic, retain) CTTableCell *nextCell;
@property (nonatomic, retain) NSIndexPath *prevIndexPath;
@property (nonatomic, retain) NSIndexPath *nextIndexPath;
@property (nonatomic, retain) UIToolbar *toolbar;
@property (nonatomic, retain) UISegmentedControl *segmentedPrevNext;
@property (nonatomic, assign) CTTableCellPartPriority prefixPriority;
@property (nonatomic, assign) CTTableCellPartPriority contentPriority;
@property (nonatomic, assign) CTTableCellPartPriority suffixPriority;
@property (nonatomic, retain) CTControl *bgView;

//
// method
//

// 初期化
- (id) initWithPrefix:(NSString *)prefixString suffix:(NSString *)suffixString reuseIdentifier:(NSString *)reuseIdentifier;

// アクティブ
- (void) activate;

// デアクティブ
- (void) deactivate;


// ボタン押下時(キーボードDONE)
- (void) onTapBarButtonDone;

// 値変更時(前後ボタン)
- (void) onChangeSegmentedPrevNext:(UISegmentedControl *)segmentedControl;

// リフレッシュ(前後ボタン)
- (void) refreshSegmentedPrevNext;

// レスポンダ設定(前へ)
- (void) setPrevCellResponder:(CTTableCell *)tableCell;

// レスポンダ設定(次へ)
- (void) setNextCellResponder:(CTTableCell *)tableCell;

// レスポンダ設定(前へ)
- (void) setPrevCellResponder:(CTTableCell *)tableCell indexPath:(NSIndexPath *)indexPath;

// レスポンダ設定(次へ)
- (void) setNextCellResponder:(CTTableCell *)tableCell indexPath:(NSIndexPath *)indexPath;

// 優先度設定
- (void) setPriorityPrefix:(CTTableCellPartPriority)prefix content:(CTTableCellPartPriority)content suffix:(CTTableCellPartPriority)suffix;

// アクティブ色
- (CTColor *) activateColor;

// デアクティブ色
- (CTColor *) deactivateColor;

@end
