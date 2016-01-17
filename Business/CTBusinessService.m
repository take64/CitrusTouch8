//
//  CTBusinessService.m
//  CitrusTouch
//
//  Created by TAKEMOTO KOUHEI on 2013/02/15.
//  Copyright (c) 2013年 citrus.tk. All rights reserved.
//

#import "CTBusinessService.h"

#import "CTString.h"

@implementation CTBusinessService

// entity用ユニークID
+ (NSString *) uniqueID
{
    NSString *half01 = [CTString md5FromString:[NSString stringWithFormat:@"%d", rand()]];
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

// entity配列のdictionary配列化
+ (NSArray *)dictionariesWithEntities:(NSArray *)entities
{
    if(entities == nil)
    {
        return [NSArray array];
    }
    if([entities count] == 0)
    {
        return [NSArray array];
    }
    
    // entity
    NSManagedObject *firstEntity = [entities firstObject];
    // カラム名リスト
    NSDictionary *columns = [[firstEntity entity] attributesByName];
    // 返却値
    NSMutableArray *results = [NSMutableArray array];
    
    // 変換
    for(NSManagedObject *entity in entities)
    {
        NSMutableDictionary *result = [NSMutableDictionary dictionary];
        for(NSString *column in columns)
        {
            id value = [entity valueForKey:column];
            if (value == nil)
            {
                value = [NSNull null];
            }
            if([value isKindOfClass:[NSDate class]] == YES)
            {
                value = [CTDate stringWithDate:value format:@"yyyyMMddHHmmss"];
            }
            [result setObject:value forKey:column];
        }
        [results addObject:result];
    }
    
    return [results copy];
}


@end
