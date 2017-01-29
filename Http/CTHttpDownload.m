//
//  CTHttp.m
//  CitrusTouch
//
//  Created by take64 on 2012/10/04.
//  Copyright (c) 2012年 citrus.tk. All rights reserved.
//

#import "CTHttpDownload.h"

@implementation CTHttpDownload

//
// synthesize
//
@synthesize _urlRequest;
@synthesize _downloadDatas;
@synthesize _connections;
@synthesize _contentLengths;
@synthesize _callbackTarget;
@synthesize _callbackSelector;

// 初期化
- (id)init
{
    self = [super init];
    if(self)
    {
        // コネクションリスト
        [self set_connections:[NSMutableArray arrayWithCapacity:1]];
        
        // ダウンロードリスト
        [self set_downloadDatas:[NSMutableDictionary dictionaryWithCapacity:1]];
        
        // コンテンツサイズリスト
        [self set_contentLengths:[NSMutableDictionary dictionaryWithCapacity:1]];
    }
    return self;
}




#pragma mark -
#pragma mark NSURLConnectionDelegate method
//
// NSURLConnectionDelegate method
//
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    CTLog(@"- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error");
    CTLog(@"%@", error);
}
//- (BOOL)connectionShouldUseCredentialStorage:(NSURLConnection *)connection;
- (void)connection:(NSURLConnection *)connection willSendRequestForAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    CTLog(@"- (void)connection:(NSURLConnection *)connection willSendRequestForAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge");
    NSURLCredential* creds = [NSURLCredential credentialWithUser:@"take64" password:@"tori151714" persistence:NSURLCredentialPersistencePermanent];
    [[challenge sender] useCredential:creds forAuthenticationChallenge:challenge];
}
//- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace;
- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    CTLog(@"- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge");
}
- (void)connection:(NSURLConnection *)connection didCancelAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    CTLog(@"- (void)connection:(NSURLConnection *)connection didCancelAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge");
}


#pragma mark -
#pragma mark NSURLConnectionDataDelegate method
//
// NSURLConnectionDataDelegate method
//
//- (NSURLRequest *)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)response
//{
//    CTLog(@"- (NSURLRequest *)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)response");
//}
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    CTLog(@"- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response length:%qi", [response expectedContentLength]);
    
    // コンテンツサイズ設定
    [[self _contentLengths] setObject:[NSNumber numberWithLongLong:[response expectedContentLength]] forKey:[self callIndexFromConnection:connection]];
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    CTLog(@"- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data");
    
    // 保存
    NSNumber *index = [self callIndexFromConnection:connection];
    [[[self _downloadDatas] objectForKey:index] appendData:data];
    
    // ダウンロードサイズ
    NSUInteger downloadedLength = [(NSData *)[[self _downloadDatas] objectForKey:index] length];
    
    long long completeLength = [(NSNumber *)[[self _contentLengths] objectForKey:index] longLongValue];
    CTLog(@"%d%%", (int)(((float)downloadedLength / completeLength) * 100));
    
}
//- (NSInputStream *)connection:(NSURLConnection *)connection needNewBodyStream:(NSURLRequest *)request
//{
//    CTLog(@"- (NSInputStream *)connection:(NSURLConnection *)connection needNewBodyStream:(NSURLRequest *)request");
//}
- (void)connection:(NSURLConnection *)connection didSendBodyData:(NSInteger)bytesWritten totalBytesWritten:(NSInteger)totalBytesWritten totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite
{
    CTLog(@"- (void)connection:(NSURLConnection *)connection didSendBodyData:(NSInteger)bytesWritten totalBytesWritten:(NSInteger)totalBytesWritten totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite");
}
//- (NSCachedURLResponse *)connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse *)cachedResponse
//{
//    CTLog(@"- (NSCachedURLResponse *)connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse *)cachedResponse");
//}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    CTLog(@"- (void)connectionDidFinishLoading:(NSURLConnection *)connection");
    if([self _callbackTarget] != nil && [self _callbackSelector] != nil)
    {
        if([[self _callbackTarget] respondsToSelector:[self _callbackSelector]] == YES)
        {
            NSData *data = [[self _downloadDatas] objectForKey:[self callIndexFromConnection:connection]];
            
            [[self _callbackTarget] performSelector:[self _callbackSelector] withObject:data];
        }
    }
}




#pragma mark -
#pragma mark method
//
// method
//

// GETリクエスト
- (void)getWithURL:(NSURL *)url
{
    [self set_urlRequest:[NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0f]];
    
    // コネクション
    NSURLConnection *connection = [NSURLConnection connectionWithRequest:[self _urlRequest] delegate:self];
    [connection start];
    
    // コネクションの設定
    [[self _connections] addObject:connection];
    
    // ダウンロード
    [[self _downloadDatas] setObject:[NSMutableData dataWithCapacity:1] forKey:[self callIndexFromConnection:connection]];
}

// インデックス取得
- (NSNumber *)callIndexFromConnection:(NSURLConnection *)connection
{
    return [NSNumber numberWithLong:[[self _connections] indexOfObject:connection]];
}


@end

