//
//  CTPopupEdit.h
//  CitrusTouch
//
//  Created by take64 on 2014/03/20.
//  Copyright (c) 2014年 citrus.tk. All rights reserved.
//

#import "CTPopupDialog.h"

@interface CTPopupEdit : CTPopupDialog <UITableViewDataSource, UITableViewDelegate>
{
    // entity
    NSManagedObject *entity;
    
    // table
    UITableView *_tableView;
    
    // temporary
    NSMutableDictionary *temporary;
    NSMutableDictionary *datastore;
    
    // title
    NSArray *headTitles;
    NSArray *rowOfSection;
}
//
// property
//
@property (nonatomic, retain) NSManagedObject *entity;
@property (nonatomic, retain) UITableView *_tableView;
@property (nonatomic, retain) NSMutableDictionary *temporary;
@property (nonatomic, retain) NSMutableDictionary *datastore;
@property (nonatomic, retain) NSArray *headTitles;
@property (nonatomic, retain) NSArray *rowOfSection;


@end
