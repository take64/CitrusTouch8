//
//  CTTableViewController.h
//  HanayuAccountBook
//
//  Created by kouhei.takemoto on 2016/04/20.
//  Copyright © 2016年 citrus.tk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CTTableViewController : UITableViewController
{
    // ヘッダタイトル
    NSArray *headTitles;
    
    // セクション内セル数
    NSArray *rowOfSection;
    
    // ヘッダビューキャッシュ
    NSMutableDictionary *headViewCaches;
}

//
// property
//
@property (nonatomic, retain) NSArray *headTitles;
@property (nonatomic, retain) NSArray *rowOfSection;
@property (nonatomic, retain) NSMutableDictionary *headViewCaches;

@end
