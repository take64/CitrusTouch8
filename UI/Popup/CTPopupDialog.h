//
//  CTPopupDialog.h
//  FriendConnection
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
    
    CitrusTouchCompleteBlock successBlock;
    CitrusTouchCompleteBlock cancelBlock;
    
    CTButton *successButton;
    CTButton *cancelButton;
    
}

//
// property
//
@property (nonatomic, retain) CTControl *contentView;
@property (nonatomic, assign) CGRect contentArea;
@property (nonatomic, retain) UIView *_parentView;
@property (nonatomic, copy  ) CitrusTouchCompleteBlock successBlock;
@property (nonatomic, copy  ) CitrusTouchCompleteBlock cancelBlock;
@property (nonatomic, retain) CTButton *successButton;
@property (nonatomic, retain) CTButton *cancelButton;

//
// method
//

// 初期化
- (id)initWithParentView:(UIView *)parentView;

// 初期化
- (id)initWithParentView:(UIView *)parentView frame:(CGRect)frameRect;

// 表示
- (void)show;

// 非表示
- (void)hide;

@end
