//
//  CTChartData.m
//  CitrusTouch
//
//  Created by take64 on 2016/01/31.
//  Copyright © 2016年 citrus.tk. All rights reserved.
//

#import "CTChartData.h"

@implementation CTChartData

//
// synthesize
//
@synthesize title;
@synthesize value;
@synthesize color;


// 初期化
- (id)initWithTitle:(NSString *)titleString value:(NSNumber *)valueNumber
{
    self = [self initWithTitle:titleString value:valueNumber color:nil];
    if(self)
    {
        
    }
    return self;
}
// 初期化
- (id)initWithTitle:(NSString *)titleString value:(NSNumber *)valueNumber color:(CTColor *)colorValue
{
    self = [super init];
    if(self)
    {
        [self setTitle:titleString];
        [self setValue:valueNumber];
        [self setColor:colorValue];
        
    }
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"title = %@; value = %@; color = %@",
            [self title],
            [self value],
            [self color]
            ];
}

@end
