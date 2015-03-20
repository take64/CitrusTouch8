//
//  CTSectionDatastore.h
//  FriendConnection
//
//  Created by TAKEMOTO KOUHEI on 2013/10/09.
//  Copyright (c) 2013年 citrus.tk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTSectionDatastore : NSObject
{
    NSMutableArray *names;
    NSMutableDictionary *objects;
}

//
// property
//
@property (nonatomic, retain) NSMutableArray *names;
@property (nonatomic, retain) NSMutableDictionary *objects;


//
// method
//

// セクション数
- (NSInteger) sectionCount;

// オブジェクト数
- (NSUInteger) countOfObjects:(NSString *)name;

// オブジェクト数
- (NSUInteger) countAtIndex:(NSUInteger)index;

// 名称
- (NSString *) nameAtIndex:(NSUInteger)index;

// オブジェクト
- (id) objectAtIndexPath:(NSIndexPath *)indexPath;

// オブジェクトの追加
- (void) addObject:(id)object name:(NSString *)name;

// 初期化
- (void) empty;

@end
