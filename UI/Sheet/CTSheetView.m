//
//  CTSheetView.m
//  CitrusTouch
//
//  Created by TAKEMOTO KOUHEI on 2012/11/27.
//  Copyright (c) 2012年 citrus.tk. All rights reserved.
//

#import "CTSheetView.h"

@implementation CTSheetView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/


//
// method
//

// 表示
- (void) show
{
    
}

// 非表示
- (void) hide
{
    
}

// 値変更時(前後ボタン)
- (void) onChangeSegmentedPrevNext:(UISegmentedControl *)segmentedControl
{
    
}

// レスポンダ設定(前へ)
- (void) setResponderPrev:(id)cellTextField
{
    
}

// レスポンダ設定(次へ)
- (void) setResponderNext:(id)cellTextField
{
    
}

// リフレッシュ(前後ボタン)
- (void) refreshSegmentedPrevNext
{
    
}

@end
