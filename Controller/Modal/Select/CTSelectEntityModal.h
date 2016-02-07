//
//  CTSelectEntityModal.h
//  CitrusTouch
//
//  Created by take64 on 2012/11/25.
//  Copyright (c) 2012年 citrus.tk. All rights reserved.
//

#import "CTSelectModal.h"

@interface CTSelectEntityModal : CTSelectModal <UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate>
{
    // フェッチ
    NSFetchedResultsController *fetchedResultsController;
}

//
// property
//
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;


@end
