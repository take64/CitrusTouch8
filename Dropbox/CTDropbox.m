//
//  CTDropbox.m
//  HanayuAccountBookPod2
//
//  Created by take64 on 2016/01/01.
//  Copyright © 2016年 citrus.tk. All rights reserved.
//

#import "CTDropbox.h"

@implementation CTDropbox

//// DBSessionの設定
//+ (void)bindSessionWithAppKey:(NSString *)appKey appSecret:(NSString *)appSecret root:(NSString *)rootType
//{
//    DBSession *dbSession = [[DBSession alloc] initWithAppKey:appKey appSecret:appSecret root:rootType];
//    [DBSession setSharedSession:dbSession];
//}

// upload data
+ (void)uploadData:(NSData *)datafile filename:(NSString *)filename progress:(CitrusTouchProgressBlock)progressBlock complete:(CitrusTouchProgressBlock)completeBlock;
{
    // client
    DropboxClient *client = [DropboxClientsManager authorizedClient];
    
    // name
    filename = [NSString stringWithFormat:@"/%@", filename];
    
    // upload
    [[[[client filesRoutes] uploadData:filename inputData:datafile] response:^(DBFILESFileMetadata *result, DBFILESUploadError *routeError, DBError *error) {
        
        CTProgress *progress = [[CTProgress alloc] initWithComplete];
        
        completeBlock(progress, nil);
        
    }] progress:^(int64_t bytesUploaded, int64_t totalBytesUploaded, int64_t totalBytesExpectedToUploaded) {
        
//        CTLog(@"%lld\n%lld\n%lld\n", bytesUploaded, totalBytesUploaded, totalBytesExpectedToUploaded);
        
        CTProgress *progress = [[CTProgress alloc] initWithProgressing:@(bytesUploaded) total:@(totalBytesUploaded)];
        
        progressBlock(progress, nil);
        
    }];
}

// download data
+ (void)downloadData:(NSString *)filename progress:(CitrusTouchProgressBlock)progressBlock complete:(CitrusTouchProgressBlock)completeBlock;
{
    // client
    DropboxClient *client = [DropboxClientsManager authorizedClient];
    
    // name
    filename = [NSString stringWithFormat:@"/%@", filename];
    
    [[[[client filesRoutes] downloadData:filename] response:^(DBFILESFileMetadata *result, DBFILESDownloadError *routeError, DBError *error, NSData *fileContents) {
        
        CTProgress *progress = [[CTProgress alloc] initWithResultData:fileContents];
        
        completeBlock(progress, nil);
        
    }] progress:^(int64_t bytesDownloaded, int64_t totalBytesDownloaded, int64_t totalBytesExpectedToDownload) {
        
        CTProgress *progress = [[CTProgress alloc] initWithProgressing:@(bytesDownloaded) total:@(totalBytesDownloaded)];
        
        progressBlock(progress, nil);
    }];
}

// delete data
+ (void)deleteData:(NSString *)filename progress:(CitrusTouchProgressBlock)progressBlock complete:(CitrusTouchProgressBlock)completeBlock
{
    // client
    DropboxClient *client = [DropboxClientsManager authorizedClient];
    
    // name
    filename = [NSString stringWithFormat:@"/%@", filename];
    
    [[[[client filesRoutes] delete_:filename] response:^(DBFILESMetadata *result, DBFILESDeleteError *routeError, DBError *error) {
        
        CTProgress *progress = [[CTProgress alloc] initWithComplete];
        
        completeBlock(progress, nil);
        
    }] progress:^(int64_t bytesSent, int64_t totalBytesSent, int64_t totalBytesExpectedToSend) {
        
        CTProgress *progress = [[CTProgress alloc] initWithProgressing:@(bytesSent) total:@(totalBytesSent)];
        
        progressBlock(progress, nil);
    }];
}

// put data
+ (void)putData:(NSData *)datafile filename:(NSString *)filename progress:(CitrusTouchProgressBlock)progressBlock complete:(CitrusTouchProgressBlock)completeBlock
{
    [self deleteData:filename progress:^(CTProgress *progress, NSError *error) {
        
    } complete:^(CTProgress *progress, NSError *error) {
        
        [self uploadData:datafile filename:filename progress:^(CTProgress *progress, NSError *error) {
            
            completeBlock(progress, nil);
            
        } complete:^(CTProgress *progress, NSError *error) {
            
            progressBlock(progress, nil);
            
        }];
        
    }];
}

@end
