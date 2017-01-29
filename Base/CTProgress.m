//
//  CTProgress.m
//  ChinottoPod
//
//  Created by kouhei.takemoto on 2016/11/15.
//  Copyright © 2016年 citrus.live. All rights reserved.
//

#import "CTProgress.h"

@implementation CTProgress

//
// synthesize
//
@synthesize processing;
@synthesize total;
@synthesize progress;
//@synthesize resultData;

// 初期化(途中)
- (id)initWithProgressing:(NSNumber *)progressingNumber total:(NSNumber *)totalNumber;
{
    self = [super init];
    if(self)
    {
        [self setProcessing:progressingNumber];
        [self setTotal:totalNumber];
        [self setProgress:@([progressingNumber doubleValue] / [totalNumber doubleValue])];
//        [self setResultData:nil];
    }
    return self;
}

//// 初期化(完了)
//- (id)initWithResultData:(NSData *)datadile
//{
//    self = [super init];
//    if(self)
//    {
//        [self setProgress:@(1)];
//        [self setResultData:datadile];
//    }
//    return self;
//}

// 初期化(完了)
- (id)initWithComplete
{
    self = [self initWithProgressing:@1 total:@1];
    if(self)
    {
//        [self setResultData:nil];
    }
    return self;
}


// 初期化(途中)
+ (instancetype)progressing:(NSNumber *)progressingValue total:(NSNumber *)totalValue
{
    return [[CTProgress alloc] initWithProgressing:progressingValue total:totalValue];
}

// 初期化(完了)
+ (instancetype)complete
{
    return [[CTProgress alloc] initWithComplete];
}

@end
