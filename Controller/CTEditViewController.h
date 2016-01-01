//
//  CTEditViewController.h
//  CitrusTouch
//
//  Created by TAKEMOTO KOUHEI on 2013/12/21.
//  Copyright (c) 2013年 citrus.tk. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CTButton;
@class CTEditFoot;

@interface CTEditViewController : UITableViewController
{
    NSManagedObject *entity;        // entity
    
    
    NSArray *headTitles;            // ヘッダタイトル
    NSArray *rowOfSection;          // セクション内行数
    
    NSMutableDictionary *datastore; // データストア
    NSMutableDictionary *temporary; // テンポラリ
    NSMutableDictionary *relations; // リレーション
    
    
    CTEditFoot *editFoot;           // 編集パネル
    
    BOOL editable;                  // 編集可能
    
    UIAlertView *removeAlertView;   // 削除アラート
    BOOL removeAlertVisible;        // 削除アラート表示
    UIAlertView *rebirthAlertView;  // 復活アラート
    BOOL rebirthAlertVisible;       // 復活アラート表示
}

//
// property
//
@property (nonatomic, retain) NSManagedObject *entity;
@property (nonatomic, retain) NSArray *headTitles;
@property (nonatomic, retain) NSArray *rowOfSection;
@property (nonatomic, retain) NSMutableDictionary *datastore;
@property (nonatomic, retain) NSMutableDictionary *temporary;
@property (nonatomic, retain) NSMutableDictionary *relations;
@property (nonatomic, retain) CTEditFoot *editFoot;
@property (nonatomic, assign) BOOL editable;
@property (nonatomic, retain) UIAlertView *removeAlertView;
@property (nonatomic, assign) BOOL removeAlertVisible;
@property (nonatomic, retain) UIAlertView *rebirthAlertView;
@property (nonatomic, assign) BOOL rebirthAlertVisible;


//
// method
//

// 読み込み
- (void) loadEntity:(NSManagedObject *)entityValue;
// 削除
- (void) remove;
// 復活
- (void) rebirth;

@end
