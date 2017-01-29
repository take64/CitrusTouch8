//
//  CTTableGroupedHead.h
//  CitrusTouch
//
//  Created by take64 on 2013/02/16.
//  Copyright (c) 2013年 citrus.tk. All rights reserved.
//

#import "CTControl.h"

@interface CTTableGroupedHead : CTControl
{
    // セルビュー
    CTControl *cellView;
}

//
// property
//
@property (nonatomic, retain) CTControl *cellView;

//
// method
//

// テキストの設定
- (void)setText:(NSString *)textString;

// 色の設定
- (void)setTintColor:(NSString *)tintColorString;

@end
