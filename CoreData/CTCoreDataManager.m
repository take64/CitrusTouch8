//
//  CTCoreDataManager.m
//  CitrusTouch
//
//  Created by TAKEMOTO KOUHEI on 2012/10/04.
//  Copyright (c) 2012年 citrus.tk. All rights reserved.
//

#import "CTCoreDataManager.h"

static const NSString *NSManagedObjectContextThreadKey = @"NSManagedObjectContextThreadKey";

@implementation CTCoreDataManager



//
// synthesize
//
@synthesize _managedObjectContext;
@synthesize _managedObjectModel;
@synthesize _persistentStoreCoordinator;
@synthesize _modelName;
@synthesize _modelExtension;
@synthesize _storePath;




//
// method
//

// 初期化
- (id) initWithStorePath:(NSString *)storePath modelName:(NSString *)modelName modelExtension:(NSString *)modelExtension
{
    self = [super init];
    if(self)
    {
        // 初期設定
        [self set_modelName:        modelName];
        [self set_modelExtension:   modelExtension];
        [self set_storePath:        storePath];
    }
    return self;
}




//
// caller method
//

// コンテクスト
- (NSManagedObjectContext *) managedObjectContext:(NSThread *)thread
{
    // 対象スレッドからコンテキスト取得
    NSMutableDictionary *threadDictionary = [thread threadDictionary];
    NSManagedObjectContext *context = [threadDictionary objectForKey:NSManagedObjectContextThreadKey];
    
    // 取得できない場合
    if(context == nil)
    {
        // 生成
        context = [[NSManagedObjectContext alloc] init];
        // ストア関連付け
        [context setPersistentStoreCoordinator:[self persistentStoreCoordinator]];
        // 現在スレッドに設定
        [[thread threadDictionary] setObject:context forKey:NSManagedObjectContextThreadKey];
        // マージポリシー
        [context setMergePolicy:NSMergeByPropertyObjectTrumpMergePolicy];
    }
    
    return context;
}
// コンテクスト(メインスレッド)
- (NSManagedObjectContext *) managedObjectContextForMainThread
{
    return [self managedObjectContext:[NSThread mainThread]];
}
// コンテクスト(カレントスレッド)
- (NSManagedObjectContext *) managedObjectContextForCurrentThread
{
    return [self managedObjectContext:[NSThread currentThread]];
}
// モデル
- (NSManagedObjectModel *) managedObjectModel
{
    if ([self _managedObjectModel] != nil)
    {
        return [self _managedObjectModel];
    }
    
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:[self _modelName] withExtension:[self _modelExtension]];
    [self set_managedObjectModel:[[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL]];
    
    return [self _managedObjectModel];
}

// ストア
- (NSPersistentStoreCoordinator *) persistentStoreCoordinator
{
    if ([self _persistentStoreCoordinator] != nil)
    {
        return [self _persistentStoreCoordinator];
    }
    
    NSURL *storeURL = [[[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject] URLByAppendingPathComponent:[self _storePath]];
    
    
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                             [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption,
                             [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
    
    NSError *error = nil;
    [self set_persistentStoreCoordinator:
     [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]]
     ];
    if (![[self _persistentStoreCoordinator] addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error])
    {
        NSLog(@"Unresolved error %@", error);
        NSLog(@"%@", [error userInfo]);
        abort();
    }
    
    return [self _persistentStoreCoordinator];
}
// 保存
- (BOOL) saveContext
{
    NSManagedObjectContext *context = [self managedObjectContextForCurrentThread];
    BOOL isMainThread = [[NSThread currentThread] isMainThread];
    
    // メインスレッドでない場合は通知する
    if(isMainThread == NO)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(managedObjectContextDidSave:)
                                                     name:NSManagedObjectContextDidSaveNotification
                                                   object:context];
    }
    
    // 保存処理
    BOOL result = [context save:nil];
    
    // 通知削除
    if(isMainThread == NO)
    {
        [[NSNotificationCenter defaultCenter] removeObserver:self
                                                        name:NSManagedObjectContextDidSaveNotification
                                                      object:context];
    }
    
    return result;
}
// 保存&マージ
- (void) saveWithMergeObject:(NSManagedObject *)managedObject
{
    // 保存
    [self saveContext];
    
    // マージ
    [[self managedObjectContextForCurrentThread] refreshObject:managedObject mergeChanges:YES];
}
// 削除
- (BOOL) deleteWithSave:(NSManagedObject *)managedObject
{
    // 削除
    [[self managedObjectContextForCurrentThread] deleteObject:managedObject];
    
    // 保存
    return [self saveContext];
}
// 保存＆mainThread保存
- (void) saveComplete
{
    [self saveContext];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self saveContext];
    });
}
// ロールバック
- (void) rollbackContext
{
    NSManagedObjectContext *context = [self managedObjectContextForCurrentThread];
    [context rollback];
}
// 保存通知
- (void) managedObjectContextDidSave:(NSNotification *)notification
{
    NSManagedObjectContext *context = [self managedObjectContextForMainThread];
    
    [context performSelectorOnMainThread:@selector(mergeChangesFromContextDidSaveNotification:)
                              withObject:notification
                           waitUntilDone:YES];
}

// データオブジェクト生成
- (NSManagedObject *)newObjectWithEntityName:(NSString *)entityName
{
    return [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:[self managedObjectContextForCurrentThread]];
}


@end
