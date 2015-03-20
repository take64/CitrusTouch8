//
//  CTNumber.m
//  CitrusTouch
//
//  Created by TAKEMOTO KOUHEI on 2013/01/27.
//  Copyright (c) 2013年 citrus.tk. All rights reserved.
//

#import "CTNumber.h"

@implementation CTNumber

// NSString からの変換
+ (NSNumber *) numberWithString:(NSString *)stringValue
{
    int number = [stringValue intValue];
    return [NSNumber numberWithInt:number];
}
@end
