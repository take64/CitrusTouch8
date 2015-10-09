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


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark UIWebViewDelegate
//
// UIWebViewDelegate
//

//- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType;
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}
//- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error;


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
//        [self set_webView:[[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 320, 416)]];
        [self set_webView:[[UIWebView alloc] initWithFrame:[[self view] bounds]]];
        [[self _webView] setDelegate:self];
        [[[self _viewController] view] addSubview:[self _webView]];
        
        // ナヴィゲーション無し
        [self setNavigationBarHidden:YES];
        
        // スペーサー
        UIBarButtonItem *buttonSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        
        // 閉じるボタン
        UIBarButtonItem *buttonClose = [[UIBarButtonItem alloc] initWithTitle:@"閉じる" style:UIBarButtonItemStylePlain target:self action:@selector(hide)];
        [buttonClose setTintColor:[UIColor whiteColor]];
        [[self _viewController] setToolbarItems:@[ buttonSpacer, buttonClose ]];
        [self setToolbarHidden:NO];
    }
    return self;
}
// 非表示
- (void) hide
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    [super hide];
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
