//
//  CKImageUtility.h
//  Panel15
//
//  Created by TAKEMOTO KOUHEI on 2012/10/08.
//  Copyright (c) 2012年 citrus.tk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CKImageUtility : NSObject

// サイズ変更
+ (UIImage *)resizeFromImage:(UIImage *)image size:(CGSize)size;

// トリム
+ (UIImage *)trimFromImage:(UIImage *)image rect:(CGRect)rect;

@end
