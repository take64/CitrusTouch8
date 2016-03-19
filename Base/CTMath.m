//
//  CTMath.m
//  CitrusTouch
//
//  Created by kouhei.takemoto on 2016/03/19.
//  Copyright © 2016年 citrus.tk. All rights reserved.
//

#import "CTMath.h"

@implementation CTMath

// パーセント
+ (double) percentWithNumerator:(double)numerator denominator:(double)denominator
{
    if(denominator == 0)
    {
        return 0;
    }
    return ((numerator / denominator) * 100);
}
@end
