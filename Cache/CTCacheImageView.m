//
//  CTCacheImageView.m
//  CitrusTouch
//
//  Created by TAKEMOTO KOUHEI on 2014/03/14.
//  Copyright (c) 2014年 citrus.tk. All rights reserved.
//

#import "CTCacheImageView.h"
#import "CTCache.h"

@implementation CTCacheImageView

//
// synthesize
//

// 初期化
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}

// 初期化
- (id)initWithFrame:(CGRect)frame imageURL:(NSString *)imageURL
{
    self = [self initWithFrame:frame];
    if(self)
    {
        [[CTCache sharedInstance] callDataWithURL:imageURL complete:^(id userInfo, NSError *error) {
            [self setImage:[UIImage imageWithData:userInfo]];
        }];
    }
    return self;
}


@end
