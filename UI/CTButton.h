//
//  CTButton.h
//  CitrusTouch
//
//  Created by TAKEMOTO KOUHEI on 2012/10/02.
//  Copyright (c) 2012年 citrus.tk. All rights reserved.
//

#import "CTControl.h"

@class CTButton;

typedef void (^CTButtonTappedBlock)(CTButton *buttonValue);

@interface CTButton : CTControl
{
    // ボタン押下時ブロック
    CTButtonTappedBlock tappedBlock;
}

//
// property
//
@property (nonatomic, copy) CTButtonTappedBlock tappedBlock;

//
// method
//

// ボタン押下時ブロック
- (void) setOnTappedComplete:(CTButtonTappedBlock)completeBLock;

// ボタン押下時
- (void) onTapButton:(CTButton *)buttonValue;

@end
