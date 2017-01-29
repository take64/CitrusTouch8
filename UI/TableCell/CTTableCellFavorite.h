//
//  CTTableCellFavorite.h
//  ChinottoPod
//
//  Created by kouhei.takemoto on 2017/01/07.
//  Copyright © 2017年 citrus.live. All rights reserved.
//

#import "CTTableCellLabel.h"

@interface CTTableCellFavorite : CTTableCellLabel
{
    // complete
    CitrusTouchSwitchBlock switchBlock;
    
    // switch
    BOOL on;
}

//
// property
//
@property (nonatomic, copy)   CitrusTouchSwitchBlock switchBlock;
@property (nonatomic, assign, getter=isOn) BOOL on;


//
// method
//

// スイッチ
- (void)switchOn:(BOOL)onValue;


@end
