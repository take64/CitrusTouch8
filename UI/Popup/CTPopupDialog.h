//
//  CTPopupDialog.h
//  CitrusTouch
//
//  Created by TAKEMOTO KOUHEI on 2014/03/15.
//  Copyright (c) 2014年 citrus.tk. All rights reserved.
//

#import "CTControl.h"
#import "CitrusTouchTypedef.h"

@interface CTPopupDialog : CTControl
{
    CTControl *contentView;
    CGRect contentArea;
    
    UIView *_parentView;
    
    CitrusTouchBlock successBlock;
    CitrusTouchBlock failureBlock;
    
    CTButton *successButton;
    CTButton *failureButton;
    
}

//
// property
//
@property (nonatomic, retain) CTControl *contentView;
@property (nonatomic, assign) CGRect contentArea;
@property (nonatomic, retain) UIView *_parentView;
@property (nonatomic, copy  ) CitrusTouchBlock successBlock;
@property (nonatomic, copy  ) CitrusTouchBlock failureBlock;
@property (nonatomic, retain) CTButton *successButton;
@property (nonatomic, retain) CTButton *failureButton;

//
// method
//

// 初期化
- (id)initWithFrame:(CGRect)frame;

// 表示
- (void)showWithParentView:(UIView *)parentView;

// 非表示
- (void)hide;

// ボタン押下時(OK)
- (void)onTapButtonSuccess;

// ボタン押下時(NG)
- (void)onTapButtonFailure;
@end
