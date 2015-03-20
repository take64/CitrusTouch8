//
//  CTSelectKeyModal.h
//  CitrusTouch
//
//  Created by TAKEMOTO KOUHEI on 2012/11/25.
//  Copyright (c) 2012年 citrus.tk. All rights reserved.
//

#import "CTSelectModal.h"

@interface CTSelectKeyModal : CTSelectModal <UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate>
{
    // データ
    NSMutableArray *keyList;        // keyの多重配列
    NSMutableDictionary *keyDict;   // key辞書
}

//
// property
//
@property (nonatomic, retain) NSMutableArray *keyList;
@property (nonatomic, retain) NSMutableDictionary *keyDict;

@end
