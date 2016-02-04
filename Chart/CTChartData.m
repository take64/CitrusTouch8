//
//  CTChartData.m
//  AccountBookPod2
//
//  Created by TAKEMOTO KOUHEI on 2016/01/31.
//  Copyright © 2016年 citrus.tk. All rights reserved.
//

#import "CTChartData.h"

@implementation CTChartData

//
// synthesize
//
@synthesize title;
@synthesize zValue;
@synthesize color;


// 初期化(PIEチャート用)
- (id)initPieDataWithTitle:(NSString *)titleString value:(NSNumber *)valueNumber
{
    self = [self initPieDataWithTitle:titleString value:valueNumber color:nil];
    if(self)
    {
        
    }
    return self;
}
// 初期化(PIEチャート用)
- (id)initPieDataWithTitle:(NSString *)titleString value:(NSNumber *)valueNumber color:(CTColor *)colorValue
{
    self = [super init];
    if(self)
    {
        [self setTitle:titleString];
        [self setZValue:valueNumber];
        [self setColor:colorValue];
        
    }
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"title = %@; zValue = %@; color = %@",
            [self title],
            [self zValue],
            [self color]
            ];
}

@end
