//
//  CTPopupDialog.h
//  CitrusTouch
//
//  Created by take64 on 2014/03/15.
//  Copyright (c) 2014年 citrus.tk. All rights reserved.
//

#import "CTControl.h"
#import "CitrusTouchTypedef.h"

static NSString *CTPopupDialogTypeYESNO = @"YESNO";
static NSString *CTPopupDialogTypeOK    = @"OK";

@interface CTPopupDialog : CTControl
{
    CTControl *contentView;
    CGRect contentFrame;
    CGRect innerFrame;
    
    CTLabel *titleLabel;
    
    UIView *_parentView;
    
    CitrusTouchBlock successBlock;
    CitrusTouchBlock failureBlock;
    
    CTButton *successButton;
    CTButton *failureButton;
    
    NSString *dialogType;
    
}

//
// property
//
@property (nonatomic, retain) CTControl *contentView;
@property (nonatomic, assign) CGRect contentFrame;
@property (nonatomic, assign) CGRect innerFrame;
@property (nonatomic, retain) CTLabel *titleLabel;
@property (nonatomic, retain) UIView *_parentView;
@property (nonatomic, copy  ) CitrusTouchBlock successBlock;
@property (nonatomic, copy  ) CitrusTouchBlock failureBlock;
@property (nonatomic, retain) CTButton *successButton;
@property (nonatomic, retain) CTButton *failureButton;
@property (nonatomic, retain) NSString *dialogType;

//
// method
//

// 初期化
- (id)initWithFrame:(CGRect)frame;
- (id)initWithFrame:(CGRect)frame type:(NSString *)typeValue;

// 表示
- (void)showWithParentView:(UIView *)parentView;

// 非表示
- (void)hide;

// ボタン押下時(OK)
- (void)onTapButtonSuccess;

// ボタン押下時(NG)
- (void)onTapButtonFailure;

// タイトル設定
- (void)setTitle:(NSString *)titleValue;
@end
