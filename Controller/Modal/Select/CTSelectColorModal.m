//
//  CTSelectColorModal.m
//  CitrusTouch
//
//  Created by TAKEMOTO KOUHEI on 2015/03/26.
//  Copyright (c) 2015年 citrus.tk. All rights reserved.
//

#import "CTSelectColorModal.h"

@interface CTSelectColorModal ()

@end

@implementation CTSelectColorModal

// 初期化
- (id) initWithStyle:(UITableViewStyle)style title:(NSString *)titleValue parentController:(UIViewController *)parentController
{
    self = [super initWithStyle:style title:titleValue parentController:parentController];
    if(self)
    {
        [self setKeyList:[@[
                            @[
                                @"000000",
                                @"FF0000",
                                @"00FF00",
                                @"0000FF",
                                @"FFFF00",
                                @"00FFFF",
                                @"FF00FF",
                                @"FFFFFF",
                                ]
                            ] mutableCopy]];
    }
    return self;
}


#pragma mark -
#pragma mark UITableViewDataSource method
//
// UITableViewDataSource method
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
// セルを返却する
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellId = @"CellId";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellId];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellId];
    }
    if(cell != nil)
    {
        NSInteger section   = [indexPath section];
        NSInteger row       = [indexPath row];
        id selectedObject = [[[self keyList] objectAtIndex:section] objectAtIndex:row];
        
        [[cell contentView] setBackgroundColor:[CTColor colorWithHEXString:selectedObject]];
        
    }
    return cell;
}
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section;
//- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section;
//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath;
//- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath;
//- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView;
//- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index;
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath;
//- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath;

@end
