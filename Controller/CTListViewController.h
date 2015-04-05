//
//  CTListViewController.h
//  CitrusTouch
//
//  Created by TAKEMOTO KOUHEI on 2013/12/22.
//  Copyright (c) 2013年 naissance sapporo co,.Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CTListViewController : UITableViewController <NSFetchedResultsControllerDelegate>
{
    // フェッチ
    NSFetchedResultsController *fetchedResultsController;
    
    // ヘッダビューキャッシュ
    NSMutableDictionary *headViewCaches;
}

//
// property
//
@property(nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property(nonatomic, retain) NSMutableDictionary *headViewCaches;


//
// method
//

// フェッチ
- (NSFetchedResultsController *) callFetchedResultsController;

@end
