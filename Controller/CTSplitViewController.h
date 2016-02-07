//
//  CTSplitViewController.h
//  CitrusTouch
//
//  Created by take64 on 2012/10/10.
//  Copyright (c) 2012年 citrus.tk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@class CTColor;

@interface CTSplitViewController : UIViewController
{
    // メニュービュー
    UIViewController *_menuViewController;
    
    // メインビュー
    UIViewController *_mainViewController;
    
    // メニュービュー
    UINavigationController *_menuNavigationController;
    
    // メインビュー
    UINavigationController *_mainNavigationController;
    
    // メイン表示
    BOOL _mainVisible;
    
    // スライドボタン
    UIBarButtonItem *_barButtonSlide;
    
    UIView *caption;
    
    // メニュー表示時のバナー
    UIView *_menuBannerView;
    
}

//
// property
//
@property (nonatomic, retain) UIViewController *_menuViewController;
@property (nonatomic, retain) UIViewController *_mainViewController;
@property (nonatomic, retain) UINavigationController *_menuNavigationController;
@property (nonatomic, retain) UINavigationController *_mainNavigationController;
@property (nonatomic) BOOL _mainVisible;
@property (nonatomic, retain) UIBarButtonItem *_barButtonSlide;
@property (nonatomic, retain) UIView *caption;
@property (nonatomic, retain) UIView *_menuBannerView;


//
// method
//

// 初期化
- (id) initWithMainViewController:(UIViewController *)mainViewController menuViewController:(UIViewController *)menuViewController;

// スライド処理
- (void)slideMenu;

// スライドを開ける
- (void) openSlide;

// スライドを閉じる
- (void) closeSlide;

// メインビュー変更
- (void)changeMainViewController:(UIViewController *)mainViewController;

// tintColor設定
- (void) setTintColor:(CTColor *)colorValue;

//- (void) toggleMasterView;
//
//- (void) changeDetailView:(UIViewController*) mainViewController;

@end
