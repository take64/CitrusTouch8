//
//  CTTabPanel.h
//  SocialGameTimer
//
//  Created by take64 on 2013/03/23.
//  Copyright (c) 2013年 citrus.tk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CTTabPanel : UIView
{
    // タブボタン
    NSMutableArray *tabButtons;
    
    // タブビュー
    NSMutableArray *tabPanes;
    
    // タブ上のビュー
    NSMutableArray *tabViews;
    
    // タブ色
    NSMutableArray *tabColorStrings;
    
    // スクロールペーン
    UIScrollView *scrollPane;
    
    // タブボタン高さ
    CGFloat tabButtonHeight;
}

//
// property
//
@property (nonatomic, retain) NSMutableArray *tabButtons;
@property (nonatomic, retain) NSMutableArray *tabPanes;
@property (nonatomic, retain) NSMutableArray *tabViews;
@property (nonatomic, retain) NSMutableArray *tabColorStrings;
@property (nonatomic, retain) UIScrollView *scrollPane;
@property (nonatomic, assign) CGFloat tabButtonHeight;


//
// method
//

// タブ追加
- (void) addWithTitle:(NSString *)title tabView:(UIView *)tabView colorString:(NSString *)colorString;

@end
