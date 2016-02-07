//
//  CTWebViewModal.h
//  CitrusTouch
//
//  Created by take64 on 2012/12/24.
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
    UIProgressView *progressView;
    
    // ボタン
    UIBarButtonItem *prevButton;
    UIBarButtonItem *nextButton;
    UIBarButtonItem *reloadButton;
}



//
// property
//
@property (nonatomic, retain) UIViewController *_viewController;
@property (nonatomic, retain) WKWebView *_webView;
@property (nonatomic, retain) NSMutableURLRequest *_request;
@property (nonatomic, retain) UIProgressView *progressView;
@property (nonatomic, retain) UIBarButtonItem *prevButton;
@property (nonatomic, retain) UIBarButtonItem *nextButton;
@property (nonatomic, retain) UIBarButtonItem *reloadButton;



//
// method
//

// 初期化
- (id) initWithParentController:(UIViewController *)parentController;

// URL読み込み
- (void)loadURL:(NSString *)urlString;

//
// singleton
//
//// リクエスト取得
//- (NSMutableURLRequest *) callRequest;

@end
