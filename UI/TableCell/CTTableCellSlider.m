//
//  CTTableCellSlider.m
//  CitrusTouch
//
//  Created by TAKEMOTO KOUHEI on 2012/11/27.
//  Copyright (c) 2012年 citrus.tk. All rights reserved.
//

#import "CTTableCellSlider.h"

@implementation CTTableCellSlider

//
// synthesize
//
@synthesize slider;


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 未レイアウトの場合
    if([self isSubLayout] == NO)
    {
        [[self slider] setFrame:CGRectOffset(CGRectInset([self contentFrame], 8, 4), 0, -2)];
        
        // レイアウト済み
        [self setSubLayout:YES];
    }
}




#pragma mark -
#pragma mark method
//
// method
//

// 初期化
- (id) initWithPrefix:(NSString *)prefixString suffix:(NSString *)suffixString reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithPrefix:prefixString suffix:suffixString reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self setSlider:[[UISlider alloc] init]];
        [[self contentView] addSubview:[self slider]];
    }
    return self;
}

// 初期化
- (id) initWithPrefix:(NSString *)prefixString content:(NSString *)textString suffix:(NSString *)suffixString reuseIdentifier:(NSString *)reuseIdentifier
{
    
    self = [self initWithPrefix:prefixString suffix:suffixString reuseIdentifier:reuseIdentifier];
    if(self)
    {
    }
    return self;
}

// 値取得
- (float) value
{
    return [[self slider] value];
}
// 値設定
- (void) setValue:(float)floatValue
{
    [[self slider] setValue:floatValue];
}

// 値取得
- (float) minimumValue
{
    return [[self slider] minimumValue];
}
// 値設定
- (void) setMinimumValue:(float)floatValue
{
    [[self slider] setMinimumValue:floatValue];
}

// 値取得
- (float) maximumValue
{
    return [[self slider] maximumValue];
}
// 値設定
- (void) setMaximumValue:(float)floatValue
{
    [[self slider] setMaximumValue:floatValue];
}


@end
