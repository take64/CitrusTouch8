//
//  CTCoreDataService.m
//  CitrusTouch
//
//  Created by take64 on 2012/10/04.
//  Copyright (c) 2012年 citrus.tk. All rights reserved.
//

#import "CTCoreDataService.h"

@implementation CTCoreDataService

// レコードのデータをDictionaryで取得
+ (NSDictionary *)dictionaryWithEntity:(NSManagedObject *)entityValue
{
    
    NSArray *keyList = [[[entityValue entity] attributesByName] allKeys];
    NSMutableDictionary *data = [NSMutableDictionary dictionaryWithCapacity:[keyList count]];
    for(NSString *keyString in keyList)
    {
        id valueData = [entityValue valueForKey:keyString];
        if(entityValue )
        if([valueData isKindOfClass:[NSString class]] == YES)
        {
            [data setObject:[CTNVL compare:valueData replace:@""] forKey:keyString];
        }
        else if([valueData isKindOfClass:[NSNumber class]] == YES)
        {
            [data setObject:[CTNVL compare:valueData replace:@0] forKey:keyString];
        }
        else if([valueData isKindOfClass:[NSDecimalNumber class]] == YES)
        {
            [data setObject:[CTNVL compare:valueData replace:[NSDecimalNumber zero]] forKey:keyString];
        }
        else if([valueData isKindOfClass:[NSDate class]] == YES)
        {
            [data setObject:[CTNVL compare:valueData replace:[NSDate dateWithTimeIntervalSince1970:0]] forKey:keyString];
        }
        else if([valueData isKindOfClass:[NSData class]] == YES)
        {
            [data setObject:[CTNVL compare:valueData replace:[NSData data]] forKey:keyString];
        }
    }
    return [data copy];
}

// ObjectデータをEntityにbindする
+ (NSManagedObject *)bindEntity:(NSManagedObject *)entityValue fromObject:(CTBusinessElement *)elementValue
{
    NSArray *keyList = [[[entityValue entity] attributesByName] allKeys];
    for(NSString *keyString in keyList)
    {
        if([keyString isEqualToString:@"status"] == YES
           || [keyString isEqualToString:@"created"] == YES
           || [keyString isEqualToString:@"modified"] == YES)
        {
            continue;
        }
        else
        {
            if([elementValue respondsToSelector:NSSelectorFromString(keyString)] == YES)
            {
                if([elementValue valueForKey:keyString] != nil)
                {
                    [entityValue setValue:[elementValue valueForKey:keyString] forKey:keyString];
                }
            }
        }
    }
    
    return entityValue;
}

@end
