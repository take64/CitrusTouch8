//
//  CTDropboxCoreApi.h
//  CitrusTouch
//
//  Created by TAKEMOTO KOUHEI on 2013/12/22.
//  Copyright (c) 2013年 citrus.tk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <DropboxSDK/DropboxSDK.h>

//typedef void (^CTDropboxHttpRequestComplete)(NSDictionary *userInfo);

@interface CTDropboxCoreApi : NSObject <DBRestClientDelegate>
{
    DBRestClient *restClient;
    
    CitrusTouchCompleteBlock progressBlock;
    CitrusTouchCompleteBlock completeBlock;
    
}
//
// property
//
@property (nonatomic, retain) DBRestClient *restClient;
@property (nonatomic, copy)   CitrusTouchCompleteBlock progressBlock;
@property (nonatomic, copy)   CitrusTouchCompleteBlock completeBlock;


//
// method
//

// データ受信
- (void)recvDataWithName:(NSString *)filename directory:(NSString *)directory  progress:(CitrusTouchCompleteBlock)progress complete:(CitrusTouchCompleteBlock)complete;

// データ送信
- (void)sendData:(NSData *)dataValue filename:(NSString *)filename directory:(NSString *)directory progress:(CitrusTouchCompleteBlock)progress complete:(CitrusTouchCompleteBlock)complete;


//
// singleton
//

// singleton
+ (CTDropboxCoreApi *)sharedService;


@end
