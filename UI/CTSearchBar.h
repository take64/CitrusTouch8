//
//  CTSearchBar.h
//  ChinottoPod
//
//  Created by kouhei.takemoto on 2016/12/03.
//  Copyright © 2016年 citrus.live. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CitrusTouchSearchBarBlock)(NSString *keywordString);

@interface CTSearchBar : UISearchBar <UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
{
    // サジェストブロック
    CitrusTouchSearchBarBlock suggestBlock;
    
    // 検索ブロック
    CitrusTouchSearchBarBlock searchBlock;
    
    
    // サジェストキーワードリスト
    NSArray<NSString *> *_suggestList;
    
    // サジェストキーワードテーブル
    UITableView *_tableView;
    
    // キーボード通知
    NSNotificationCenter *keydoardNotification;
    
    CGFloat keyboardHeight;
    
}

//
// property
//
@property (nonatomic, copy)   CitrusTouchSearchBarBlock suggestBlock;
@property (nonatomic, copy)   CitrusTouchSearchBarBlock searchBlock;
@property (nonatomic, retain) NSArray<NSString *> *_suggestList;
@property (nonatomic, retain) UITableView *_tableView;
@property (nonatomic, retain) NSNotificationCenter *keydoardNotification;
@property (nonatomic, assign) CGFloat keyboardHeight;

//
// method
//

// 検索結果表示
- (void)showKeywords:(NSArray<NSString *> *)suggestList;

// 検索結果非表示
- (void)hideKeywords;


@end
