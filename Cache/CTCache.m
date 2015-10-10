//
//  CTCache.m
//  CitrusTouch
//
//  Created by TAKEMOTO KOUHEI on 2014/03/14.
//  Copyright (c) 2014年 citrus.tk. All rights reserved.
//

#import "CTCache.h"

@implementation CTCache

//
// synthesize
//
@synthesize caches;

// 初期化
- (id)init
{
    self = [super init];
    if(self)
    {
        [self setCaches:[NSMutableDictionary dictionary]];
    }
    return self;
}




//
// method
//

// URLから取得
- (void)callDataWithURL:(NSString *)urlString complete:(CitrusTouchCompleteBlock)complete
{
    NSData *data = [[[CTCache sharedInstance] caches] objectForKey:urlString];
    if(data != nil)
    {
        complete(data, nil);
    }
    else
    {
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
        
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            
            [[[CTCache sharedInstance] caches] setObject:data forKey:urlString];
            complete(data, connectionError);
        }];
    }
}




// instance
+ (CTCache *)sharedInstance
{
    static CTCache *instance;
    if(instance == nil)
    {
        instance = [[CTCache alloc] init];
    }
    return instance;
}


@end
