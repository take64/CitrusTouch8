//
//  CTWebViewModal.h
//  CitrusTouch
//
//  Created by TAKEMOTO KOUHEI on 2012/12/24.
//  Copyright (c) 2012年 citrus.tk. All rights reserved.
//

#import "CTModal.h"

@interface CTWebViewModal : CTModal <UIWebViewDelegate>
{
    // ビュー
    UIViewController *_viewController;
    
    // WebView
    UIWebView *_webView;
    
    // リクエスト
    NSMutableURLRequest *_request;
}



//
// property
//
@property (nonatomic, retain) UIViewController *_viewController;
@property (nonatomic, retain) UIWebView *_webView;
@property (nonatomic, retain) NSMutableURLRequest *_request;



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
