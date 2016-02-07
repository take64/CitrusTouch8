//
//  CTHttpDownload.h
//  CitrusTouch
//
//  Created by take64 on 2012/10/04.
//  Copyright (c) 2012年 citrus.tk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTHttpDownload : NSObject <NSURLConnectionDelegate, NSURLConnectionDataDelegate>
{
    // リクエスト
    NSMutableURLRequest *_urlRequest;
    
    // ダウンロードデータ
    NSMutableDictionary *_downloadDatas;
    
    // コネクションリスト
    NSMutableArray *_connections;
    
    // コンテンツサイズリスト
    NSMutableDictionary *_contentLengths;
    
    // コールバック
    id _callbackTarget;
    SEL _callbackSelector;
}

//
// property
//
@property (nonatomic, retain) NSMutableURLRequest *_urlRequest;
@property (nonatomic, retain) NSMutableDictionary *_downloadDatas;
@property (nonatomic, retain) NSMutableArray *_connections;
@property (nonatomic, retain) NSMutableDictionary *_contentLengths;
@property (nonatomic, retain) id _callbackTarget;
@property (nonatomic) SEL _callbackSelector;


// GETでダウンロード処理
- (void)getWithURL:(NSURL *)url;

// インデックス取得
- (NSNumber *)callIndexFromConnection:(NSURLConnection *)connection;

@end
