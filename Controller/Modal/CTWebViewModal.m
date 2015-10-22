//
//  CTWebViewModal.m
//  CitrusTouch
//
//  Created by TAKEMOTO KOUHEI on 2012/12/24.
//  Copyright (c) 2012年 citrus.tk. All rights reserved.
//

#import "CTWebViewModal.h"

@interface CTWebViewModal ()

@end

@implementation CTWebViewModal

//
// synthesize
//
@synthesize _viewController;
@synthesize _webView;
@synthesize _request;
@synthesize _progressView;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

#pragma mark -
#pragma mark method
//
// method
//

// 初期化
- (id) initWithParentController:(UIViewController *)parentController
{
    // 編集テーブルビュー
    [self set_viewController:[[UIViewController alloc] initWithNibName:nil bundle:nil]];
    
    self = [super initWithRootViewController:[self _viewController]];
    if(self)
    {
        // 親コントローラー
        [self set_parentController:parentController];
        
        // エイリアス
        [self set_webView:[[WKWebView alloc] initWithFrame:[[self view] bounds]]];
        [[self _webView] setNavigationDelegate:self];
        [[[self _viewController] view] addSubview:[self _webView]];
        
        // インジケーター
        [self set_progressView:[[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleBar]];
        [[self _progressView] setFrame:CGRectMake(0, [[self navigationBar] frame].size.height - 2.5, [[self navigationBar] frame].size.width, 2.5)];
        [[self navigationBar] addSubview:[self _progressView]];
        
        // ナヴィゲーション表示
        [self setNavigationBarHidden:NO];
        
        // ツールバー非表示
        [self setToolbarHidden:YES];
        
        // ボタン閉じる
        UIBarButtonItem *closeButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(hide)];
        [[[self _viewController] navigationItem] setRightBarButtonItem:closeButton];
        
        // observe
        [[self _webView] addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
        [[self _webView] addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}
- (void)dealloc
{
    [[self _webView] removeObserver:self forKeyPath:@"estimatedProgress"];
    [[self _webView] removeObserver:self forKeyPath:@"title"];
}
// 非表示
- (void) hide
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    [super hide];
}


#pragma mark - WKNavigationDelegate
//
// WKNavigationDelegate
//

//- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler;
//- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler;
//- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation;
//- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation;
//- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error;
//- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation;
//- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation;
//- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error;
//- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential *__nullable credential))completionHandler;
//- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView NS_AVAILABLE(10_11, 9_0);


//
// observe
//
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if([keyPath isEqualToString:@"estimatedProgress"] == YES)
    {
        double progress = [[self _webView] estimatedProgress];
        NSLog(@"%f", progress);
        if(progress > 0)
        {
            [[self _progressView] setProgress:progress animated:YES];
            
            [[self navigationBar] addSubview:[self _progressView]];
            
            if(progress == 1)
            {
                [[self _progressView] removeFromSuperview];
            }
        }
    }
    else if ([keyPath isEqualToString:@"title"] == YES)
    {
        [[self _viewController] setTitle:[[self _webView] title]];
    }
}



#pragma mark -
#pragma mark singleton
//
// singleton
//
// リクエスト取得
- (NSMutableURLRequest *) callRequest
{
    if([self _request] == nil)
    {
        [self set_request:[[NSMutableURLRequest alloc] init]];
    }
    return [self _request];
}

@end
