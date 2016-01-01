//
//  CTAdMobService.h
//  CitrusTouch
//
//  Created by TAKEMOTO KOUHEI on 2013/01/31.
//  Copyright (c) 2013年 BESIDES+. All rights reserved.
//

#import <Foundation/Foundation.h>

//@import GoogleMobileAds;
#import <GoogleMobileAds/GoogleMobileAds.h>

@interface CTAdMobService : NSObject
{
    // 広告ID
    NSString *adUnitID;
    
    // 広告リスト
    NSMutableDictionary *bannerList;
}

//
// property
//
@property (nonatomic, retain) NSString *adUnitID;
@property (nonatomic, retain) NSMutableDictionary *bannerList;



//
// method
//

// 初期化
- (id) initWithAdUnitID:(NSString *)adUnitIDValue;

// バナー広告生成
- (GADBannerView *) addBannerID:(NSString *)bannerID size:(CGSize)bannerSize rootController:(UIViewController *)rootController;

// バナー広告取得
- (GADBannerView *) callBannerID:(NSString *)bannerID;


@end
