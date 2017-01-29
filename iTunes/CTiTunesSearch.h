//
//  CTiTunesSearch.h
//  ChinottoPod
//
//  Created by kouhei.takemoto on 2016/08/11.
//  Copyright © 2016年 citrus.live. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CTiTunesSearchResult;

typedef void (^CitrusTouchiTunesSearchBlock)(NSArray<CTiTunesSearchResult *> *results, NSError *error);

static NSString *CTiTunesSearchURL = @"https://itunes.apple.com/search";
static NSString *CTiTunesLookupURL = @"https://itunes.apple.com/lookup";

@interface CTiTunesSearch : NSObject

// 音楽検索
+ (void)searchMusicWithKeyword:(NSString *)keywordString complete:(CitrusTouchiTunesSearchBlock)complete;

//// PV検索
//+ (void)searchVideoWithKeyword:(NSString *)keywordString complete:(CitrusTouchiTunesSearchBlock)complete;

// 楽曲IDから楽曲取得
+ (void)lookupMusicWithTrackID:(NSString *)idString complete:(CitrusTouchiTunesSearchBlock)complete;

// アーティストIDから楽曲取得
+ (void)lookupMusicWithArtistID:(NSString *)idString complete:(CitrusTouchiTunesSearchBlock)complete;

// アーティストIDからアーティスト取得
+ (void)lookupArtistWithArtistID:(NSString *)idString complete:(CitrusTouchiTunesSearchBlock)complete;

@end
