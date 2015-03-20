//
//  CTHtml.h
//  Antenna
//
//  Created by TAKEMOTO KOUHEI on 2014/01/26.
//  Copyright (c) 2014年 citrus.tk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTHtml : NSObject

// RSS-URLを取得
+ (NSString *)rssURLFromWebsiteURL:(NSString *)stringValue;

// RSS-URLを取得
+ (NSString *)rssURLFromWebsiteData:(NSData *)dateValue;

// faviconを取得
+ (NSData *)faviconDataFromWebsiteURL:(NSString *)stringValue;

// faviconを取得
+ (NSData *)faviconDataFromWebsiteData:(NSData *)dateValue;

// titleを取得
+ (NSString *)titleFromWebsiteURL:(NSString *)stringValue;

// titleを取得
+ (NSString *)titleFromWebsiteData:(NSData *)dateValue;

@end
