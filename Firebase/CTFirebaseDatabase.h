//
//  CTFirebaseDatabase.h
//  ChinottoPod
//
//  Created by kouhei.takemoto on 2017/01/28.
//  Copyright © 2017年 citrus.live. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTFirebaseDatabase : NSObject

//
// method
//

// データ保存
+ (void)saveWithPath:(NSString *)path key:(NSString *)keyValue data:(NSDictionary *)dicValue;

// データ読込
+ (void)loadWithPath:(NSString *)path result:(CitrusTouchFirebaseDatabaseResultBlock)completeBlock;

@end
