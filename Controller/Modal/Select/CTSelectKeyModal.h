//
//  CTSelectKeyModal.h
//  CitrusTouch
//
//  Created by take64 on 2012/11/25.
//  Copyright (c) 2012年 citrus.tk. All rights reserved.
//

#import "CTSelectModal.h"

@interface CTSelectKeyModal : CTSelectModal <UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate>
{
    // データ
    NSMutableArray<NSMutableArray *> *keyList;  // keyの多重配列
    NSMutableDictionary *keyDict;               // key辞書
}

//
// property
//
@property (nonatomic, retain) NSMutableArray<NSMutableArray *> *keyList;
@property (nonatomic, retain) NSMutableDictionary *keyDict;
@property (nonatomic, retain) id selectedKey;

//
// method
//

// データ読み込み
- (void)loadSelectData:(NSMutableArray<NSMutableArray *> *)_keyList keyValue:(NSMutableDictionary *)_keyDict;

@end
