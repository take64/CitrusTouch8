//
//  CTOverlayProgressIndicator.h
//  CitrusTouch
//
//  Created by take64 on 2013/02/01.
//  Copyright (c) 2013年 citrus.tk. All rights reserved.
//

#import "CTControl.h"

@class CTLabel;

@interface CTOverlayProgressIndicator : CTControl
{
    // アクティビティインジケーター
    UIActivityIndicatorView *activityIndicator;
    
    // プログレスバー
    UIProgressView *progressBar;
    
    // タイトル
    CTLabel *titleLabel;
    
    // タイトル
    CTLabel *messageLabel;
    
    // 進捗％
    CTLabel *percentageLabel;
    
    // 分母値
    NSNumber *denominator;
    
    // 分子値
    NSNumber *numerator;
    
    // 親ビュー
    UIView *_parentView;
}

//
// property
//
@property (nonatomic, retain) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, retain) UIProgressView *progressBar;
@property (nonatomic, retain) CTLabel *titleLabel;
@property (nonatomic, retain) CTLabel *messageLabel;
@property (nonatomic, retain) CTLabel *percentageLabel;
@property (nonatomic, retain) NSNumber *denominator;
@property (nonatomic, retain) NSNumber *numerator;
@property (nonatomic, retain) UIView *_parentView;


//
// method
//

// 初期化
- (id) initWithParentView:(UIView *)parentView;


// 表示
- (void) show;

// 非表示
- (void) hide;

// タイトル
- (void) setTitle:(NSString *) stringValue;

// メッセージ
- (void) setMessage:(NSString *) stringValue;

// パーセンテージ
- (void) setPercentage:(NSString *) stringValue;

// 分子更新
- (void) updateNumerator:(NSNumber *)numberValue;

// 分母更新
- (void) updateDenominator:(NSNumber *)numberValue;

// 分子等更新
- (void) updateWithInfo:(NSDictionary *)infoValue;

@end
