//
//  CTCoreDataRequest.h
//  PStamp
//
//  Created by Take on 13/02/21.
//  Copyright (c) 2013年 naissance sapporo. co., ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTCoreDataRequest : NSObject

// データ取得
+ (NSArray *) requestWithContext:(NSManagedObjectContext *)context entityName:(NSString *)entityName whereQuery:(NSString *)whereQuery whereParameters:(NSArray *)whereParameters sortColumns:(NSArray *)sortColumns fetchLimit:(NSInteger)fetchLimit fetchOffset:(NSInteger)fetchOffset;

// データ取得(1件)
+ (NSManagedObject *) objectWithContext:(NSManagedObjectContext *)context entityName:(NSString *)entityName whereQuery:(NSString *)whereQuery whereParameters:(NSArray *)whereParameters;

// データ取得(1件)
+ (NSManagedObject *) objectWithContext:(NSManagedObjectContext *)context entityName:(NSString *)entityName whereQuery:(NSString *)whereQuery whereParameters:(NSArray *)whereParameters sortColumns:(NSArray *)sortColumns;

// データ取得(全件)
+ (NSArray *) listWithContext:(NSManagedObjectContext *)context entityName:(NSString *)entityName whereQuery:(NSString *)whereQuery whereParameters:(NSArray *)whereParameters sortColumns:(NSArray *)sortColumns;

// フェッチ取得
+ (NSFetchedResultsController *) fetchWithContext:(NSManagedObjectContext *)context entityName:(NSString *)entityName sectionNameKeyPath:(NSString *)sectionNameKeyPath cacheName:(NSString *)cacheName refreshCache:(BOOL)refrechCache whereQuery:(NSString *)whereQuery whereParameters:(NSArray *)whereParameters sortColumns:(NSArray *)sortColumns;

// count取得(1件)
+ (NSNumber *) countWithContext:(NSManagedObjectContext *)context entityName:(NSString *)entityName columnName:(NSString *)columnName whereQuery:(NSString *)whereQuery whereParameters:(NSArray *)whereParameters;

// max取得(1件)
+ (NSNumber *) maxWithContext:(NSManagedObjectContext *)context entityName:(NSString *)entityName columnName:(NSString *)columnName whereQuery:(NSString *)whereQuery whereParameters:(NSArray *)whereParameters;

// min取得(1件)
+ (NSNumber *) minWithContext:(NSManagedObjectContext *)context entityName:(NSString *)entityName columnName:(NSString *)columnName whereQuery:(NSString *)whereQuery whereParameters:(NSArray *)whereParameters;

// average取得(1件)
+ (NSNumber *) averageWithContext:(NSManagedObjectContext *)context entityName:(NSString *)entityName columnName:(NSString *)columnName whereQuery:(NSString *)whereQuery whereParameters:(NSArray *)whereParameters;

// sum取得(1件)
+ (NSNumber *) sumWithContext:(NSManagedObjectContext *)context entityName:(NSString *)entityName columnName:(NSString *)columnName whereQuery:(NSString *)whereQuery whereParameters:(NSArray *)whereParameters;
@end
