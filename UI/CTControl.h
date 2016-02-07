//
//  CTControl.h
//  CitrusTouch
//
//  Created by take64 on 2012/09/30.
//  Copyright (c) 2012年 citrus.tk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>


// ステータス
typedef enum {
    CTControlStateNormal,      // 標準
    CTControlStateHighlighted, // ハイライト
    CTControlStateDisabled,    // disable
} CTControlState;

@class CTStyle;

@interface CTControl : UIControl
{
    // スタイルシート
    CTStyle *ctstyleNormal;
    CTStyle *ctstyleHighlighted;
    CTStyle *ctstyleDisabled;
    
    // 文字列
    NSString *_textString;
    
    // ステート
    CTControlState _state;
    
    // 連携情報
    NSMutableDictionary *userInfo;
}

//
// property
//
@property (nonatomic, retain) CTStyle *ctstyleNormal;
@property (nonatomic, retain) CTStyle *ctstyleHighlighted;
@property (nonatomic, retain) CTStyle *ctstyleDisabled;
@property (nonatomic, retain, getter=text, setter=setText:) NSString *_textString;
@property (nonatomic) CTControlState _state;
@property (nonatomic, retain) NSMutableDictionary *userInfo;

//
// method
//

// 初期化
- (id) initWithText:(NSString *)textString;

//// 初期化
//- (id) initWithStyle:(CTStyle *)styleValue;

// スタイル取得
- (CTStyle *) callStyle;
- (CTStyle *) callStyleNormal;
- (CTStyle *) callStyleHighlighted;
- (CTStyle *) callStyleDisabled;
// スタイル設定
- (void) setStyle:(CTStyle *)styleValue;
- (void) setStyleNormal:(CTStyle *)styleValue;
- (void) setStyleHighlighted:(CTStyle *)styleValue;
- (void) setStyleDisabled:(CTStyle *)styleValue;




@end
