//
//  CTHttpRequest.m
//  CitrusTouch
//
//  Created by take64 on 9/20/14.
//  Copyright (c) 2014 citrus.tk. All rights reserved.
//

#import "CTHttpRequest.h"

@implementation CTHttpRequest


// GETリクエスト
+ (void)getRequest:(NSString *)urlString complete:(CitrusTouchCompleteBlock)complete
{
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    __block NSData *responseData = nil;
    
    dispatch_queue_t httpQueue = dispatch_queue_create("live.citrus.touch.http", DISPATCH_QUEUE_SERIAL);
    
    dispatch_async(httpQueue, ^{
       
        CTLog(@"CTHttpRequest.getRequest : %@", urlString);
        
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
        
        NSError *error;
        responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if(complete != nil)
            {
                complete(responseData, error);
            }
        });
    });
}

// GETリクエスト
+ (void)getRequest:(NSString *)urlString parameters:(NSDictionary *)parameters complete:(CitrusTouchCompleteBlock)complete
{
    NSMutableString *url = [NSMutableString string];
    [url appendString:urlString];
    
    if([parameters count] > 0)
    {
        NSMutableArray *paramList = [NSMutableArray array];
        for(NSString *key in [parameters allKeys])
        {
            NSString *val = [parameters objectForKey:key];
            
            [paramList addObject:[NSString stringWithFormat:@"%@=%@", key, val]];
        }
        
        [url appendFormat:@"?%@", [paramList componentsJoinedByString:@"&"]];
    }
    
    [CTHttpRequest getRequest:[url copy] complete:complete];
}


@end
