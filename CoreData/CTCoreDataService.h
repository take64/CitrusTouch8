//
//  CTCoreDataService.h
//  CitrusTouch
//
//  Created by take64 on 2012/10/04.
//  Copyright (c) 2012年 citrus.tk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTCoreDataService : NSObject

// レコードのデータをDictionaryで取得
+ (NSDictionary *)dictionaryWithEntity:(NSManagedObject *)entityValue;

// ObjectデータをEntityにbindする
+ (NSManagedObject *)bindEntity:(NSManagedObject *)entityValue fromObject:(CTBusinessElement *)elementValue;
//// データ取得(1レコード)
//+ (NSManagedObject *) objectWithContext:(NSManagedObjectContext *)context entityName:(NSString *)entityName whereQuery:(NSString *)whereQuery whereParameters:(id)whereParameters;
//
//// データ取得(1レコード/ソート付き)
//+ (NSManagedObject *) objectWithContext:(NSManagedObjectContext *)context entityName:(NSString *)entityName whereQuery:(NSString *)whereQuery whereParameters:(id)whereParameters sortColumnNames:(id)sortColumnNames sortAscending:(BOOL)sortAscending;
//
//// データ取得(複数レコード)
//+ (NSMutableArray *) listWithContext:(NSManagedObjectContext *)context entityName:(NSString *)entityName whereQuery:(NSString *)whereQuery whereParameters:(id)whereParameters;
//
//// データ取得(複数レコード/ソート付き)
//+ (NSMutableArray *) listWithContext:(NSManagedObjectContext *)context entityName:(NSString *)entityName whereQuery:(NSString *)whereQuery whereParameters:(id)whereParameters sortColumnNames:(id)sortColumnNames sortAscending:(BOOL)sortAscending;
//
//// 最大値を取得
//+ (NSNumber *) maxWithContext:(NSManagedObjectContext *)context entityName:(NSString *)entityName columnName:(NSString *)columnName whereQuery:(NSString *)whereQuery whereParameters:(id)whereParameters;
//
//// 新レコードを取得する
//+ (NSManagedObject *) newObjectWithEntityName:(NSString *)entityName context:(NSManagedObjectContext *)context;
//
//// フェッチコントローラー
//+ (NSFetchedResultsController *) fetchWithContext:(NSManagedObjectContext *)context entityName:(NSString *)entityName sectionNameKeyPath:(NSString *)sectionNameKeyPath cacheName:(NSString *)cacheName refreshCache:(BOOL)refrechCache whereQuery:(NSString *)whereQuery whereParameters:(id)whereParameters sortColumnNames:(id)sortColumnNames sortAscending:(BOOL)sortAscending;
@end
