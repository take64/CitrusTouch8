//
//  CTHtmlNode.h
//  Antenna
//
//  Created by TAKEMOTO KOUHEI on 2014/01/23.
//  Copyright (c) 2014年 citrus.tk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <libxml/HTMLparser.h>

@interface CTHtmlNode : NSObject
{
    xmlNode * _node;
}
//
// property
//
@property (nonatomic, assign) xmlNode * _node;

//
// method
//

// 初期化
- (id)initWithXMLNode:(xmlNode *)xmlNode;


// タグ検索
- (NSArray *)findTags:(NSString *)tagName;

// 要素の取得
- (NSString *)getAttributeNamed:(NSString*)name;

// 配下要素の取得
- (NSArray *)children;

// タグ名の取得
- (NSString *)tagName;

// RAWコンテンツ
- (NSString *)rawContents;

// コンテンツ
-(NSString*)contents;

@end
