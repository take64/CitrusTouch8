//
//  CTNVL.m
//  LorsPOS
//
//  Created by take64 on 12/01/19.
//  Copyright (c) 2012 citrus.tk. All rights reserved.
//

#import "CTNVL.h"

@implementation CTNVL

// NVL関数
+ (id) compare:(id)compare replace:(id)replace
{
    if(compare == nil)
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
    if(compare == nil)
    {
        return value2;
    }
    else
    {
        return value1;
    }
}
@end
