//
//  CTCoreDataManager.h
//  CitrusTouch
//
//  Created by TAKEMOTO KOUHEI on 2012/10/04.
//  Copyright (c) 2012年 citrus.tk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTCoreDataManager : NSObject
{
    // コンテクスト
    NSManagedObjectContext *_managedObjectContext;
    
    // モデル
    NSManagedObjectModel *_managedObjectModel;
    
    // ストア
    NSPersistentStoreCoordinator *_persistentStoreCoordinator;
    
    // モデル名
    NSString *_modelName;
    
    // モデル名拡張子
    NSString *_modelExtension;
    
    // ストアパス
    NSString *_storePath;
}

//
// property
//
@property (retain) NSManagedObjectContext *_managedObjectContext;
@property (retain) NSManagedObjectModel *_managedObjectModel;
@property (retain) NSPersistentStoreCoordinator *_persistentStoreCoordinator;
@property (nonatomic, retain) NSString *_modelName;
@property (nonatomic, retain) NSString *_modelExtension;
@property (nonatomic, retain) NSString *_storePath;




//
// method
//

// 初期化
- (id) initWithStorePath:(NSString *)storePath modelName:(NSString *)modelName modelExtension:(NSString *)modelExtension;




//
// caller method
//

// コンテクスト
- (NSManagedObjectContext *) managedObjectContext:(NSThread *)thread;
// コンテクスト(メインスレッド)
- (NSManagedObjectContext *) managedObjectContextForMainThread;
// コンテクスト(カレントスレッド)
- (NSManagedObjectContext *) managedObjectContextForCurrentThread;
// モデル
- (NSManagedObjectModel *) managedObjectModel;
// ストア
- (NSPersistentStoreCoordinator *) persistentStoreCoordinator;
// 保存
- (BOOL) saveContext;
// 保存&マージ
- (void) saveWithMergeObject:(NSManagedObject *)managedObject;
// 削除
- (BOOL) deleteWithSave:(NSManagedObject *)managedObject;
// ロールバック
- (void) rollbackContext;
// 保存通知
- (void) managedObjectContextDidSave:(NSNotification *)notification;

// データオブジェクト生成
- (NSManagedObject *)newObjectWithEntityName:(NSString *)entityName;

@end
