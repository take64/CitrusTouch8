//
//  CTSelectModal.h
//  CitrusTouch
//
//  Created by take64 on 2012/11/25.
//  Copyright (c) 2012年 citrus.tk. All rights reserved.
//

#import "CTModal.h"

@interface CTSelectModal : CTModal <UITableViewDelegate, UITableViewDataSource>
{
    // テーブルビュー
    UITableViewController *_tableViewController;
    
    // テーブル(エイリアス)
    UITableView *_tableView;
    
    // ヘッダタイトル
    NSMutableArray *headTitles;
    
    // ヘッダビューキャッシュ
    NSMutableDictionary *headViewCaches;
    
    // 選択リスト
    NSMutableArray *selectedList;
}

//
// property
//
@property (nonatomic, retain) UITableViewController *_tableViewController;
@property (nonatomic, retain) UITableView *_tableView;
@property (nonatomic, retain) NSMutableArray *headTitles;
@property (nonatomic, retain) NSMutableDictionary *headViewCaches;
@property (nonatomic, retain) NSMutableArray *selectedList;





//
// method
//

// 初期化
- (id) initWithStyle:(UITableViewStyle)style title:(NSString *)titleValue parentController:(UIViewController *)parentController;

// 初期化
- (id) initWithStyleParentController:(UIViewController *)parentController;
@end
