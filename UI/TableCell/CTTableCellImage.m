//
//  CTTableCellImage.m
//  CitrusTouch
//
//  Created by take64 on 2012/11/27.
//  Copyright (c) 2012年 citrus.tk. All rights reserved.
//

#import "CTTableCellImage.h"

@implementation CTTableCellImage

//
// synthesize
//
@synthesize _imageData;
@synthesize _image;
@synthesize _imageView;


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 未レイアウトの場合
    if([self isSubLayout] == NO)
    {
        CGPoint centerPoint = [[self contentView] center];
//        centerPoint.x += CL8(8);
        
        [[self _imageView] setCenter:centerPoint];
//        [[self _imageView] setFrame:CGRectOffset(CGRectInset([self contentFrame], 8, 4), 0, -2)];
        
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
        // イメージ
        [self set_imageView:[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)]];
        [self set_image:[[UIImage alloc] init]];
//        [[self contentView] addSubview:[[UIImageView alloc] initWithImage:[self _image]]];
        
        // テキストフィールド
//        [[self _image] setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
//        [[self _switch] setAutoresizingMask:(UIViewAutoresizingFlexibleLeftMargin |
//                                                UIViewAutoresizingFlexibleRightMargin |
//                                                UIViewAutoresizingFlexibleTopMargin |
//                                                UIViewAutoresizingFlexibleBottomMargin |
//                                                UIViewAutoresizingFlexibleWidth	|
//                                                UIViewAutoresizingFlexibleHeight)];
//        [[self contentView] addSubview:[self _image]];
        
        
        // セル選択
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        // タッチイベントは透過
//        [self setUserInteractionEnabled:NO];
    }
    return self;
}

// 画像設定
- (void)setImageData:(NSData *)dataValue
{
    [self set_imageData:dataValue];
    [self set_image:[UIImage imageWithData:dataValue]];
//    [self set_imageView:[[UIImageView alloc] initWithImage:[self _image]]];
    [[self _imageView] setImage:[self _image]];
    [[self _imageView] layoutIfNeeded];
    [[self contentView] addSubview:[self _imageView]];
}
//// 初期化
//- (id) initWithPrefix:(NSString *)prefixString content:(BOOL)boolValue reuseIdentifier:(NSString *)reuseIdentifier
//{
//    
//    self = [self initWithPrefix:prefixString suffix:nil reuseIdentifier:reuseIdentifier];
//    if(self)
//    {
////        [self setOn:boolValue];
//    }
//    return self;
//}

//// 値取得
//- (BOOL) onBool
//{
//    return [[self _switch] isOn];
//}
//// 値設定
//- (void) setOn:(BOOL)boolValue
//{
//    [[self _switch] setOn:boolValue];
//}
//
//// イベント設定
//- (void) addTarget:(id)idValue action:(SEL)selValue forControlEvents:(UIControlEvents)controlEventsValue
//{
//    [[self _switch] addTarget:idValue action:selValue forControlEvents:controlEventsValue];
//}

@end
