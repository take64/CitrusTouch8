//
//  CTTableGroupedHead.h
//  CitrusTouch
//
//  Created by TAKEMOTO KOUHEI on 2013/02/16.
//  Copyright (c) 2013年 citrus.tk. All rights reserved.
//

#import "CTControl.h"

@interface CTTableGroupedHead : CTControl
{
    // セルビュー
    CTControl *cellView;
    
    // タイトル
    CTLabel *titleLabel;
    
    // tintColor
    CTColor *tintColor;
}

//
// property
//
@property (nonatomic, retain) CTControl *cellView;
@property (nonatomic, retain) CTLabel *titleLabel;
@property (nonatomic, retain) CTColor *tintColor;


@end
