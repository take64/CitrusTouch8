//
//  CTView.m
//  CitrusTouch
//
//  Created by kouhei.takemoto on 2016/04/25.
//  Copyright © 2016年 citrus.tk. All rights reserved.
//

#import "CTView.h"

@implementation CTView

// 初期化
- (instancetype)initWithText:(NSString *)textString
{
    self = [self initWithFrame:CGRectZero];
    if(self)
    {
        
    }
    return self;
}
// 初期化
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        [self setUserInteractionEnabled:NO];
    }
    return self;
}


@end
