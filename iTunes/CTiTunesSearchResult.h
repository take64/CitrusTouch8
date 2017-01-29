//
//  CTiTunesSearchResult.h
//  ChinottoPod
//
//  Created by kouhei.takemoto on 2017/01/28.
//  Copyright © 2017年 citrus.live. All rights reserved.
//

#import "CTBusinessElement.h"

@interface CTiTunesSearchResult : CTBusinessElement
{
    NSNumber *artistId;
    NSString *artistName;
    NSString *artistType;
    NSString *artistViewUrl;
    NSString *artworkUrl100;
    NSString *artworkUrl30;
    NSString *artworkUrl60;
    NSString *collectionArtistId;
    NSString *collectionArtistName;
    NSString *collectionArtistViewUrl;
    NSString *collectionCensoredName;
    NSString *collectionExplicitness;
    NSNumber *collectionId;
    NSString *collectionName;
    NSDecimalNumber *collectionPrice;
    NSString *collectionViewUrl;
    NSString *country;
    NSString *currency;
    NSNumber *discCount;
    NSNumber *discNumber;
    NSNumber *isStreamable;
    NSString *kind;
    NSString *previewUrl;
    NSNumber *primaryGenreId;
    NSString *primaryGenreName;
    NSDate *releaseDate;
    NSString *trackCensoredName;
    NSNumber *trackCount;
    NSString *trackExplicitness;
    NSNumber *trackId;
    NSString *trackName;
    NSNumber *trackNumber;
    NSDecimalNumber *trackPrice;
    NSNumber *trackTimeMillis;
    NSString *trackViewUrl;
    NSString *wrapperType;
    NSString *contentAdvisoryRating;
}

//
// property
//
@property (nonatomic, retain) NSNumber *artistId;
@property (nonatomic, retain) NSString *artistName;
@property (nonatomic, retain) NSString *artistType;
@property (nonatomic, retain) NSString *artistViewUrl;
@property (nonatomic, retain) NSString *artworkUrl100;
@property (nonatomic, retain) NSString *artworkUrl30;
@property (nonatomic, retain) NSString *artworkUrl60;
@property (nonatomic, retain) NSString *collectionArtistId;
@property (nonatomic, retain) NSString *collectionArtistName;
@property (nonatomic, retain) NSString *collectionArtistViewUrl;
@property (nonatomic, retain) NSString *collectionCensoredName;
@property (nonatomic, retain) NSString *collectionExplicitness;
@property (nonatomic, retain) NSNumber *collectionId;
@property (nonatomic, retain) NSString *collectionName;
@property (nonatomic, retain) NSDecimalNumber *collectionPrice;
@property (nonatomic, retain) NSString *collectionViewUrl;
@property (nonatomic, retain) NSString *country;
@property (nonatomic, retain) NSString *currency;
@property (nonatomic, retain) NSNumber *discCount;
@property (nonatomic, retain) NSNumber *discNumber;
@property (nonatomic, retain) NSNumber *isStreamable;
@property (nonatomic, retain) NSString *kind;
@property (nonatomic, retain) NSString *previewUrl;
@property (nonatomic, retain) NSNumber *primaryGenreId;
@property (nonatomic, retain) NSString *primaryGenreName;
@property (nonatomic, retain) NSDate *releaseDate;
@property (nonatomic, retain) NSString *trackCensoredName;
@property (nonatomic, retain) NSNumber *trackCount;
@property (nonatomic, retain) NSString *trackExplicitness;
@property (nonatomic, retain) NSNumber *trackId;
@property (nonatomic, retain) NSString *trackName;
@property (nonatomic, retain) NSNumber *trackNumber;
@property (nonatomic, retain) NSDecimalNumber *trackPrice;
@property (nonatomic, retain) NSNumber *trackTimeMillis;
@property (nonatomic, retain) NSString *trackViewUrl;
@property (nonatomic, retain) NSString *wrapperType;
@property (nonatomic, retain) NSString *contentAdvisoryRating;


// 初期化
- (id)initWithData:(NSDictionary *)dataValue;

@end

