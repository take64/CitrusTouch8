//
//  CTChartList.m
//  CitrusTouch
//
//  Created by take64 on 2016/02/06.
//  Copyright © 2016年 citrus.tk. All rights reserved.
//

#import "CTChartList.h"

@implementation CTChartList

//
// synthesize
//
@synthesize title;
@synthesize dataList;
@synthesize minValue;
@synthesize maxValue;
@synthesize color;

// 初期化
- (id)initWithTitle:(NSString *)titleString values:(NSArray<CTChartData *> *)dataValue
{
    self = [super init];
    if(self)
    {
        [self setTitle:titleString];
        [self setDataList:dataValue];
    }
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"title = %@; data = %@",
            [self title] ,
            [self dataList]
            ];
}

@end
