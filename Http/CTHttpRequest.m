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
+ (NSData *) getRequest:(NSString *)urlString complete:(CitrusTouchCompleteBlock)complete
{
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    NSError *error;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    
    if(complete != nil)
    {
        complete(responseData, error);
    }
    return  responseData;
}


@end
