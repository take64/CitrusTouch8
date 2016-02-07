//
//  CKStyle.h
//  CitrusTouch
//
//  Created by take64 on 2012/09/30.
//  Copyright (c) 2012年 citrus.tk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTStyle : NSObject <NSCopying>
{
    // スタイル
    NSMutableDictionary *_styles;
}

//
// property
//
@property (nonatomic, retain) NSMutableDictionary *_styles;



//
// method
//

// 初期化
- (id) initWithStyleDictionary:(NSDictionary *)dictionaryValue;

// 追加
- (void) addStyleKey:(NSString *)keyValue value:(NSString *)dataValue;

// 追加
- (void) addStyleDictionary:(NSDictionary *)dictionaryValue;

// 削除
- (void) removeStyleKey:(NSString *)keyValue;

// 取得
- (NSString *) callStyleKey:(NSString *)keyValue;

// 設定
- (void) setStyleKey:(NSString *)keyValue value:(NSString *)dataValue;

// 設定
- (void) setStyleDictionary:(NSDictionary *)dictionaryValue;

// 全取得
- (NSMutableDictionary *) callAllStyles;

// フォント取得
- (UIFont *) callFont;

// サイズ取得
- (CGSize) callSize;

// ポイント取得
- (CGPoint) callPoint;

// フレーム取得
- (CGRect) callFrame;

// マージン取得(右)
- (CGFloat) callMarginRight;
// マージン取得(下)
- (CGFloat) callMarginBottom;

// ボーダー幅取得
- (CGFloat) callBorderWidth;

@end
