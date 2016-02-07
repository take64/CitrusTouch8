//
//  CTDropboxCoreApi.m
//  CitrusTouch
//
//  Created by take64 on 2013/12/22.
//  Copyright (c) 2013年 citrus.tk. All rights reserved.
//

#import "CTDropboxCoreApi.h"

@implementation CTDropboxCoreApi

//
// synthesize
//
@synthesize restClient;
@synthesize progressBlock;
@synthesize completeBlock;
@synthesize deleteBlock;
@synthesize searchSuccessBlock;
@synthesize searchFailureBlock;


// 初期化
- (id)init
{
    self = [super init];
    if(self)
    {
        [self setRestClient:[[DBRestClient alloc] initWithSession:[DBSession sharedSession]]];
        [[self restClient] setDelegate:self];
    }
    return self;
}

// データ受信
- (void)recvDataWithName:(NSString *)filename directory:(NSString *)directory progress:(CitrusTouchCompleteBlock)progress complete:(CitrusTouchCompleteBlock)complete
{
    // コールバック
    [self setProgressBlock:progress];
    [self setCompleteBlock:complete];
    
    // 一旦ファイル保存
    NSString *localDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *localPath = [localDir stringByAppendingPathComponent:filename];
    NSString *filepath = [NSString stringWithFormat:@"%@%@", directory, filename];
    
//    [[self restClient] loadFile:[NSString stringWithFormat:@"%@%@", directory, filename] intoPath:localPath];
    
    // ファイル受信
    CTDropboxCoreApi *coreApi1 = self;
    [self setSearchSuccessBlock:^{
        
        [[coreApi1 restClient] loadFile:filepath intoPath:localPath];
    }];
    [self setSearchFailureBlock:^{
        if(self.completeBlock != nil)
        {
            coreApi1.completeBlock(nil, nil);
        }
    }];
    [[self restClient] searchPath:directory forKeyword:filename];
    
}

// データ送信
- (void)sendData:(NSData *)dataValue filename:(NSString *)filename directory:(NSString *)directory progress:(CitrusTouchCompleteBlock)progress complete:(CitrusTouchCompleteBlock)complete
{
    // コールバック
    [self setProgressBlock:progress];
    [self setCompleteBlock:complete];
    
    // 一旦ファイル保存
    NSString *localDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *localPath = [localDir stringByAppendingPathComponent:filename];
//    NSString *filepath = [NSString stringWithFormat:@"%@%@", directory, filename];
    [dataValue writeToFile:localPath atomically:YES];
    
    // ファイル送信
    CTDropboxCoreApi *coreApi1 = self;
    CTDropboxCoreApi *coreApi2 = self;
    [self setSearchSuccessBlock:^{
    
        [coreApi1 setDeleteBlock:^{
            
            [[coreApi2 restClient] uploadFile:filename toPath:directory withParentRev:nil fromPath:localPath];
        }];
        [[coreApi1 restClient] deletePath:filename];
    }];
    [self setSearchFailureBlock:^{
    
        [[coreApi1 restClient] uploadFile:filename toPath:directory withParentRev:nil fromPath:localPath];
    }];
    [[self restClient] searchPath:directory forKeyword:filename];
//    [[self restClient] deletePath:filename];
//    sleep(1);
//    [[self restClient] uploadFile:filename toPath:directory withParentRev:nil fromPath:localPath];
}


#pragma mark - DBRestClientDelegate
//
// DBRestClientDelegate
//

//- (void)restClient:(DBRestClient*)client loadedMetadata:(DBMetadata*)metadata;
//- (void)restClient:(DBRestClient*)client metadataUnchangedAtPath:(NSString*)path;
//- (void)restClient:(DBRestClient*)client loadMetadataFailedWithError:(NSError*)error;
//// [error userInfo] contains the root and path of the call that failed
//
//- (void)restClient:(DBRestClient*)client loadedDeltaEntries:(NSArray *)entries reset:(BOOL)shouldReset cursor:(NSString *)cursor hasMore:(BOOL)hasMore;
//- (void)restClient:(DBRestClient*)client loadDeltaFailedWithError:(NSError *)error;
//
//- (void)restClient:(DBRestClient*)client loadedAccountInfo:(DBAccountInfo*)info;
//- (void)restClient:(DBRestClient*)client loadAccountInfoFailedWithError:(NSError*)error;
//
//- (void)restClient:(DBRestClient*)client loadedFile:(NSString*)destPath;
//// Implement the following callback instead of the previous if you care about the value of the
//// Content-Type HTTP header and the file metadata. Only one will be called per successful response.
- (void)restClient:(DBRestClient*)client loadedFile:(NSString*)destPath contentType:(NSString*)contentType metadata:(DBMetadata*)metadata
{
    if(self.completeBlock != nil)
    {
        NSData *dataValue = [NSData dataWithContentsOfFile:destPath];
        
        self.completeBlock(dataValue, nil);
    }
}
- (void)restClient:(DBRestClient*)client loadProgress:(CGFloat)progress forFile:(NSString*)destPath
{
    NSLog(@"loadProgress : %@ : %f", destPath, progress);
    if(self.progressBlock != nil)
    {
        self.progressBlock(@{@"progress":@(progress)}, nil);
    }
}

//- (void)restClient:(DBRestClient*)client loadFileFailedWithError:(NSError*)error;
//// [error userInfo] contains the destinationPath
//
//
//- (void)restClient:(DBRestClient*)client loadedThumbnail:(NSString*)destPath metadata:(DBMetadata*)metadata;
//- (void)restClient:(DBRestClient*)client loadThumbnailFailedWithError:(NSError*)error;
//
- (void)restClient:(DBRestClient*)client uploadedFile:(NSString*)destPath from:(NSString*)srcPath
          metadata:(DBMetadata*)metadata
{
    if(self.completeBlock != nil)
    {
        self.completeBlock(metadata, nil);
    }
}
- (void)restClient:(DBRestClient*)client uploadProgress:(CGFloat)progress
           forFile:(NSString*)destPath from:(NSString*)srcPath
{
    NSLog(@"uploadProgress : %@ : %f", destPath, progress);
    if(self.progressBlock != nil)
    {
        self.progressBlock(@{@"progress":@(progress)}, nil);
    }
}
- (void)restClient:(DBRestClient*)client uploadFileFailedWithError:(NSError*)error
{
    if(self.completeBlock != nil)
    {
        self.completeBlock(nil, error);
    }
}
//// [error userInfo] contains the sourcePath
//
//- (void)restClient:(DBRestClient *)client uploadedFileChunk:(NSString *)uploadId newOffset:(unsigned long long)offset
//          fromFile:(NSString *)localPath expires:(NSDate *)expiresDate;
//- (void)restClient:(DBRestClient *)client uploadFileChunkFailedWithError:(NSError *)error;
//- (void)restClient:(DBRestClient *)client uploadFileChunkProgress:(CGFloat)progress
//           forFile:(NSString *)uploadId offset:(unsigned long long)offset fromPath:(NSString *)localPath;
//
//- (void)restClient:(DBRestClient *)client uploadedFile:(NSString *)destPath fromUploadId:(NSString *)uploadId
//          metadata:(DBMetadata *)metadata;
//- (void)restClient:(DBRestClient *)client uploadFromUploadIdFailedWithError:(NSError *)error;
//
//// Deprecated upload callback
//- (void)restClient:(DBRestClient*)client uploadedFile:(NSString*)destPath from:(NSString*)srcPath;
//
//// Deprecated download callbacks
//- (void)restClient:(DBRestClient*)client loadedFile:(NSString*)destPath contentType:(NSString*)contentType;
//- (void)restClient:(DBRestClient*)client loadedThumbnail:(NSString*)destPath;
//
//- (void)restClient:(DBRestClient*)client loadedRevisions:(NSArray *)revisions forFile:(NSString *)path;
//- (void)restClient:(DBRestClient*)client loadRevisionsFailedWithError:(NSError *)error;
//
//- (void)restClient:(DBRestClient*)client restoredFile:(DBMetadata *)fileMetadata;
//- (void)restClient:(DBRestClient*)client restoreFileFailedWithError:(NSError *)error;
//
//- (void)restClient:(DBRestClient*)client createdFolder:(DBMetadata*)folder;
//// Folder is the metadata for the newly created folder
//- (void)restClient:(DBRestClient*)client createFolderFailedWithError:(NSError*)error;
//// [error userInfo] contains the root and path
//
- (void)restClient:(DBRestClient*)client deletedPath:(NSString *)path
{
    if(self.deleteBlock != nil)
    {
        self.deleteBlock();
    }
}
- (void)restClient:(DBRestClient*)client deletePathFailedWithError:(NSError*)error
{
    if(self.deleteBlock != nil)
    {
        self.deleteBlock();
    }
}
//// [error userInfo] contains the root and path
//
//- (void)restClient:(DBRestClient*)client copiedPath:(NSString *)fromPath to:(DBMetadata *)to;
//- (void)restClient:(DBRestClient*)client copyPathFailedWithError:(NSError*)error;
//// [error userInfo] contains the root and path
//
//- (void)restClient:(DBRestClient*)client createdCopyRef:(NSString *)copyRef forPath:(NSString *)path;
//- (void)restClient:(DBRestClient*)client createCopyRefFailedWithError:(NSError *)error;
//
//// Deprecated copy ref callback
//- (void)restClient:(DBRestClient*)client createdCopyRef:(NSString *)copyRef;
//
//- (void)restClient:(DBRestClient*)client copiedRef:(NSString *)copyRef to:(DBMetadata *)to;
//- (void)restClient:(DBRestClient*)client copyFromRefFailedWithError:(NSError*)error;
//
//- (void)restClient:(DBRestClient*)client movedPath:(NSString *)from_path to:(DBMetadata *)result;
//- (void)restClient:(DBRestClient*)client movePathFailedWithError:(NSError*)error;
//// [error userInfo] contains the root and path
//
- (void)restClient:(DBRestClient*)restClient loadedSearchResults:(NSArray*)results forPath:(NSString*)path keyword:(NSString*)keyword
{
    if([results count] > 0)
    {
        if(self.searchSuccessBlock != nil)
        {
            self.searchSuccessBlock();
        }
    }
    else
    {
        if(self.searchFailureBlock != nil)
        {
            self.searchFailureBlock();
        }
    }
}
- (void)restClient:(DBRestClient*)restClient searchFailedWithError:(NSError*)error
{
    if(self.searchFailureBlock != nil)
    {
        self.searchFailureBlock();
    }
}
//
//- (void)restClient:(DBRestClient*)restClient loadedSharableLink:(NSString*)link
//           forFile:(NSString*)path;
//- (void)restClient:(DBRestClient*)restClient loadSharableLinkFailedWithError:(NSError*)error;
//
//- (void)restClient:(DBRestClient*)restClient loadedStreamableURL:(NSURL*)url forFile:(NSString*)path;
//- (void)restClient:(DBRestClient*)restClient loadStreamableURLFailedWithError:(NSError*)error;


#pragma mark - singleton
//
// singleton
//

// singleton
+ (CTDropboxCoreApi *)sharedService
{
    static CTDropboxCoreApi *singleton;
    if(singleton == nil)
    {
        singleton = [[CTDropboxCoreApi alloc] init];
    }
    return singleton;
}

@end
