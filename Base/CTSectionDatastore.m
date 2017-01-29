//
//  CTSectionDatastore.m
//  CitrusTouch
//
//  Created by take64 on 2013/10/09.
//  Copyright (c) 2013年 citrus.tk. All rights reserved.
//

#import "CTSectionDatastore.h"

@implementation CTSectionDatastore

//
// synthesize
//
@synthesize names;
@synthesize objects;


// 初期化
- (id) init
{
    self = [super init];
    if(self)
    {
        [self setNames:     [NSMutableArray arrayWithCapacity:1]];
        [self setObjects:   [NSMutableDictionary dictionaryWithCapacity:1]];
    }
    return self;
}





#pragma mark -
#pragma mark method
//
// method
//

// セクション数
- (NSInteger) sectionCount
{
    return [[self names] count];
}

// オブジェクト数
- (NSUInteger) countOfObjects:(NSString *)name
{
    NSInteger count = 0;
    
    if([[self objects] objectForKey:name] != nil)
    {
        count = [[[self objects] objectForKey:name] count];
    }
    
    return count;
}

// オブジェクト数
- (NSUInteger) countAtIndex:(NSUInteger)index
{
    NSInteger count = 0;
    
    if([[self names] objectAtIndex:index] != nil)
    {
        NSString *name = [[self names] objectAtIndex:index];
        
        count = [self countOfObjects:name];
    }
    
    return count;
}

// 名称
- (NSString *) nameAtIndex:(NSUInteger)index
{
    NSString *name = nil;
    @try
    {
        name = [[self names] objectAtIndex:index];
    }
    @catch (NSException *exception)
    {
        CTLog(@"%@", exception);
    }
    @finally {}
    return name;
}

// オブジェクト
- (id) objectAtIndexPath:(NSIndexPath *)indexPath
{
    id result = nil;
    @try
    {
        NSInteger section   = [indexPath section];
        NSInteger row       = [indexPath row];
        NSString *name      = [self nameAtIndex:section];
        NSMutableArray *list = [[self objects] objectForKey:name];
        result = [list objectAtIndex:row];
    }
    @catch (NSException *exception)
    {
        CTLog(@"%@", exception);
    }
    @finally {}
    return result;
}

// オブジェクトの追加
- (void) addObject:(id)object name:(NSString *)name
{
    if([[self names] containsObject:name] == NO)
    {
        [[self names] addObject:name];
    }
    
    if([[self objects] objectForKey:name] == nil)
    {
        [[self objects] setObject:[NSMutableArray arrayWithCapacity:1] forKey:name];
    }
    
    [[[self objects] objectForKey:name] addObject:object];
}

// 初期化
- (void) empty
{
    [self setNames:     [NSMutableArray arrayWithCapacity:1]];
    [self setObjects:   [NSMutableDictionary dictionaryWithCapacity:1]];
}

@end
