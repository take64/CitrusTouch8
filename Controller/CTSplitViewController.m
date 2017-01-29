//
//  CTSplitViewController.m
//  CitrusTouch
//
//  Created by take64 on 2012/10/10.
//  Copyright (c) 2012年 citrus.tk. All rights reserved.
//

#import "CTSplitViewController.h"

#define MENU_WIDTH 256

@interface CTSplitViewController ()

@end

@implementation CTSplitViewController

//
// synthesize
//
@synthesize _menuViewController;
@synthesize _mainViewController;
@synthesize _menuNavigationController;
@synthesize _mainNavigationController;
@synthesize _mainVisible;
@synthesize _barButtonSlide;
@synthesize caption;
@synthesize _menuBannerView;


// 初期化
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadView
{
    [super loadView];
    
    // ビュー
    [[self view] addSubview:[[self _menuNavigationController] view]];
    [[self view] addSubview:[[self _mainNavigationController] view]];
    
    [[[[self _mainNavigationController] view] layer] setShadowOffset:CGSizeMake(-1, -1)];
    [[[[self _mainNavigationController] view] layer] setShadowRadius:5];
    [[[[self _mainNavigationController] view] layer] setShadowOpacity:0.5];
    [[[[self _mainNavigationController] view] layer] setShadowColor:[[UIColor blackColor] CGColor]];
    [[[[self _mainNavigationController] view] layer] setShadowPath:[UIBezierPath bezierPathWithRect:[[[self _mainNavigationController] view] bounds]].CGPath];
}

#pragma mark -
#pragma mark method
//
// method
//

// 初期化
- (id) initWithMainViewController:(UIViewController *)mainViewController menuViewController:(UIViewController *)menuViewController
{
    self = [super initWithNibName:nil bundle:nil];
    if(self)
    {
        // 設定
        [self set_menuViewController:menuViewController];
        [self set_mainViewController:mainViewController];
        [self set_menuNavigationController:[[UINavigationController alloc] initWithRootViewController:menuViewController]];
        [self set_mainNavigationController:[[UINavigationController alloc] initWithRootViewController:mainViewController]];
        
        // frame計算
        CGRect menuFrame = [[self view] bounds];
        menuFrame.size.width = MENU_WIDTH;
        
        [[[self _mainNavigationController] view] setBounds: [[self view] bounds]];
        [[[self _menuNavigationController] view] setBounds: [[self view] bounds]];
        [[[self _mainNavigationController] view] setFrame:[[self view] bounds]];
        [[[self _menuNavigationController] view] setFrame:menuFrame];
        
        // メイン表示状態
        [self set_mainVisible:YES];
        
        // スライドボタン
        [self set_barButtonSlide:[[UIBarButtonItem alloc] initWithTitle:@"MENU" style:UIBarButtonItemStylePlain target:self action:@selector(slideMenu)]];
        [[[self _mainViewController] navigationItem] setLeftBarButtonItem:[self _barButtonSlide]];
        
        
        // スワイプイベント
        UISwipeGestureRecognizer *swipe;
        swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(onSwipeNavigationBar:)];
        [swipe setNumberOfTouchesRequired:1];
        [swipe setDirection:UISwipeGestureRecognizerDirectionRight];
        [[[[self _mainViewController] navigationController] navigationBar] addGestureRecognizer:swipe];
        
        swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(onSwipeNavigationBar:)];
        [swipe setNumberOfTouchesRequired:1];
        [swipe setDirection:UISwipeGestureRecognizerDirectionLeft];
        [[[[self _mainViewController] navigationController] navigationBar] addGestureRecognizer:swipe];
        
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, (320 - MENU_WIDTH), [[[self _mainViewController] view] frame].size.height)];
        [self setCaption:[[UIView alloc] initWithFrame:CGRectMake(0, 0, (320 - MENU_WIDTH), [[[self _mainViewController] view] frame].size.height)]];
        [[self caption] addSubview:label];
        [label setText:@""];
        [label setNumberOfLines:0];
        [label setLineBreakMode:NSLineBreakByCharWrapping];
    }
    return self;
}

// スライド処理
- (void)slideMenu
{
    if([self _mainVisible] == YES)
    {
        [[self _menuViewController] viewWillDisappear:YES];
    }
    else
    {
        [[self _menuViewController] viewWillAppear:YES];
    }
    
    // スライド距離計算
    CGRect frame = [[self _mainNavigationController] view].frame;
    
    if([self _mainVisible] == YES)
    {
        frame.origin.x = self.view.frame.size.width - (self.view.frame.size.width - MENU_WIDTH);
    }
    else
    {
        frame.origin.x = 0;
    }
    
    [UIView beginAnimations:@"master" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:0.2];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(slideDidAnimate:)];
    
    [[[self _mainNavigationController] view] setFrame:frame];
    
    //キャプション
    if([self _menuBannerView] != nil)
    {
        if([self _mainVisible] == YES)
        {
            [[self _menuBannerView] setUserInteractionEnabled:NO];
            [[[[self _mainNavigationController] topViewController] view] addSubview:[self _menuBannerView]];
        }
        else
        {
            [[self _menuBannerView] removeFromSuperview];
        }
    }
    
    
    [UIView commitAnimations];
    
    if([self _mainVisible] == YES)
    {
        [self set_mainVisible:NO];
    }
    else
    {
        [self set_mainVisible:YES];
    }
}

// スライドを開ける
- (void) openSlide
{
    if([self _mainVisible] == NO)
    {
        [self slideMenu];
    }
}
// スライドを閉じる
- (void) closeSlide
{
    if([self _mainVisible] == YES)
    {
        [self slideMenu];
    }
}


// メインビュー変更
- (void)changeMainViewController:(UIViewController *)mainViewController
{
    // メニュースライド
    [self slideMenu];
    
    if([[self _mainNavigationController] topViewController] != mainViewController)
    {
        [[[[self _mainNavigationController] topViewController] view] removeFromSuperview];
        [[self _mainNavigationController] setViewControllers:[NSArray arrayWithObject:mainViewController] animated:NO];
        
        // スライドボタンの移動
        [[[[self _mainNavigationController] topViewController] navigationItem] setLeftBarButtonItem:[self _barButtonSlide]];
        [self set_mainVisible:YES];
    }
}

// tintColor設定
- (void) setTintColor:(CTColor *)colorValue
{
    [[[self _mainNavigationController] navigationBar] setTintColor:colorValue];
    [[[self _menuNavigationController] navigationBar] setTintColor:colorValue];
}

#pragma mark -
#pragma mark private
//
// private
//

// スワイプ処理
- (void) onSwipeNavigationBar:(UISwipeGestureRecognizer*) swipe
{
    UISwipeGestureRecognizerDirection direction = [swipe direction];
    
    switch (direction)
    {
        case UISwipeGestureRecognizerDirectionLeft:
            if([self _mainVisible] == NO)
            {
                [self slideMenu];
            }
            break;
            
        case UISwipeGestureRecognizerDirectionRight:
            if([self _mainVisible] == YES)
            {
                [self slideMenu];
            }
            break;
            
        default:
            break;
    }
}

// スライド後処理
- (void)slideDidAnimate:(id)sender
{
    if([self _mainVisible] == YES)
    {
        [[self _menuViewController] viewDidAppear:YES];
    }
    else
    {
        [[self _menuViewController] viewDidDisappear:YES];
    }
}

@end
