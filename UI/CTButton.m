//
//  CTButton.m
//  CitrusTouch
//
//  Created by TAKEMOTO KOUHEI on 2012/10/02.
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
    [self addTarget:self action:@selector(onTapButton:) forControlEvents:UIControlEventTouchUpInside];
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
