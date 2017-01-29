//
//  CTChartLine.h
//  CitrusTouch
//
//  Created by take64 on 2013/02/28.
//  Copyright (c) 2013年 citrus.tk. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "CitrusTouchUIStruct.h"

@class CTChartList;

@interface CTChartLine : UIView
{
    // データリスト
    NSArray<CTChartList *> *dataList;
    
    // 項目フォーマット
    NSNumberFormatter *ruledTitleFormat;
    
    // min & max の初期値
    NSNumber *yMinInit;
    NSNumber *yMaxInit;
    
    
//    // X軸タイトルリスト
//    NSArray *xAxisTitles;
//    
//    // X軸エリア
//    CGRect xAxisFrame;
//    
//    // X軸インターバル
//    CGFloat xAxisMainInterval;
//    CGFloat xAxisSubInterval;
//    
//    // X軸目盛り長さ
//    CGFloat xAxisMainLineLength;
//    CGFloat xAxisSubLineLength;
//    
//    // 目盛り領域幅
//    CGFloat yAxesLeftWidth;
//    CGFloat yAxesRightWidth;
//    CGFloat xAxisBottomWidth;
//    
//    
//    // Y軸データリスト
//    NSArray *yAxesLeftLists;    // 左
//    NSArray *yAxesRightLists;   // 右
//    
//    // Y軸エリア
//    CGRect yAxesLeftFrame;
//    CGRect yAxesRightFrame;
//    
//    // Y軸インターバル
//    CGFloat yAxesLeftMainInterval;
//    CGFloat yAxesLeftSubInterval;
//    CGFloat yAxesRightMainInterval;
//    CGFloat yAxesRightSubInterval;
//    
//    // Y軸目盛り長さ
//    CGFloat yAxesLeftMainLineLength;
//    CGFloat yAxesLeftSubLineLength;
//    CGFloat yAxesRightMainLineLength;
//    CGFloat yAxesRightSubLineLength;
//    
//    // Y軸ラインカラーリスト
//    NSArray *yAxesLeftLineStrokeColors;
//    NSArray *yAxesLeftLineFillColors;
//    NSArray *yAxesRightLineStrokeColors;
//    NSArray *yAxesRightLineFillColors;
//    
//    // Y軸レンジ
//    NSRange yAxesLeftRange;
//    
//    // グリッドカラー
//    CTColor *gridColor;
//    
//    // グラフエリア
//    CGRect chartFrame;
//    
//    // padding
//    CTPadding chartAreaPadding;
    
}

//
// property
//
@property (nonatomic, retain) NSArray<CTChartList *> *dataList;
@property (nonatomic, retain) NSNumberFormatter *ruledTitleFormat;
@property (nonatomic, retain) NSNumber *yMinInit;
@property (nonatomic, retain) NSNumber *yMaxInit;

//@property (nonatomic, retain) NSArray *xAxisTitles;
//@property (nonatomic, assign) CGRect xAxisFrame;
//@property (nonatomic, assign) CGFloat xAxisMainInterval;
//@property (nonatomic, assign) CGFloat xAxisSubInterval;
//@property (nonatomic, assign) CGFloat xAxisMainLineLength;
//@property (nonatomic, assign) CGFloat xAxisSubLineLength;
//
//@property (nonatomic, assign) CGFloat yAxesLeftWidth;
//@property (nonatomic, assign) CGFloat yAxesRightWidth;
//@property (nonatomic, assign) CGFloat xAxisBottomWidth;
//
//@property (nonatomic, retain) NSArray *yAxesLeftLists;
//@property (nonatomic, retain) NSArray *yAxesRightLists;
//
//@property (nonatomic, assign) CGRect yAxesLeftFrame;
//@property (nonatomic, assign) CGRect yAxesRightFrame;
//@property (nonatomic, assign) CGFloat yAxesLeftMainInterval;
//@property (nonatomic, assign) CGFloat yAxesLeftSubInterval;
//@property (nonatomic, assign) CGFloat yAxesRightMainInterval;
//@property (nonatomic, assign) CGFloat yAxesRightSubInterval;
//@property (nonatomic, assign) CGFloat yAxesLeftMainLineLength;
//@property (nonatomic, assign) CGFloat yAxesLeftSubLineLength;
//@property (nonatomic, assign) CGFloat yAxesRightMainLineLength;
//@property (nonatomic, assign) CGFloat yAxesRightSubLineLength;
//
//@property (nonatomic, retain) NSArray *yAxesLeftLineStrokeColors;
//@property (nonatomic, retain) NSArray *yAxesLeftLineFillColors;
//@property (nonatomic, retain) NSArray *yAxesRightLineStrokeColors;
//@property (nonatomic, retain) NSArray *yAxesRightLineFillColors;
//
//@property (nonatomic, assign) NSRange yAxesLeftRange;
//@property (nonatomic, assign) NSRange yAxesRightRange;
//
//@property (nonatomic, retain) CTColor *gridColor;
//
//@property (nonatomic, assign) CGRect chartFrame;
//@property (nonatomic, assign) CTPadding chartAreaPadding;

//
// method
//

// 初期化
- (id)initWithFrame:(CGRect)frame data:(NSArray<CTChartList *> *)dataValue;

// データ読み込み
- (void)loadData:(NSArray<CTChartList *> *)dataValue;

@end
