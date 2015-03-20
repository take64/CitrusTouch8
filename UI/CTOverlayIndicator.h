//
//  CTOverlayIndicator.h
//  CitrusTouch
//
//  Created by TAKEMOTO KOUHEI on 2013/02/01.
//  Copyright (c) 2013年 citrus.tk. All rights reserved.
//

#import "CTControl.h"

@class CTLabel;

@interface CTOverlayIndicator : CTControl
{
    // アクティビティインジケーター
    UIActivityIndicatorView *activityIndicator;
    
    // タイトル
    CTLabel *titleLabel;
    
    // タイトル
    CTLabel *messageLabel;
    
    // 親ビュー
    UIView *_parentView;
}

//
// property
//
@property (nonatomic, retain) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, retain) CTLabel *titleLabel;
@property (nonatomic, retain) CTLabel *messageLabel;
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

@end
