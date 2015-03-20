//
//  CTHttpRequest.h
//  EasyWeather
//
//  Created by TAKEMOTO KOUHEI on 9/20/14.
//  Copyright (c) 2014 citrus.tk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTHttpRequest : NSObject

// GETリクエスト
+ (NSData *) getRequest:(NSString *)urlString complete:(CitrusTouchCompleteBlock)complete;

@end
