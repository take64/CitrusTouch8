//
//  CTHtmlParser.h
//  Antenna
//
//  Created by TAKEMOTO KOUHEI on 2014/01/22.
//  Copyright (c) 2014年 citrus.tk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <libxml2/libxml/HTMLparser.h>

@class CTHtmlNode;
//typedef void (^CTHtmlParserBlock)(NSDictionary *userInfo);

@interface CTHtmlParser : NSObject
{
	htmlDocPtr _document;
//    NSXMLParser *parser;
//    
//    CTHtmlParserBlock completeBlock;
}


//
// property
//
@property (nonatomic, assign) htmlDocPtr _document;

//@property (nonatomic) NSXMLParser *parser;
//@property (nonatomic, copy) CTHtmlParserBlock completeBlock;


//
// method
//

// 初期化
- (id)initWithData:(NSData *)dataValue error:(NSError**)error;

// ドキュメントノード
- (CTHtmlNode *)callDocument;


// パース
//- (void) parseWithData:(NSData *)dataValue complete:(CTHtmlParserBlock)complete;


@end
