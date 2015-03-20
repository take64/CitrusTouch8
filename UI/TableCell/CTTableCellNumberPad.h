//
//  CTTableCellNumberPad.h
//  CitrusTouch
//
//  Created by TAKEMOTO KOUHEI on 2012/11/28.
//  Copyright (c) 2012年 citrus.tk. All rights reserved.
//


#import "CTTableCellTextField.h"

typedef NS_ENUM(NSInteger, CTTableCellNumberPadMode) {
    CTTableCellNumberPadModeNumber,
    CTTableCellNumberPadModeDecimal
};

@interface CTTableCellNumberPad : CTTableCellTextField
{
    // パッキングビュー
    UIView *inputPackingView;
}

//
// property
//
@property (nonatomic, retain) UIView *inputPackingView;


//
// method
//

// 初期化
- (id) initWithPrefix:(NSString *)prefixString content:(NSString *)decimalString suffix:(NSString *)suffixString reuseIdentifier:(NSString *)reuseIdentifier;

@end
