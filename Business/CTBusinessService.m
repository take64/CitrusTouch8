//
//  CTBusinessService.m
//  CitrusTouch
//
//  Created by TAKEMOTO KOUHEI on 2013/02/15.
//  Copyright (c) 2013年 citrus.tk. All rights reserved.
//

#import "CTBusinessService.h"

#import "CTString.h"

#import <AdSupport/AdSupport.h>

@implementation CTBusinessService

// entity用ユニークID
+ (NSString *) uniqueID
{
    NSString *half01 = [CTString md5FromString:[[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString]];
    NSString *half02 = [CTString md5FromString:[NSString stringWithFormat:@"%f", [[NSDate date] timeIntervalSince1970]]];
    NSString *generateID = [NSString stringWithFormat:@"%@%@", half01, half02];
    return generateID;
}

// entity用ユニークID
+ (NSString *) uniqueIDSeed1:(NSString *)seed1 seed2:(NSString *)seed2
{
    NSString *half01 = [CTString md5FromString:seed1];
    NSString *half02 = [CTString md5FromString:seed2];
    NSString *generateID = [NSString stringWithFormat:@"%@%@", half01, half02];
    return generateID;
}
@end
