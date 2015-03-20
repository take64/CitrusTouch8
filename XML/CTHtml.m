//
//  CTHtml.m
//  Antenna
//
//  Created by TAKEMOTO KOUHEI on 2014/01/26.
//  Copyright (c) 2014年 citrus.tk. All rights reserved.
//

#import "CTHtml.h"
#import "CTHtmlParser.h"
#import "CTHtmlNode.h"

@implementation CTHtml

// RSS-URLを取得
+ (NSString *)rssURLFromWebsiteURL:(NSString *)stringValue
{
    return [self rssURLFromWebsiteData:[NSData dataWithContentsOfURL:[NSURL URLWithString:stringValue]]];
}

// RSS-URLを取得
+ (NSString *)rssURLFromWebsiteData:(NSData *)dateValue
{
    // パース
    NSError *error;
    CTHtmlParser *parser = [[CTHtmlParser alloc] initWithData:dateValue error:&error];
    if(error != nil)
    {
        return nil;
    }
    
    NSString *rssURL;
    
    // RSS
    for(CTHtmlNode *node in [[parser callDocument] findTags:@"link"])
    {
        if([[node getAttributeNamed:@"rel"] isEqualToString:@"alternate"] == YES && [[node getAttributeNamed:@"type"] isEqualToString:@"application/rss+xml"] == YES)
        {
            rssURL = [node getAttributeNamed:@"href"];
            break;
        }
    }
    
    // 相対パスの場合
    if([rssURL hasPrefix:@"http"] == NO)
    {
        for(CTHtmlNode *node in [[parser callDocument] findTags:@"link"])
        {
            if([[node getAttributeNamed:@"rel"] isEqualToString:@"canonical"])
            {
                NSString *websiteURL = [node getAttributeNamed:@"href"];
                if([websiteURL hasSuffix:@"/"] == NO)
                {
                    if([rssURL hasPrefix:@"./"] == YES)
                    {
                        rssURL = [rssURL stringByReplacingOccurrencesOfString:@"./" withString:@""];
                    }
                    rssURL = [NSString stringWithFormat:@"%@/%@", websiteURL, rssURL];
                }
                break;
            }
        }
    }
    
    
    return rssURL;
}

// faviconを取得
+ (NSData *)faviconDataFromWebsiteURL:(NSString *)stringValue
{
    return [self faviconDataFromWebsiteData:[NSData dataWithContentsOfURL:[NSURL URLWithString:stringValue]]];
}

// faviconを取得
+ (NSData *)faviconDataFromWebsiteData:(NSData *)dateValue
{
    // パース
    NSError *error;
    CTHtmlParser *parser = [[CTHtmlParser alloc] initWithData:dateValue error:&error];
    if(error != nil)
    {
        return nil;
    }
    
    NSData *favicon;
    
    // favicon
    for(CTHtmlNode *node in [[parser callDocument] findTags:@"link"])
    {
        if([[node getAttributeNamed:@"rel"] isEqualToString:@"icon"] == YES)
        {
            NSString *faviconURL = [node getAttributeNamed:@"href"];
            favicon = [NSData dataWithContentsOfURL:[NSURL URLWithString:faviconURL]];
            break;
        }
    }
    
    // html内にfaviconがない場合
    if(favicon == nil)
    {
        for(CTHtmlNode *node in [[parser callDocument] findTags:@"link"])
        {
            if([[node getAttributeNamed:@"rel"] isEqualToString:@"canonical"])
            {
                NSString *websiteURLstring = [node getAttributeNamed:@"href"];
                NSURL *websiteURL = [NSURL URLWithString:websiteURLstring];
                NSString *faviconURL = [NSString stringWithFormat:@"%@://%@/favicon.ico",
                                        [websiteURL scheme],
                                        [websiteURL host]
                                        ];
                favicon = [NSData dataWithContentsOfURL:[NSURL URLWithString:faviconURL]];
                break;
            }
        }
    }
    
    return favicon;
}

// titleを取得
+ (NSString *)titleFromWebsiteURL:(NSString *)stringValue
{
    return [self titleFromWebsiteData:[NSData dataWithContentsOfURL:[NSURL URLWithString:stringValue]]];
}

// titleを取得
+ (NSString *)titleFromWebsiteData:(NSData *)dateValue
{
    
    // パース
    NSError *error;
    CTHtmlParser *parser = [[CTHtmlParser alloc] initWithData:dateValue error:&error];
    if(error != nil)
    {
        return nil;
    }
    
    NSString *title;
    
    // favicon
    for(CTHtmlNode *node in [[parser callDocument] findTags:@"title"])
    {
        NSString *stringValue = [node contents];
        if([stringValue isEqualToString:@""] == NO)
        {
            title = stringValue;
            break;
        }
//        if([[node getAttributeNamed:@"rel"] isEqualToString:@"icon"] == YES)
//        {
//            NSString *faviconURL = [node getAttributeNamed:@"href"];
//            favicon = [NSData dataWithContentsOfURL:[NSURL URLWithString:faviconURL]];
//            break;
//        }
    }
    return title;
}

@end
