//
//  CTXmlParser.m
//  Antenna
//
//  Created by TAKEMOTO KOUHEI on 2014/01/23.
//  Copyright (c) 2014年 citrus.tk. All rights reserved.
//

#import "CTXmlParser.h"

@implementation CTXmlParser

//
// synthesize
//
@synthesize parser;
@synthesize completeBlock;
@synthesize stacks;
@synthesize text;

//// 初期化
//- (id)initWithData:(NSData *)dataValue complete:(CTXmlParserBlock)complete
//{
//    self = [super init];
//    if(self)
//    {
//        [self setStacks:[NSMutableArray arrayWithCapacity:1]];
//        [self setText:[NSMutableString stringWithString:@""]];
//        
//        
//        [self setCompleteBlock:complete];
//        [self setParser:[[NSXMLParser alloc] initWithData:dataValue]];
//        [[self parser] setDelegate:self];
//        
//        
//        
////        NSDictionary *dic = [NSDictionary dictionaryWithContentsOfURL:[NSURL URLWithString:@"http://startup-objc.blogspot.com/feeds/posts/default"]];
////        NSLog(@"%@ :", dic);
//    }
//    return self;
//}

// パース
+ (NSDictionary *)dictionaryWithData:(NSData *)dataValue complete:(CTXmlParserBlock)complete
{
    CTXmlParser *parser = [[CTXmlParser alloc] init];
    NSDictionary *rootDictionary = [parser objectWithData:dataValue options:CTXmlParserOptionsResolveExternalEntities];
    if(complete != nil)
    {
        complete(rootDictionary);
    }
    return rootDictionary;
}


- (NSDictionary *)objectWithData:(NSData *)data options:(CTXmlParserOptions)options
{
    [self setStacks:[[NSMutableArray alloc] init]];
    [self setText:[[NSMutableString alloc] init]];
    
    // Initialize the stack with a fresh dictionary
    [[self stacks] addObject:[NSMutableDictionary dictionary]];
    
    // Parse the XML
    [self setParser:[[NSXMLParser alloc] initWithData:data]];
    
    [[self parser] setShouldProcessNamespaces:(options & CTXmlParserOptionsProcessNamespaces)];
    [[self parser] setShouldReportNamespacePrefixes:(options & CTXmlParserOptionsReportNamespacePrefixes)];
    [[self parser] setShouldResolveExternalEntities:(options & CTXmlParserOptionsResolveExternalEntities)];
    
    [[self parser] setDelegate:self];
    BOOL success = [[self parser] parse];
	
    // Return the stack's root dictionary on success
    if (success == YES)
    {
        NSDictionary *resultDict = [[self stacks] objectAtIndex:0];
        return resultDict;
    }
    
    return nil;
}




#pragma mark -
#pragma mark NSXMLParserDelegate
//
// NSXMLParserDelegate
//

//- (void)parserDidStartDocument:(NSXMLParser *)parser;
//- (void)parserDidEndDocument:(NSXMLParser *)parser;
//- (void)parser:(NSXMLParser *)parser foundNotationDeclarationWithName:(NSString *)name publicID:(NSString *)publicID systemID:(NSString *)systemID;
//- (void)parser:(NSXMLParser *)parser foundUnparsedEntityDeclarationWithName:(NSString *)name publicID:(NSString *)publicID systemID:(NSString *)systemID notationName:(NSString *)notationName;
//- (void)parser:(NSXMLParser *)parser foundAttributeDeclarationWithName:(NSString *)attributeName forElement:(NSString *)elementName type:(NSString *)type defaultValue:(NSString *)defaultValue;
//- (void)parser:(NSXMLParser *)parser foundElementDeclarationWithName:(NSString *)elementName model:(NSString *)model;
//- (void)parser:(NSXMLParser *)parser foundInternalEntityDeclarationWithName:(NSString *)name value:(NSString *)value;
//- (void)parser:(NSXMLParser *)parser foundExternalEntityDeclarationWithName:(NSString *)name publicID:(NSString *)publicID systemID:(NSString *)systemID;
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
//    NSLog(@"%@", elementName);
//	NSLog(@"%@", attributeDict);
    NSMutableDictionary *parentDict = [[self stacks] lastObject];
    
    NSMutableDictionary *childDict = [NSMutableDictionary dictionary];
    [childDict addEntriesFromDictionary:attributeDict];
    
    id existingValue = [parentDict objectForKey:elementName];
    if (existingValue != nil)
    {
        NSMutableArray *array = nil;
        if ([existingValue isKindOfClass:[NSMutableArray class]])
        {
            array = (NSMutableArray *) existingValue;
        }
        else
        {
            array = [NSMutableArray array];
            [array addObject:existingValue];
            
            [parentDict setObject:array forKey:elementName];
        }
        
        [array addObject:childDict];
    }
    else
    {
        [parentDict setObject:childDict forKey:elementName];
    }
    
    [[self stacks] addObject:childDict];
}
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    NSMutableDictionary *dictInProgress = [[self stacks] lastObject];
    
    if ([[self text] length] > 0)
    {
        NSString *trimmedString = [[self text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        [dictInProgress setObject:[trimmedString mutableCopy] forKey:@"text"];
        
        [self setText:[[NSMutableString alloc] init]];
    }
    [[self stacks] removeLastObject];
}
//- (void)parser:(NSXMLParser *)parser didStartMappingPrefix:(NSString *)prefix toURI:(NSString *)namespaceURI;
//- (void)parser:(NSXMLParser *)parser didEndMappingPrefix:(NSString *)prefix;
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    [[self text] appendString:string];
}
//- (void)parser:(NSXMLParser *)parser foundIgnorableWhitespace:(NSString *)whitespaceString;
//- (void)parser:(NSXMLParser *)parser foundProcessingInstructionWithTarget:(NSString *)target data:(NSString *)data;
//- (void)parser:(NSXMLParser *)parser foundComment:(NSString *)comment;
//- (void)parser:(NSXMLParser *)parser foundCDATA:(NSData *)CDATABlock;
//- (NSData *)parser:(NSXMLParser *)parser resolveExternalEntityName:(NSString *)name systemID:(NSString *)systemID;
- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
    NSLog(@"error : %@", parseError);
}
- (void)parser:(NSXMLParser *)parser validationErrorOccurred:(NSError *)validationError
{
    NSLog(@"validationError : %@", validationError);
}

@end
