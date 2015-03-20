//
//  CTHtmlParser.m
//  Antenna
//
//  Created by TAKEMOTO KOUHEI on 2014/01/22.
//  Copyright (c) 2014年 citrus.tk. All rights reserved.
//

#import "CTHtmlParser.h"

#import "CTHtmlNode.h"

#import "HTMLParser.h"

@implementation CTHtmlParser

//
// synthesize
//
@synthesize _document;
//@synthesize completeBlock;


// 初期化
- (id)initWithData:(NSData *)dataValue error:(NSError**)error;
{
    self = [super init];
	if (self)
	{
        [self set_document:NULL];
        
		if (dataValue != nil)
		{
			CFStringEncoding cfenc = CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding);
			CFStringRef cfencstr = CFStringConvertEncodingToIANACharSetName(cfenc);
			const char *encode = CFStringGetCStringPtr(cfencstr, 0);
			
            [self set_document:
             htmlReadDoc((xmlChar*)[dataValue bytes], "", encode, XML_PARSE_NOERROR | XML_PARSE_NOWARNING)
             ];
		}
		else
		{
			if (error != nil)
			{
				*error = [NSError errorWithDomain:@"HTMLParserDomain" code:1 userInfo:nil];
			}
		}
	}
	return self;
}
- (void)dealloc
{
	if ([self _document])
	{
		xmlFreeDoc([self _document]);
	}
}

#pragma mark -
#pragma mark method
//
// method
//

// ドキュメントノード
- (CTHtmlNode *)callDocument
{
    
	if ([self _document] == nil)
    {
        return nil;
    }
	
	return [[CTHtmlNode alloc] initWithXMLNode:(xmlNode *)[self _document]];
}

//// パース
//- (void) parseWithData:(NSData *)dataValue complete:(CTHtmlParserBlock)complete
//{
//    [self setCompleteBlock:complete];
//    
////    NSXMLParser
////    NSXMLDocumentTidyHTML
////    NSXMLD *doc = [NSXmlD]
////    [self setParser:[[NSXMLParser alloc] initWithData:dataValue]];
////    [[self parser] setDelegate:self];
////    [[self parser] parse];
//
//    HTMLParser *pp = [[HTMLParser alloc] initWithData:dataValue error:nil];
//    
////    NSLog(@"all : %@", [[pp doc] findChildTags:@"meta"]);
//    for(HTMLNode *node in [[pp doc] findChildTags:@"link"])
//    {
//        if([[node getAttributeNamed:@"rel"] isEqualToString:@"alternate"] == YES)
//        {
//            NSLog(@"%@", [node getAttributeNamed:@"href"]);
//            NSLog(@"%@", [node children]);
//            
//        }
//    }
//}
//
//#pragma mark -
//#pragma mark NSXMLParserDelegate
////
//// NSXMLParserDelegate
////
//
////- (void)parserDidStartDocument:(NSXMLParser *)parser;
////- (void)parserDidEndDocument:(NSXMLParser *)parser;
////- (void)parser:(NSXMLParser *)parser foundNotationDeclarationWithName:(NSString *)name publicID:(NSString *)publicID systemID:(NSString *)systemID;
////- (void)parser:(NSXMLParser *)parser foundUnparsedEntityDeclarationWithName:(NSString *)name publicID:(NSString *)publicID systemID:(NSString *)systemID notationName:(NSString *)notationName;
////- (void)parser:(NSXMLParser *)parser foundAttributeDeclarationWithName:(NSString *)attributeName forElement:(NSString *)elementName type:(NSString *)type defaultValue:(NSString *)defaultValue;
////- (void)parser:(NSXMLParser *)parser foundElementDeclarationWithName:(NSString *)elementName model:(NSString *)model;
////- (void)parser:(NSXMLParser *)parser foundInternalEntityDeclarationWithName:(NSString *)name value:(NSString *)value;
////- (void)parser:(NSXMLParser *)parser foundExternalEntityDeclarationWithName:(NSString *)name publicID:(NSString *)publicID systemID:(NSString *)systemID;
//- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
//{
//    NSLog(@"%@", elementName);
//	NSLog(@"%@", attributeDict);
//}
////- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName;
////- (void)parser:(NSXMLParser *)parser didStartMappingPrefix:(NSString *)prefix toURI:(NSString *)namespaceURI;
////- (void)parser:(NSXMLParser *)parser didEndMappingPrefix:(NSString *)prefix;
////- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string;
////- (void)parser:(NSXMLParser *)parser foundIgnorableWhitespace:(NSString *)whitespaceString;
////- (void)parser:(NSXMLParser *)parser foundProcessingInstructionWithTarget:(NSString *)target data:(NSString *)data;
////- (void)parser:(NSXMLParser *)parser foundComment:(NSString *)comment;
////- (void)parser:(NSXMLParser *)parser foundCDATA:(NSData *)CDATABlock;
////- (NSData *)parser:(NSXMLParser *)parser resolveExternalEntityName:(NSString *)name systemID:(NSString *)systemID;
//- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
//{
//    NSLog(@"error : %@", parseError);
//}
//- (void)parser:(NSXMLParser *)parser validationErrorOccurred:(NSError *)validationError
//{
//    NSLog(@"validationError : %@", validationError);
//}

@end
