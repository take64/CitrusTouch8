//
//  CTiTunesSearch.m
//  ChinottoPod
//
//  Created by kouhei.takemoto on 2016/08/11.
//  Copyright © 2016年 citrus.live. All rights reserved.
//

#import "CTiTunesSearch.h"

@implementation CTiTunesSearch

// 音楽検索
+ (void)searchMusicWithKeyword:(NSString *)keywordString complete:(CitrusTouchiTunesSearchBlock)complete
{
    [CTHttpRequest getRequest:CTiTunesSearchURL parameters:@{ @"term":keywordString, @"country":@"JP", @"lang":@"ja_jp", @"limit":@"200", @"media":@"music" } complete:^(id userInfo, NSError *error) {
        NSDictionary *list = [NSJSONSerialization JSONObjectWithData:userInfo options:NSJSONReadingMutableLeaves error:nil];
        NSMutableArray *results = [NSMutableArray array];
        for(NSDictionary *one in list[@"results"])
        {
            [results addObject:[[CTiTunesSearchResult alloc] initWithData:one]];
        }
        if(complete != nil)
        {
            complete([results copy], error);
        }
    }];
}

//// PV検索
//+ (void)searchVideoWithKeyword:(NSString *)keywordString complete:(CitrusTouchCompleteBlock)complete
//{
//    [CTHttpRequest getRequest:CTiTunesSearchURL parameters:@{ @"term":keywordString, @"country":@"JP", @"lang":@"ja_jp", @"limit":@"200", @"media":@"musicVideo" } complete:^(id userInfo, NSError *error) {
//        
////        CTLog(@"%@", [NSJSONSerialization JSONObjectWithData:userInfo options:NSJSONReadingMutableLeaves error:nil]);
//        
//        NSDictionary *list = [NSJSONSerialization JSONObjectWithData:userInfo options:NSJSONReadingMutableLeaves error:nil];
//        int count = 0;
//        for(NSDictionary *dic in list[@"results"])
//        {
//            CTLog(@"%d : %@ : %@ : %@ : %@ : %@ : %@ : %@ : %@ : %@",
//                  count++,
//                  dic[@"artistName"],
//                  dic[@"collectionCensoredName"],
//                  dic[@"collectionPrice"],
//                  dic[@"kind"],
//                  dic[@"primaryGenreName"],
//                  dic[@"releaseDate"],
//                  dic[@"trackCensoredName"],
//                  dic[@"trackCount"],
//                  dic[@"wrapperType"]
//                  );
//        }
//        
//    }];
//}

// 楽曲取得
+ (void)lookupMusicWithTrackID:(NSString *)idString complete:(CitrusTouchiTunesSearchBlock)complete
{
    [CTHttpRequest getRequest:CTiTunesLookupURL parameters:@{ @"id":idString, @"country":@"JP", @"lang":@"ja_jp", @"limit":@"200" } complete:^(id userInfo, NSError *error) {
        NSDictionary *list = [NSJSONSerialization JSONObjectWithData:userInfo options:NSJSONReadingMutableLeaves error:nil];
        NSMutableArray *results = [NSMutableArray array];
        for(NSDictionary *one in list[@"results"])
        {
            if([[one objectForKey:@"kind"] isEqualToString:@"song"] == YES)
            {
                [results addObject:[[CTiTunesSearchResult alloc] initWithData:one]];
            }
        }
        if(complete != nil)
        {
            complete([results copy], error);
        }
    }];
}

// アーティストから楽曲検索
+ (void)lookupMusicWithArtistID:(NSString *)idString complete:(CitrusTouchiTunesSearchBlock)complete
{
    [CTHttpRequest getRequest:CTiTunesLookupURL parameters:@{ @"id":idString, @"entity":@"song",  @"country":@"JP", @"lang":@"ja_jp", @"limit":@"200" } complete:^(id userInfo, NSError *error) {
        NSDictionary *list = [NSJSONSerialization JSONObjectWithData:userInfo options:NSJSONReadingMutableLeaves error:nil];
        NSMutableArray *results = [NSMutableArray array];
        for(NSDictionary *one in list[@"results"])
        {
            if([[one objectForKey:@"kind"] isEqualToString:@"song"] == YES)
            {
                [results addObject:[[CTiTunesSearchResult alloc] initWithData:one]];
            }
        }
        if(complete != nil)
        {
            complete([results copy], error);
        }
    }];
}

// アーティストIDからアーティスト取得
+ (void)lookupArtistWithArtistID:(NSString *)idString complete:(CitrusTouchiTunesSearchBlock)complete
{
    [CTHttpRequest getRequest:CTiTunesLookupURL parameters:@{ @"id":idString, @"country":@"JP", @"lang":@"ja_jp", @"limit":@"200" } complete:^(id userInfo, NSError *error) {
        NSDictionary *list = [NSJSONSerialization JSONObjectWithData:userInfo options:NSJSONReadingMutableLeaves error:nil];
        NSMutableArray *results = [NSMutableArray array];
        for(NSDictionary *one in list[@"results"])
        {
            [results addObject:[[CTiTunesSearchResult alloc] initWithData:one]];
        }
        if(complete != nil)
        {
            complete([results copy], error);
        }
    }];
}



@end
