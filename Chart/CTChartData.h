//
//  CTChartData.h
//  CitrusTouch
//
//  Created by take64 on 2016/01/31.
//  Copyright © 2016年 citrus.tk. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CTColor.h"

@interface CTChartData : NSObject
{
    // タイトル
    NSString *title;
    
    // 値
    NSNumber *value;
    
    // 色
    CTColor *color;
}

//
// property
//
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSNumber *value;
@property (nonatomic, retain) CTColor *color;


// 初期化
- (id)initWithTitle:(NSString *)titleString value:(NSNumber *)valueNumber;
// 初期化
- (id)initWithTitle:(NSString *)titleString value:(NSNumber *)valueNumber color:(CTColor *)colorValue;

@end
