//
//  CTDropbox.m
//  AccountBookPod2
//
//  Created by TAKEMOTO KOUHEI on 2016/01/01.
//  Copyright © 2016年 citrus.tk. All rights reserved.
//

#import "CTDropbox.h"

@implementation CTDropbox

// DBSessionの設定
+ (void)bindSessionWithAppKey:(NSString *)appKey appSecret:(NSString *)appSecret root:(NSString *)rootType
{
    DBSession *dbSession = [[DBSession alloc] initWithAppKey:appKey appSecret:appSecret root:rootType];
    [DBSession setSharedSession:dbSession];
}
@end
