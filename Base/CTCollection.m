//
//  CTCollection.m
//  CitrusTouch
//
//  Created by TAKEMOTO KOUHEI on 2013/02/10.
//  Copyright (c) 2013年 citrus.tk. All rights reserved.
//

#import "CTCollection.h"

@implementation CTCollection

// 一覧情報のソート(NSArray) @[ @{'column1', @0}, @{'column', @1} ]
+ (NSArray *) sortWithEntitySet:(NSSet *)setList sort:(NSArray *)sortList
{
    return [self sortWithEntityArray:[setList allObjects] sort:sortList];
}

// 一覧情報のソート(NSArray)
+ (NSArray *) sortWithEntityArray:(NSArray *)arrayList sort:(NSArray *)sortList
{
    // ソート
    NSMutableArray *sortDescriptors = [NSMutableArray arrayWithCapacity:1];
    for(NSDictionary *sortDic in sortList)
    {
        NSString *columnName = [[sortDic allKeys] objectAtIndex:0];
        BOOL sortAscending = [[sortDic objectForKey:columnName] boolValue];
        NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:columnName ascending:sortAscending];
        [sortDescriptors addObject:sort];
    }
    
    return [[arrayList sortedArrayUsingDescriptors:sortDescriptors] mutableCopy];
}

// 配列オブジェクト内のオブジェクトを配列で返す
+ (NSArray *) arrayWithEntityArray:(NSArray *)arrayList keyPath:(NSString *)keyPath
{
    NSMutableArray *array = [NSMutableArray array];
    for(id object in arrayList)
    {
        [array addObject:[object valueForKeyPath:keyPath]];
    }
    return [array copy];
}

// 配列オブジェクトをキーでソートする
+ (NSArray *) sortOfKeyWithArray:(NSArray *)arrayList
{
    return [arrayList sortedArrayUsingSelector:@selector(compare:)];
}

@end
