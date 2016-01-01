//deprecated
//
////
////  CTDropboxDatasourceRequest.h
////  CitrusTouch
////
////  Created by TAKEMOTO KOUHEI on 2013/12/22.
////  Copyright (c) 2013年 citrus.tk. All rights reserved.
////
//
//#import <Foundation/Foundation.h>
//#import <DropboxSDK/DropboxSDK.h>
//
//typedef void (^CTDropboxDatasourceRequestComplete)(NSDictionary *userInfo, NSError *error);
//
//@interface CTDropboxDatasourceRequest : NSObject
//
//// DBRecordの値をEntityに設定する
//+ (NSManagedObject *)bindEntity:(NSManagedObject *)entityValue fromDBRecord:(DBRecord *)dbRecord;
//
//// DBRecordの値をEntityに設定する
//+ (NSManagedObject *)bindDataEntity:(NSManagedObject *)entityValue fromDBRecord:(DBRecord *)dbRecord;
//
//// 座席内容を削除する
//+ (void) trancateForTable:(NSString *)tableName fromDatastore:(DBDatastore *)datastore complete:(CTDropboxDatasourceRequestComplete)complete;
//
//
//@end
