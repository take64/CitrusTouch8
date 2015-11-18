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
@synthesize progressView;
@synthesize prevButton;
@synthesize nextButton;
@synthesize reloadButton;


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
        
        // インジケーター
        [self setProgressView:[[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleBar]];
        [[self progressView] setFrame:CGRectMake(0, [[self navigationBar] frame].size.height - 2.5, [[self navigationBar] frame].size.width, 2.5)];
        [[self navigationBar] addSubview:[self progressView]];
        
        // ナヴィゲーション表示
        [self setNavigationBarHidden:NO];
        
        // ツールバー非表示
        [self setToolbarHidden:NO];
        
        // ボタン
        UIBarButtonItem *button;
        NSMutableArray *toolbarItems = [NSMutableArray array];
        
        // ボタン(閉じる)
        button = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(hide)];
        [[[self _viewController] navigationItem] setRightBarButtonItem:button];
        
        // ボタン(戻る)
        button = [[UIBarButtonItem alloc] initWithTitle:@"◀︎" style:UIBarButtonItemStylePlain target:self action:@selector(onTapBarButtonPrev)];
        [self setPrevButton:button];
        [toolbarItems addObject:button];
        
        // ボタン(進む)
        button = [[UIBarButtonItem alloc] initWithTitle:@"▶︎" style:UIBarButtonItemStylePlain target:self action:@selector(onTapBarButtonNext)];
        [self setNextButton:button];
        [toolbarItems addObject:button];
        
        // ボタン(再読み込み)
        button = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(onTapBarButtonReload)];
        [self setReloadButton:button];
        [toolbarItems addObject:button];
        
        [[self _viewController] setToolbarItems:toolbarItems];
        
        
        
        
    }
    return self;
}
- (void)dealloc
{
    [[self callWebView] removeObserver:self forKeyPath:@"estimatedProgress"];
    [[self callWebView] removeObserver:self forKeyPath:@"title"];
    [[self callWebView] removeObserver:self forKeyPath:@"canGoBack"];
    [[self callWebView] removeObserver:self forKeyPath:@"canGoForward"];
    [[self callWebView] removeObserver:self forKeyPath:@"loading"];
}
// 非表示
- (void) hide
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    [super hide];
}

// URL読み込み
- (void)loadURL:(NSString *)urlString
{
    [[self callRequest] setURL:[NSURL URLWithString:urlString]];
    [[self callWebViewWithRefresh:@YES] loadRequest:[self callRequest]];
}

// ボタン押下時(戻る)
- (void)onTapBarButtonPrev
{
    [CTSound playButtonSound];
    
    [[self callWebView] goBack];
}
// ボタン押下時(進む)
- (void)onTapBarButtonNext
{
    [CTSound playButtonSound];
    
    [[self callWebView] goForward];
}
// ボタン押下時(再読み込み)
- (void)onTapBarButtonReload
{
    [CTSound playButtonSound];
    
    [[self callWebView] reload];
}


#pragma mark - WKNavigationDelegate
//
// WKNavigationDelegate
//

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    WKFrameInfo *targetFrame = navigationAction.targetFrame;
    
    switch (navigationAction.navigationType) {
        case WKNavigationTypeLinkActivated: {
            NSLog(@"WKNavigationTypeLinkActivated::");
            // <a href="..." target="_blank"> が押されたとき
            if (targetFrame == nil)
            {
                [[self callRequest] setURL:[[navigationAction request] URL]];
                [[self callWebView] loadRequest:[self callRequest]];
            }
            break;
        }
        case WKNavigationTypeFormSubmitted: {
            NSLog(@"WKNavigationTypeFormSubmitted::");
            
            break;
        }
        case WKNavigationTypeBackForward: {
            NSLog(@"WKNavigationTypeBackForward::");
            
            break;
        }
        case WKNavigationTypeReload: {
            NSLog(@"WKNavigationTypeReload::");
            
            break;
        }
        case WKNavigationTypeFormResubmitted: {
            NSLog(@"WKNavigationTypeFormResubmitted::");
            
            break;
        }
        case WKNavigationTypeOther: {
            NSLog(@"WKNavigationTypeOther::");
            
            break;
        }
        default: {
            break;
        }
    }
    
    decisionHandler(WKNavigationActionPolicyAllow);
}
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
        double progress = [[self callWebView] estimatedProgress];
        NSLog(@"%f", progress);
        if(progress > 0)
        {
            [[self progressView] setProgress:progress animated:YES];
            
            [[self navigationBar] addSubview:[self progressView]];
            
            if(progress == 1)
            {
                [[self progressView] removeFromSuperview];
            }
        }
    }
    else if ([keyPath isEqualToString:@"title"] == YES)
    {
        [[self _viewController] setTitle:[[self callWebView] title]];
    }
    else if ([keyPath isEqualToString:@"canGoBack"])
    {
        [[self prevButton] setEnabled:[[self callWebView] canGoBack]];
    }
    else if ([keyPath isEqualToString:@"canGoForward"])
    {
        [[self nextButton] setEnabled:[[self callWebView] canGoForward]];
    }
    else if ([keyPath isEqualToString:@"loading"])
    {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:[[self callWebView] isLoading]];
        [[self reloadButton] setEnabled:![[self callWebView] isLoading]];
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
// WEBVIEW取得
- (WKWebView *)callWebViewWithRefresh:(NSNumber *)refresh
{
    // リフレッシュする
    if([refresh compare:@YES] == NSOrderedSame)
    {
        if([self _webView] != nil)
        {
            [[self _webView] removeObserver:self forKeyPath:@"estimatedProgress"];
            [[self _webView] removeObserver:self forKeyPath:@"title"];
            [[self _webView] removeObserver:self forKeyPath:@"canGoBack"];
            [[self _webView] removeObserver:self forKeyPath:@"canGoForward"];
            [[self _webView] removeObserver:self forKeyPath:@"loading"];
            [[self _webView] removeFromSuperview];
        }
        [self set_webView:nil];
    }
    
    WKWebView *webView = [self callWebView];
    
    // observe
    [webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    [webView addObserver:self forKeyPath:@"canGoBack" options:NSKeyValueObservingOptionNew context:nil];
    [webView addObserver:self forKeyPath:@"canGoForward" options:NSKeyValueObservingOptionNew context:nil];
    [webView addObserver:self forKeyPath:@"loading" options:NSKeyValueObservingOptionNew context:nil];
    
    [[self prevButton] setEnabled:NO];
    [[self nextButton] setEnabled:NO];
    
    return webView;
}
// WEBVIEW取得
- (WKWebView *)callWebView
{
    if([self _webView] == nil)
    {
        [self set_webView:[[WKWebView alloc] initWithFrame:[[self view] bounds]]];
        [[self _webView] setNavigationDelegate:self];
        [[[self _viewController] view] addSubview:[self _webView]];
    }
    return [self _webView];
}


@end
