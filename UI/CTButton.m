//
//  CTButton.m
//  CitrusTouch
//
//  Created by take64 on 2012/10/02.
//  Copyright (c) 2012年 citrus.tk. All rights reserved.
//

#import "CTButton.h"

#import "CitrusTouchResource.h"

@implementation CTButton

//
// synthesize
//
@synthesize tappedBlock;


// 初期化
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setExclusiveTouch:YES];
        
        // 基本のボタンON
        [self addTarget:self action:@selector(onTapButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}



//
// method
//

// ボタン押下時ブロック
- (void) setOnTappedComplete:(CTButtonTappedBlock)completeBlock
{
    // 設定
    [self setTappedBlock:completeBlock];
}

// ボタン押下時
- (void) onTapButton:(CTButton *)buttonValue
{
    [CTSound playButtonSound];
    
    if(self.tappedBlock != nil)
    {
        self.tappedBlock(buttonValue);
    }
}

@end
