//
//  CTTableModal.h
//  CitrusTouch
//
//  Created by take64 on 2012/11/24.
//  Copyright (c) 2012年 citrus.tk. All rights reserved.
//

#import "CTModal.h"

@class CTColor;
@class CTButton;

@interface CTTableModal : CTModal <UITableViewDelegate, UITableViewDataSource, UIActionSheetDelegate>
{
    // テーブルビュー
    UITableViewController *_tableViewController;
    
    // テーブル(エイリアス)
    UITableView *_tableView;
    
    NSArray *headTitles;            // ヘッダタイトル
    NSArray *rowOfSection;          // セクション内行数
    
    // アラート
    UIAlertView *_alertMessage;
    
    // キャッシュ
    NSMutableDictionary *headViewCaches;
    NSMutableDictionary *footViewCaches;
}

//
// property
//
@property (nonatomic, retain) UITableViewController *_tableViewController;
@property (nonatomic, retain) UITableView *_tableView;
@property (nonatomic, retain) NSArray *headTitles;
@property (nonatomic, retain) NSArray *rowOfSection;
@property (nonatomic, retain) UIAlertView *_alertMessage;
@property (nonatomic, retain) NSMutableDictionary *headViewCaches;
@property (nonatomic, retain) NSMutableDictionary *footViewCaches;




//
// method
//

// 初期化
- (id) initWithStyle:(UITableViewStyle)style title:(NSString *)titleValue;

// 保存
- (void) onTapButtonSave;
// 削除
- (void) onTapButtonRemove;

// メッセージ
- (void) alertMessageWithTitle:(NSString *)titleValue message:(id)messages;


@end
