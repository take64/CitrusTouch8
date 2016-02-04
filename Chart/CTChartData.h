//
//  CTChartData.h
//  AccountBookPod2
//
//  Created by TAKEMOTO KOUHEI on 2016/01/31.
//  Copyright © 2016年 citrus.tk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTChartData : NSObject
{
    // タイトル
    NSString *title;
    
    // 値
    NSNumber *zValue;
    
    // 色
    CTColor *color;
}

//
// property
//
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSNumber *zValue;
@property (nonatomic, retain) CTColor *color;


// 初期化(PIEチャート用)
- (id)initPieDataWithTitle:(NSString *)titleString value:(NSNumber *)valueNumber;
// 初期化(PIEチャート用)
- (id)initPieDataWithTitle:(NSString *)titleString value:(NSNumber *)valueNumber color:(CTColor *)colorValue;

@end
