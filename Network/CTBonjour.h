//
//  CTBonjour.h
//  Bonjour
//
//  Created by TAKEMOTO KOUHEI on 2014/02/16.
//  Copyright (c) 2014年 citrus.tk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTBonjour : NSObject


// サービス名を取得
+ (NSString *) callServiceNameFromName:(NSString *)serviceName;

@end
