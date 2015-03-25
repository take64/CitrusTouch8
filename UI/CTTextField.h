//
//  CTTextField.h
//  CitrusTouch
//
//  Created by TAKEMOTO KOUHEI on 11/12/07.
//  Copyright (c) 2011 citrus.tk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CTTextField : UITextField
{
    // メニュー表示
    BOOL enableMenu;
    
    // ツールバー
    UIToolbar *toolbar;
}

//
// property
//
@property (nonatomic, assign) BOOL enableMenu;
@property (nonatomic, retain) UIToolbar *toolbar;

@end
