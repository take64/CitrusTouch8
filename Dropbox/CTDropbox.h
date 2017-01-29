//
//  CTDropbox.h
//  HanayuAccountBookPod2
//
//  Created by take64 on 2016/01/01.
//  Copyright © 2016年 citrus.tk. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import <DropboxSDK/DropboxSDK.h>

@interface CTDropbox : NSObject

//// DBSessionの設定
//+ (void)bindSessionWithAppKey:(NSString *)appKey appSecret:(NSString *)appSecret root:(NSString *)rootType;

// upload data
+ (void)uploadData:(NSData *)datafile filename:(NSString *)filename progress:(CitrusTouchProgressBlock)progressBlock complete:(CitrusTouchProgressBlock)completeBlock;

// download data
+ (void)downloadData:(NSString *)filename progress:(CitrusTouchProgressBlock)progressBlock complete:(CitrusTouchProgressBlock)completeBlock;

// delete data
+ (void)deleteData:(NSString *)filename progress:(CitrusTouchProgressBlock)progressBlock complete:(CitrusTouchProgressBlock)completeBlock;

// put data
+ (void)putData:(NSData *)datafile filename:(NSString *)filename progress:(CitrusTouchProgressBlock)progressBlock complete:(CitrusTouchProgressBlock)completeBlock;

@end
