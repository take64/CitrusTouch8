//
//  CTEditFoot.h
//  LorsPOS2
//
//  Created by Take on 13/12/29.
//  Copyright (c) 2013年 naissance sapporo co,.Ltd. All rights reserved.
//

#import "CTControl.h"

@class CTButton;

@interface CTEditFoot : CTControl
{
    // ボタン
    CTButton *removeButton;     // 削除
    CTButton *rebirthButton;    // 復活
    
    NSNumber *status;           // ステータス
}

//
// property
//
@property (nonatomic, retain) CTButton *removeButton;
@property (nonatomic, retain) CTButton *rebirthButton;
@property (nonatomic, retain) NSNumber *status;

//
// method
//

// ステータスの設定
- (void)loadStatus:(NSNumber *)numberValue;


@end
