//
//  CTDrawerMenuPanel.m
//  ChinottoPod
//
//  Created by kouhei.takemoto on 2017/01/25.
//  Copyright © 2017年 citrus.live. All rights reserved.
//

#import "CTDrawerMenuPanel.h"

@implementation CTDrawerMenuPanel

//
// synthesize
//
@synthesize headView;
@synthesize headImageView;
@synthesize menuTableView;

#pragma mark - method
//
// method
//

// init
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        // パネルサイズ
        CGFloat panelWidth = CGRectGetWidth(frame);
        CGFloat panelHeight = CGRectGetHeight(frame);
        
        // ヘッダサイズ
        CGFloat headWidth = CGRectGetWidth(frame);
        CGFloat headHeight = headWidth;
        
        // 画像サイズ
        CGFloat imageWidth = 64;
        CGFloat imageHeight = imageWidth;
//        CGRect imageRect = CGRectMake((headWidth / 2) - (imageWidth / 2),
//                                      (headHeight / 2) - (imageHeight / 2),
//                                      imageWidth,
//                                      imageHeight
//                                      );
        
        // ヘッダビュー
        CTView *view;
        view = [[CTView alloc] initWithFrame:CGRectMake(0, 0, headWidth, headHeight)];
        [view setUserInteractionEnabled:YES];
        [self addSubview:view];
        [self setHeadView:view];
        
        
        // 画像
        UIImageView *imageView;
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, imageWidth, imageHeight)];
        [imageView setCenter:[view center]];
        [imageView setClipsToBounds:YES];
        [[imageView layer] setCornerRadius:8];
        [view addSubview:imageView];
        [self setHeadImageView:imageView];
        
        // テーブルビュー
        UITableView *tableView;
        tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, panelWidth, panelWidth, (panelHeight - headHeight)) style:UITableViewStylePlain];
        [self addSubview:tableView];
        [self setMenuTableView:tableView];
    }
    return self;
}

// bind
- (void)bindImage:(UIImage *)imageValue
{
    [[self headImageView] setImage:imageValue];
}

// setter head background-color
- (void)setHeadBackgroundColor:(CTColor *)colorValue
{
    [[[self headView] callStyle] addStyleKey:@"background-color" value:[CTColor hexStringWithColor:colorValue]];
}

// setter table view background-color
- (void)setTableViewBackgroundColor:(CTColor *)colorValue
{
    [[self menuTableView] setBackgroundColor:colorValue];
}

@end
