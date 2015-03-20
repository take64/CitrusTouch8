//
//  CTEmptyVL.m
//  CitrusTouch
//
//  Created by TAKEMOTO KOUHEI on 2012/11/03.
//  Copyright (c) 2012年 citrus.tk. All rights reserved.
//

#import "CTEmptyVL.h"

@implementation CTEmptyVL

// NVL関数
+ (id) compare:(id)compare replace:(id)replace
{
    BOOL isEmpty = NO;
    
    if(compare == nil)
    {
        isEmpty = YES;
    }
    // NSString
    else if([compare isKindOfClass:[NSString class]] == YES)
    {
        if([(NSString *)compare isEqualToString:@""] == YES)
        {
            isEmpty = YES;
        }
    }
    // NSNumber
    else if([compare isKindOfClass:[NSNumber class]] == YES)
    {
        if([(NSNumber *)compare compare:[NSNumber numberWithInt:0]] == NSOrderedSame)
        {
            isEmpty = YES;
        }
    }
    // NSDecimalNumber
    else if([compare isKindOfClass:[NSDecimalNumber class]] == YES)
    {
        if([(NSDecimalNumber *)compare compare:[NSDecimalNumber zero]] == NSOrderedSame)
        {
            isEmpty = YES;
        }
    }
    
    
    // return
    if(isEmpty == YES)
    {
        return replace;
    }
    else
    {
        return compare;
    }
}

// NVL2関数
+ (id) compare:(id)compare value1:(id)value1 value2:(id)value2
{
    BOOL isEmpty = NO;
    
    if(compare == nil)
    {
        isEmpty = YES;
    }
    // NSString
    else if([compare isKindOfClass:[NSString class]] == YES)
    {
        if([(NSString *)compare isEqualToString:@""] == YES)
        {
            isEmpty = YES;
        }
    }
    // NSNumber
    else if([compare isKindOfClass:[NSNumber class]] == YES)
    {
        if([(NSNumber *)compare compare:[NSNumber numberWithInt:0]] == NSOrderedSame)
        {
            isEmpty = YES;
        }
    }
    // NSDecimalNumber
    else if([compare isKindOfClass:[NSDecimalNumber class]] == YES)
    {
        if([(NSDecimalNumber *)compare compare:[NSDecimalNumber zero]] == NSOrderedSame)
        {
            isEmpty = YES;
        }
    }
    
    
    // return
    if(isEmpty == YES)
    {
        return value2;
    }
    else
    {
        return value1;
    }
}

@end
