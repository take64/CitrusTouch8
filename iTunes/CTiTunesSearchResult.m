//
//  CTiTunesSearchResult.m
//  ChinottoPod
//
//  Created by kouhei.takemoto on 2017/01/28.
//  Copyright © 2017年 citrus.live. All rights reserved.
//

#import "CTiTunesSearchResult.h"

@implementation CTiTunesSearchResult

//
// synthesize
//
@synthesize artistId;
@synthesize artistName;
@synthesize artistType;
@synthesize artistViewUrl;
@synthesize artworkUrl100;
@synthesize artworkUrl30;
@synthesize artworkUrl60;
@synthesize collectionArtistId;
@synthesize collectionArtistName;
@synthesize collectionArtistViewUrl;
@synthesize collectionCensoredName;
@synthesize collectionExplicitness;
@synthesize collectionId;
@synthesize collectionName;
@synthesize collectionPrice;
@synthesize collectionViewUrl;
@synthesize country;
@synthesize currency;
@synthesize discCount;
@synthesize discNumber;
@synthesize isStreamable;
@synthesize kind;
@synthesize previewUrl;
@synthesize primaryGenreId;
@synthesize primaryGenreName;
@synthesize releaseDate;
@synthesize trackCensoredName;
@synthesize trackCount;
@synthesize trackExplicitness;
@synthesize trackId;
@synthesize trackName;
@synthesize trackNumber;
@synthesize trackPrice;
@synthesize trackTimeMillis;
@synthesize trackViewUrl;
@synthesize wrapperType;
@synthesize contentAdvisoryRating;


// 初期化
- (id)initWithData:(NSDictionary *)dataValue
{
    self = [super init];
    if(self)
    {
        for(NSString *key in [dataValue allKeys])
        {
            id val = [dataValue objectForKey:key];
            
            if([key isEqualToString:@"releaseDate"] == YES)
            {
                [self setValue:[CTDate dateWithString:val] forKey:key];
            }
            else if([key isEqualToString:@"artistLinkUrl"] == YES)
            {
                [self setValue:val forKey:@"artistViewUrl"];
            }
            else
            {
                [self setValue:val forKey:key];
            }
        }
    }
    return self;
}





@end
