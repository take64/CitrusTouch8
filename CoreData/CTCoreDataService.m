//
//  CTCoreDataService.m
//  Panel15
//
//  Created by TAKEMOTO KOUHEI on 2012/10/04.
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

//// データ取得(1レコード)
//+ (NSManagedObject *) objectWithContext:(NSManagedObjectContext *)context entityName:(NSString *)entityName whereQuery:(NSString *)whereQuery whereParameters:(id)whereParameters;
//{
//    return [CTCoreDataService objectWithContext:context entityName:entityName whereQuery:whereQuery whereParameters:whereParameters sortColumnNames:nil sortAscending:NO];
//}
//
//// データ取得(1レコード/ソート付き)
//+ (NSManagedObject *) objectWithContext:(NSManagedObjectContext *)context entityName:(NSString *)entityName whereQuery:(NSString *)whereQuery whereParameters:(id)whereParameters sortColumnNames:(id)sortColumnNames sortAscending:(BOOL)sortAscending
//{
//    NSMutableArray *results = [CTCoreDataService listWithContext:context entityName:entityName whereQuery:whereQuery whereParameters:whereParameters sortColumnNames:sortColumnNames sortAscending:sortAscending];
//    
//    if(results == nil)
//    {
//        return nil;
//    }
//    else
//    {
//        return [results objectAtIndex:0];
//    }
//}
//
//// データ取得(複数レコード)
//+ (NSMutableArray *) listWithContext:(NSManagedObjectContext *)context entityName:(NSString *)entityName whereQuery:(NSString *)whereQuery whereParameters:(id)whereParameters
//{
//    return [CTCoreDataService listWithContext:context entityName:entityName whereQuery:whereQuery whereParameters:whereParameters sortColumnNames:nil sortAscending:NO];
//}
//
//// データ取得(複数レコード/ソート付き)
//+ (NSMutableArray *) listWithContext:(NSManagedObjectContext *)context entityName:(NSString *)entityName whereQuery:(NSString *)whereQuery whereParameters:(id)whereParameters sortColumnNames:(id)sortColumnNames sortAscending:(BOOL)sortAscending
//{
//    if(whereParameters != nil && [whereParameters isKindOfClass:[NSArray class]] == NO)
//    {
//        whereParameters = [NSArray arrayWithObject:whereParameters];
//    }
//    
//    // 座席データを取得
//    NSFetchRequest *request = [[NSFetchRequest alloc] init];
//    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName
//                                              inManagedObjectContext:context];
//    [request setEntity:entity];
//    
//    // 取得条件
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:whereQuery argumentArray:whereParameters];
//    [request setPredicate:predicate];
//    
//    if(sortColumnNames != nil)
//    {
//        if([sortColumnNames isKindOfClass:[NSArray class]] == NO)
//        {
//            sortColumnNames = [NSArray arrayWithObjects:sortColumnNames, nil];
//        }
//        
//        NSMutableArray *sortDescriptors = [NSMutableArray arrayWithCapacity:1];
//        for(NSString *columnName in sortColumnNames)
//        {
//            NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:columnName ascending:sortAscending];
//            [sortDescriptors addObject:sort];
//        }
//        
//        [request setSortDescriptors:sortDescriptors];
//    }
//    
//    
//    // 実取得
//    NSError *error;
//    NSMutableArray *results = [[context executeFetchRequest:request error:&error] mutableCopy];
//    
//    // エラー
//    if(error)
//    {
//        NSLog(@"ERROR! CTCoreDataService.listWithContext - %@",error);
//        return nil;
//    }
//    else if([results count] == 0)
//    {
//        return nil;
//    }
//    else
//    {
//        return results;
//    }
//}
//
//// 最大値を取得
//+ (NSNumber *) maxWithContext:(NSManagedObjectContext *)context entityName:(NSString *)entityName columnName:(NSString *)columnName whereQuery:(NSString *)whereQuery whereParameters:(id)whereParameters
//{
//    // リクエスト
//    NSFetchRequest *request = [[NSFetchRequest alloc] init];
//    
//    // 取得用 Entity 生成
//    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName
//                                              inManagedObjectContext:context];
//    [request setEntity:entity];
//    
//    // expression
//    NSExpression *keyPathExpression = [NSExpression expressionForKeyPath:columnName];
//    NSExpression *expression = [NSExpression expressionForFunction:@"max:"
//                                                         arguments:[NSArray arrayWithObject:keyPathExpression]];
//    // expression description
//    NSExpressionDescription *expressionDescription = [[NSExpressionDescription alloc] init];
//    [expressionDescription setName:@"maxID"];
//    [expressionDescription setExpression:expression];
//    [expressionDescription setExpressionResultType:NSInteger16AttributeType];
//    
//    // result properties
//    [request setResultType:NSDictionaryResultType];
//    [request setPropertiesToFetch:[NSArray arrayWithObject:expressionDescription]];
//    
//    // 取得条件
//    NSPredicate *predicate = [NSPredicate predicateWithFormat: whereQuery, whereParameters];
//    [request setPredicate:predicate];
//    
//    // データ取得
//    NSError *error;
//    NSArray *results = [context executeFetchRequest:request error:&error];
//    NSNumber *maxID;
//    
//    // エラー
//    if(error)
//    {
//        NSLog(@"ERROR! CTCoreDataService.maxWithContext - %@",error);
//        maxID = [NSNumber numberWithInt:0];
//    }
//    else
//    {
//        maxID = [[results objectAtIndex:0] valueForKey:@"maxID"];
//    }
//    
//    return maxID;
//}
//
//// 新レコードを取得する
//+ (NSManagedObject *) newObjectWithEntityName:(NSString *)entityName context:(NSManagedObjectContext *)context
//{
//    return [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:context];
//}
//
//// フェッチコントローラー
//+ (NSFetchedResultsController *) fetchWithContext:(NSManagedObjectContext *)context entityName:(NSString *)entityName sectionNameKeyPath:(NSString *)sectionNameKeyPath cacheName:(NSString *)cacheName refreshCache:(BOOL)refrechCache whereQuery:(NSString *)whereQuery whereParameters:(id)whereParameters sortColumnNames:(id)sortColumnNames sortAscending:(BOOL)sortAscending
//{
//    if(whereParameters != nil && [whereParameters isKindOfClass:[NSArray class]] == NO)
//    {
//        whereParameters = [NSArray arrayWithObject:whereParameters];
//    }
//    
//    // 座席データを取得
//    NSFetchRequest *request = [[NSFetchRequest alloc] init];
//    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:context];
//    [request setEntity:entity];
//    
//    // 取得条件
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:whereQuery argumentArray:whereParameters];
//    [request setPredicate:predicate];
//    
//    // ソート
//    if(sortColumnNames != nil)
//    {
//        if([sortColumnNames isKindOfClass:[NSArray class]] == NO)
//        {
//            sortColumnNames = [NSArray arrayWithObjects:sortColumnNames, nil];
//        }
//        
//        NSMutableArray *sortDescriptors = [NSMutableArray arrayWithCapacity:1];
//        for(NSString *columnName in sortColumnNames)
//        {
//            NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:columnName ascending:sortAscending];
//            [sortDescriptors addObject:sort];
//        }
//        [request setSortDescriptors:sortDescriptors];
//    }
//    
//    // 実取得
//    NSFetchedResultsController *fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:context sectionNameKeyPath:sectionNameKeyPath cacheName:nil];
//    
//    return fetchedResultsController;
//}

@end
