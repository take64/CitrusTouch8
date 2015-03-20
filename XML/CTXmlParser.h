//
//  CTXmlParser.h
//  Antenna
//
//  Created by TAKEMOTO KOUHEI on 2014/01/23.
//  Copyright (c) 2014年 citrus.tk. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^CTXmlParserBlock)(NSDictionary *userInfo);

enum {
    CTXmlParserOptionsProcessNamespaces           = 1 << 0, // Specifies whether the receiver reports the namespace and the qualified name of an element.
    CTXmlParserOptionsReportNamespacePrefixes     = 1 << 1, // Specifies whether the receiver reports the scope of namespace declarations.
    CTXmlParserOptionsResolveExternalEntities     = 1 << 2, // Specifies whether the receiver reports declarations of external entities.
};
typedef NSUInteger CTXmlParserOptions;

@interface CTXmlParser : NSObject <NSXMLParserDelegate>
{
    NSXMLParser *parser;
    CTXmlParserBlock completeBlock;
    
    NSMutableArray *stacks;
    NSMutableString *text;
}

//
// property
//
@property (nonatomic, retain) NSXMLParser *parser;
@property (nonatomic, copy) CTXmlParserBlock completeBlock;
@property (nonatomic, retain) NSMutableArray *stacks;
@property (nonatomic, retain) NSMutableString *text;


//
// method
//

// 初期化
- (NSDictionary *)objectWithData:(NSData *)data options:(CTXmlParserOptions)options;

// パース
+ (NSDictionary *)dictionaryWithData:(NSData *)dataValue complete:(CTXmlParserBlock)complete;

@end
