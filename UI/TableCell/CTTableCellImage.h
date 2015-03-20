//
//  CTTableCellImage.h
//  CitrusTouch
//
//  Created by TAKEMOTO KOUHEI on 2012/11/27.
//  Copyright (c) 2012年 citrus.tk. All rights reserved.
//

#import "CTTableCellImage.h"

@interface CTTableCellImage : CTTableCell
{
    NSData *_imageData;
    UIImage *_image;
    UIImageView *_imageView;
}

//
// property
//
@property (nonatomic, retain) NSData *_imageData;
@property (nonatomic, retain) UIImage *_image;
@property (nonatomic, retain) UIImageView *_imageView;



//
// method
//

// 画像設定
- (void)setImageData:(NSData *)dataValue;

//// 初期化
//- (id) initWithPrefix:(NSString *)prefixString content:(BOOL)boolValue reuseIdentifier:(NSString *)reuseIdentifier;

//// 値取得
//- (BOOL) onBool;
//// 値設定
//- (void) setOn:(BOOL)boolValue;
//
//// イベント設定
//- (void) addTarget:(id)idValue action:(SEL)selValue forControlEvents:(UIControlEvents)controlEventsValue;

@end
