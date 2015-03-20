//
//  CTHtmlNode.m
//  Antenna
//
//  Created by TAKEMOTO KOUHEI on 2014/01/23.
//  Copyright (c) 2014年 citrus.tk. All rights reserved.
//

#import "CTHtmlNode.h"
#import <libxml/HTMLparser.h>
#import <libxml/HTMLtree.h>

@implementation CTHtmlNode

//
// synthesize
//
@synthesize _node;

// 初期化
- (id)initWithXMLNode:(xmlNode *)xmlNode
{
    self = [super init];
	if (self)
	{
        [self set_node:xmlNode];
	}
	return self;
}


#pragma mark -
#pragma mark method
//
// method
//

// タグ検索
- (NSArray *)findTags:(NSString *)tagName
{
	NSMutableArray * array = [NSMutableArray arrayWithCapacity:1];
	
	[self findChildTags:tagName inXMLNode:[self _node]->children inArray:array];
	
	return array;
}

// 要素の取得
-(NSString *)getAttributeNamed:(NSString*)name
{
	const char * nameStr = [name UTF8String];
	
	for(xmlAttrPtr attr = [self _node]->properties; NULL != attr; attr = attr->next)
	{
		if (strcmp((char*)attr->name, nameStr) == 0)
		{
			for(xmlNode * child = attr->children; NULL != child; child = child->next)
			{
				return [NSString stringWithCString:(void*)child->content encoding:NSUTF8StringEncoding];
				
			}
			break;
		}
	}
	
	return NULL;
}

// 配下要素の取得
- (NSArray *)children
{
	xmlNode *cursorNode = NULL;
	NSMutableArray * array = [NSMutableArray array];
    
	for (cursorNode = [self _node]->children; cursorNode; cursorNode = cursorNode->next)
	{
		CTHtmlNode * node = [[CTHtmlNode alloc] initWithXMLNode:cursorNode];
		[array addObject:node];
	}
	
	return array;
}

// タグ名の取得
-(NSString *)tagName
{
    return [NSString stringWithCString:(void *)[self _node]->name encoding:NSUTF8StringEncoding];
}

// RAWコンテンツ
- (NSString *)rawContents
{
    xmlNode *node = (__bridge xmlNode *)self;
    
	xmlBufferPtr buffer = xmlBufferCreateSize(1000);
	xmlOutputBufferPtr buf = xmlOutputBufferCreateBuffer(buffer, NULL);
	
	htmlNodeDumpOutput(buf, node->doc, node, (const char*)node->doc->encoding);
    
	xmlOutputBufferFlush(buf);
    
	NSString * string = nil;
	
	if (buffer->content) {
		string = [[NSString alloc] initWithBytes:(const void *)xmlBufferContent(buffer) length:xmlBufferLength(buffer) encoding:NSUTF8StringEncoding];
	}
	
	xmlOutputBufferClose(buf);
	xmlBufferFree(buffer);
	
	return string;
}

// コンテンツ
-(NSString*)contents
{
	if ([self _node]->children && [self _node]->children->content)
	{
		return [NSString stringWithCString:(void*)[self _node]->children->content encoding:NSUTF8StringEncoding];
	}
	
	return nil;
}

#pragma mark -
#pragma mark private
//
// private
//

// 配下のタグを検索
-(void)findChildTags:(NSString*)tagName inXMLNode:(xmlNode *)node inArray:(NSMutableArray*)array
{
	xmlNode *cursorNode = NULL;
	const char * tagNameStr =  [tagName UTF8String];
	
	if (tagNameStr == nil)
		return;
	
    for (cursorNode = node; cursorNode; cursorNode = cursorNode->next)
	{
		if (cursorNode->name && strcmp((char*)cursorNode->name, tagNameStr) == 0)
		{
			CTHtmlNode * node = [[CTHtmlNode alloc] initWithXMLNode:cursorNode];
			[array addObject:node];
			
		}
		
		[self findChildTags:tagName inXMLNode:cursorNode->children inArray:array];
	}
}


@end
