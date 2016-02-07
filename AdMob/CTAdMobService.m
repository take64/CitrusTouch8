//
//  CTAdMobService.m
//  CitrusTouch
//
//  Created by take64 on 2013/01/31.
//  Copyright (c) 2013年 BESIDES+. All rights reserved.
//

#import "CTAdMobService.h"

@implementation CTAdMobService

//
// synthesize
//
@synthesize adUnitID;
@synthesize bannerList;


#pragma mark -
#pragma mark method
//
// method
//

// 初期化
- (id) initWithAdUnitID:(NSString *)adUnitIDValue
{
    self = [super init];
    if(self)
    {
        // 広告ID
        [self setAdUnitID:adUnitIDValue];
        
        // バナーリスト
        [self setBannerList:[NSMutableDictionary dictionaryWithCapacity:1]];
    }
    return self;
}

// バナー広告生成
- (GADBannerView *) addBannerID:(NSString *)bannerID size:(CGSize)bannerSize rootController:(UIViewController *)rootController
{
    // 取得
    GADBannerView *bannerView = [bannerList objectForKey:bannerID];
    if(bannerView == nil)
    {
//        NSLog(@"bannerID = %@", bannerID);
        // 生成
        bannerView = [[GADBannerView alloc] initWithFrame:CGRectMake(0, 0, bannerSize.width, bannerSize.height)];
        [bannerView setAdUnitID:[self adUnitID]];
        [[self bannerList] setObject:bannerView forKey:bannerID];
        
        // コントローラー設定
        [bannerView setRootViewController:rootController];
    }
    return bannerView;
}

// バナー広告取得
- (GADBannerView *) callBannerID:(NSString *)bannerID
{
    return [[self bannerList] objectForKey:bannerID];
}


@end
