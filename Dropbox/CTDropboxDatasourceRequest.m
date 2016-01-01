////
////  CTDropboxDatasourceRequest.m
////  CitrusTouch
////
////  Created by TAKEMOTO KOUHEI on 2013/12/22.
////  Copyright (c) 2013年 citrus.tk. All rights reserved.
////
//
//#import "CTDropboxDatasourceRequest.h"
//
//@implementation CTDropboxDatasourceRequest
//
//// DBRecordの値をEntityに設定する
//+ (NSManagedObject *)bindEntity:(NSManagedObject *)entityValue fromDBRecord:(DBRecord *)dbRecord
//{
//    NSArray *keyList = [[[entityValue entity] attributesByName] allKeys];
//    for(NSString *keyString in keyList)
//    {
//        id valueData = [dbRecord objectForKey:keyString];
//        if(valueData != nil)
//        {
//            [entityValue setValue:valueData forKey:keyString];
//        }
//    }
//    return entityValue;
//}
//
//// DBRecordの値をEntityに設定する
//+ (NSManagedObject *)bindDataEntity:(NSManagedObject *)entityValue fromDBRecord:(DBRecord *)dbRecord
//{
//    NSDictionary *data = [NSKeyedUnarchiver unarchiveObjectWithData:[dbRecord objectForKey:@"data"]];
//    NSArray *keyList = [[[entityValue entity] attributesByName] allKeys];
//    for(NSString *keyString in keyList)
//    {
//        id valueData = [data objectForKey:keyString];
//        if(valueData != nil)
//        {
//            [entityValue setValue:valueData forKey:keyString];
//        }
//    }
//    return entityValue;
//}
//
//// 座席内容を削除する
//+ (void) trancateForTable:(NSString *)tableName fromDatastore:(DBDatastore *)datastore complete:(CTDropboxDatasourceRequestComplete)complete
//{
//    NSError *error;
//    
//    DBTable *dbTable = [datastore getTable:tableName];
//    
//    NSArray *dbRecords = [dbTable query:nil error:&error];
//    if(error != nil)
//    {
//        complete(nil, error);
//    }
//    
//    for(DBRecord *dbRecord in dbRecords)
//    {
//        [dbRecord deleteRecord];
//    }
//    
//    [datastore sync:&error];
//    if(error != nil)
//    {
//        complete(nil, error);
//    }
//
//    complete(@{}, nil);
//}
//
//@end
