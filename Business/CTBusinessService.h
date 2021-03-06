//
//  CTBusinessService.h
//  CitrusTouch
//
//  Created by take64 on 2013/02/15.
//  Copyright (c) 2013年 citrus.tk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTBusinessService : NSObject

// entity用ユニークID
+ (NSString *) uniqueID;

// entity用ユニークID
+ (NSString *) uniqueIDSeed1:(NSString *)seed1 seed2:(NSString *)seed2;

// entity配列のdictionary配列化
+ (NSArray *)dictionariesWithEntities:(NSArray *)entities;

// dictionary配列からentityに変換
+ (NSManagedObject *)entityWithEntity:(NSManagedObject *)entityValue withDictionary:(NSDictionary *)dicValue;

@end
