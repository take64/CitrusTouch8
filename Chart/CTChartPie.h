//
//  CTChartPie.h
//  AccountBookPod2
//
//  Created by TAKEMOTO KOUHEI on 2016/01/31.
//  Copyright © 2016年 citrus.tk. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CTChartData;

@interface CTChartPie : UIView
{
    // データリスト
    NSArray<CTChartData *> *dataList;
}

//
// property
//
@property (nonatomic, retain) NSArray<CTChartData *> *dataList;

//
// method
//

// 初期化
- (id)initWithFrame:(CGRect)frame data:(NSArray<CTChartData *> *)dataValue;

// データ読み込み
- (void)loadData:(NSArray<CTChartData *> *)dataValue;

@end
