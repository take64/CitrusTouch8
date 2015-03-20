//
//  CTRegexp.m
//  CitrusTouch
//
//  Created by TAKEMOTO KOUHEIon 12/01/17.
//  Copyright (c) 2012 citrus.tk. All rights reserved.
//

#import "CTRegexp.h"

@implementation CTRegexp


// マッチする回数を取得
+ (int) matchOfPattern:(NSString *)pattern context:(NSString *)context
{
    NSError *error   = nil;
    NSRegularExpression *regexp = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:&error];
    if (error != nil)
    {
        return 0;
    }
    else
    {
        NSArray *matches = [regexp matchesInString:context options:0 range:NSMakeRange(0, [context length])];
        return (int)[matches count];
    }
    return 0;
}
@end
