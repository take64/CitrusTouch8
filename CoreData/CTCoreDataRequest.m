//
//  CTCoreDataRequest.m
//  PStamp
//
//  Created by Take on 13/02/21.
//  Copyright (c) 2013年 naissance sapporo. co., ltd. All rights reserved.
//

#import "CTCoreDataRequest.h"

@implementation CTCoreDataRequest

// データ取得
+ (NSArray *) requestWithContext:(NSManagedObjectContext *)context entityName:(NSString *)entityName whereQuery:(NSString *)whereQuery whereParameters:(NSArray *)whereParameters sortColumns:(NSArray *)sortColumns fetchLimit:(NSInteger)fetchLimit fetchOffset:(NSInteger)fetchOffset;
{
    // 座席Entityを取得
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:context];
    [request setEntity:entity];
    
    // 取得条件
    NSPredicate *predicate = [NSPredicate predicateWithFormat:whereQuery argumentArray:whereParameters];
    [request setPredicate:predicate];
    
    // ソート
    if(sortColumns != nil && [sortColumns count] > 0)
    {
        NSMutableArray *sortDescriptors = [NSMutableArray arrayWithCapacity:1];
        NSSortDescriptor *sort;
        for(NSDictionary *sortColumn in sortColumns)
        {
            for(NSString *keyString in sortColumn)
            {
                sort = [NSSortDescriptor sortDescriptorWithKey:keyString
                                                     ascending:[(NSNumber *)[sortColumn objectForKey:keyString] boolValue]
                        ];
                [sortDescriptors addObject:sort];
            }
        }
        [request setSortDescriptors:sortDescriptors];
    }
    
    // フェッチオフセット
    [request setFetchOffset:fetchOffset];
    
    // フェッチリミット
    if(fetchLimit > 0)
    {
        [request setFetchLimit:fetchLimit];
    }
    
    // 実取得
    NSError *error;
    NSArray *results = [context executeFetchRequest:request error:&error];
    
    // エラー
    if(error)
    {
        NSLog(@"ERROR! CTCoreDataRequest.requestWithContext - %@",error);
        return nil;
    }
    else if([results count] == 0)
    {
        return nil;
    }
    else
    {
        return results;
    }
}

// データ取得(1件)
+ (NSManagedObject *) objectWithContext:(NSManagedObjectContext *)context entityName:(NSString *)entityName whereQuery:(NSString *)whereQuery whereParameters:(NSArray *)whereParameters
{
    return [self objectWithContext:context entityName:entityName whereQuery:whereQuery whereParameters:whereParameters sortColumns:nil];
}

// データ取得(1件)
+ (NSManagedObject *) objectWithContext:(NSManagedObjectContext *)context entityName:(NSString *)entityName whereQuery:(NSString *)whereQuery whereParameters:(NSArray *)whereParameters sortColumns:(NSArray *)sortColumns
{
    NSArray *results = [self requestWithContext:context entityName:entityName whereQuery:whereQuery whereParameters:whereParameters sortColumns:sortColumns fetchLimit:1 fetchOffset:0];
    if(results != nil)
    {
        return [results objectAtIndex:0];
    }
    else
    {
        return nil;
    }
}

// データ取得(全件)
+ (NSArray *) listWithContext:(NSManagedObjectContext *)context entityName:(NSString *)entityName whereQuery:(NSString *)whereQuery whereParameters:(NSArray *)whereParameters sortColumns:(NSArray *)sortColumns
{
    NSArray *results = [self requestWithContext:context entityName:entityName whereQuery:whereQuery whereParameters:whereParameters sortColumns:sortColumns fetchLimit:0 fetchOffset:0];
    if(results != nil)
    {
        return results;
    }
    else
    {
        return nil;
    }
}

// フェッチ取得
+ (NSFetchedResultsController *) fetchWithContext:(NSManagedObjectContext *)context entityName:(NSString *)entityName sectionNameKeyPath:(NSString *)sectionNameKeyPath cacheName:(NSString *)cacheName refreshCache:(BOOL)refrechCache whereQuery:(NSString *)whereQuery whereParameters:(NSArray *)whereParameters sortColumns:(NSArray *)sortColumns
{
    if(whereParameters != nil && ([whereParameters isKindOfClass:[NSArray class]] == YES || [whereParameters isKindOfClass:[NSMutableArray class]] == YES) && [whereParameters count] == 0)
    {
        whereParameters = nil;
    }
    
    // 座席Entityを取得
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:context];
    [request setEntity:entity];
    
    // 取得条件
    NSPredicate *predicate = [NSPredicate predicateWithFormat:whereQuery argumentArray:whereParameters];
    [request setPredicate:predicate];
    
    // ソート
    if(sortColumns != nil && [sortColumns count] > 0)
    {
        NSMutableArray *sortDescriptors = [NSMutableArray arrayWithCapacity:1];
        NSSortDescriptor *sort;
        for(NSDictionary *sortColumn in sortColumns)
        {
            for(NSString *keyString in sortColumn)
            {
                sort = [NSSortDescriptor sortDescriptorWithKey:keyString ascending:[(NSNumber *)[sortColumn objectForKey:keyString] boolValue]];
                [sortDescriptors addObject:sort];
            }
        }
        [request setSortDescriptors:sortDescriptors];
    }
    
    // 実取得
    NSFetchedResultsController *fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:context sectionNameKeyPath:sectionNameKeyPath cacheName:nil];
    
    return fetchedResultsController;
}

// 件数取得(1件)
+ (NSInteger) countWithContext:(NSManagedObjectContext *)context entityName:(NSString *)entityName columnName:(NSString *)columnName whereQuery:(NSString *)whereQuery whereParameters:(NSArray *)whereParameters
{
    // リクエスト
    NSFetchRequest *request = [[NSFetchRequest alloc] init];

    // 取得用 Entity 生成
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:context];
    [request setEntity:entity];

    // expression
    NSExpression *keyPathExpression = [NSExpression expressionForKeyPath:columnName];
    NSExpression *expression = [NSExpression expressionForFunction:@"count:" arguments:@[ keyPathExpression ]];
    // expression description
    NSExpressionDescription *expressionDescription = [[NSExpressionDescription alloc] init];
    [expressionDescription setName:@"countID"];
    [expressionDescription setExpression:expression];
    [expressionDescription setExpressionResultType:NSInteger16AttributeType];

    // result properties
    [request setResultType:NSDictionaryResultType];
    [request setPropertiesToFetch:[NSArray arrayWithObject:expressionDescription]];

    // 取得条件
    NSPredicate *predicate = [NSPredicate predicateWithFormat:whereQuery argumentArray:whereParameters];
    [request setPredicate:predicate];

    // データ取得
    NSError *error;
    NSArray *results = [context executeFetchRequest:request error:&error];
    NSNumber *countID;

    // エラー
    if(error)
    {
        NSLog(@"ERROR! CTCoreDataService.maxWithContext - %@",error);
        countID = @0;
    }
    else
    {
        countID = [[results objectAtIndex:0] valueForKey:@"countID"];
    }
    
    return [countID integerValue];
}

@end
