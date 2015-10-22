//
//  CTWebViewModal.h
//  CitrusTouch
//
//  Created by TAKEMOTO KOUHEI on 2012/12/24.
//  Copyright (c) 2012年 citrus.tk. All rights reserved.
//

#import <WebKit/WebKit.h>

#import "CTModal.h"

@interface CTWebViewModal : CTModal <WKNavigationDelegate>
{
    // ビュー
    UIViewController *_viewController;
    
    // WebView
    WKWebView *_webView;
    
    // リクエスト
    NSMutableURLRequest *_request;
    
    // インジケーター
    UIProgressView *_progressView;
}



//
// property
//
@property (nonatomic, retain) UIViewController *_viewController;
@property (nonatomic, retain) WKWebView *_webView;
@property (nonatomic, retain) NSMutableURLRequest *_request;
@property (nonatomic, retain) UIProgressView *_progressView;



//
// method
//

// 初期化
- (id) initWithParentController:(UIViewController *)parentController;


//
// singleton
//
// リクエスト取得
- (NSMutableURLRequest *) callRequest;

@end
