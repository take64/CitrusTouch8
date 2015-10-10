//
//  CTCache.h
//  CitrusTouch
//
//  Created by TAKEMOTO KOUHEI on 2014/03/14.
//  Copyright (c) 2014年 citrus.tk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTCache : NSObject
{
    NSMutableDictionary *caches;
}

//
// property
//
@property (nonatomic, retain) NSMutableDictionary *caches;



//
// method
//

// URLから取得
- (void)callDataWithURL:(NSString *)urlString complete:(CitrusTouchCompleteBlock)complete;


//
// singleton
//

// instance
+ (CTCache *)sharedInstance;

@end

