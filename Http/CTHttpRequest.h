//
//  CTHttpRequest.h
//  CitrusTouch
//
//  Created by take64 on 9/20/14.
//  Copyright (c) 2014 citrus.tk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTHttpRequest : NSObject

// GETリクエスト
+ (void)getRequest:(NSString *)urlString complete:(CitrusTouchCompleteBlock)complete;

// GETリクエスト
+ (void)getRequest:(NSString *)urlString parameters:(NSDictionary *)parameters complete:(CitrusTouchCompleteBlock)complete;

@end
