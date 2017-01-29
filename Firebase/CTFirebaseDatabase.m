//
//  CTFirebaseDatabase.m
//  ChinottoPod
//
//  Created by kouhei.takemoto on 2017/01/28.
//  Copyright © 2017年 citrus.live. All rights reserved.
//

#import "CTFirebaseDatabase.h"

@implementation CTFirebaseDatabase

// データ保存
+ (void)saveWithPath:(NSString *)path key:(NSString *)keyValue data:(NSDictionary *)dicValue
{
    // データベース
    FIRDatabaseReference *reference = [[FIRDatabase database] reference];
    
    // ユーザー
    FIRUser *user = [[FIRAuth auth] currentUser];
    
    [[[[reference child:path] child:[user uid]] child:keyValue] setValue:dicValue];
}

// データ読込
+ (void)loadWithPath:(NSString *)path result:(CitrusTouchFirebaseDatabaseResultBlock)completeBlock
{
    // データベース
    FIRDatabaseReference *reference = [[FIRDatabase database] reference];
    
    // ユーザー
    FIRUser *user = [[FIRAuth auth] currentUser];
    
    [[[reference child:path] child:[user uid]] observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
       
        completeBlock([snapshot value]);
        
    }];
}

@end
