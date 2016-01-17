//
//  CTDropbox.h
//  AccountBookPod2
//
//  Created by TAKEMOTO KOUHEI on 2016/01/01.
//  Copyright © 2016年 citrus.tk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <DropboxSDK/DropboxSDK.h>

@interface CTDropbox : NSObject

// DBSessionの設定
+ (void)bindSessionWithAppKey:(NSString *)appKey appSecret:(NSString *)appSecret root:(NSString *)rootType;

@end
