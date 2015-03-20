//
//  CTColor.h
//  Panel15
//
//  Created by TAKEMOTO KOUHEI on 2012/10/01.
//  Copyright (c) 2012年 citrus.tk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CTColor : UIColor

// 16進数カラー からCTColor(UIColor) オブジェクトを取得
+ (CTColor *) colorWithHEXString:(NSString *)hexString;

// 16進数カラー からCTColor(UIColor) オブジェクトを取得(透過色付き)
+ (CTColor *) colorWithHEXString:(NSString *)hexString alpha:(CGFloat)alpha;

@end
