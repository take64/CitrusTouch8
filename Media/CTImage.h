//
//  CTImage.h
//  PStamp
//
//  Created by Take on 13/02/15.
//  Copyright (c) 2013年 naissance sapporo. co., ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CitrusTouchMedia.h"

@interface CTImage : NSObject

// 画像の回転
+ (UIImage *) rotateImage:(UIImage *)sourceImage angle:(CGFloat)angle;

// サイズ変更
+ (UIImage *)resizeFromImage:(UIImage *)image size:(CGSize)size;

// サイズ変更(横幅から)
+ (UIImage *)resizeAspectFromImage:(UIImage *)image width:(CGFloat)width;

// サイズ変更(高さから)
+ (UIImage *)resizeAspectFromImage:(UIImage *)image height:(CGFloat)height;

// サイズ取得(横幅から)
+ (CGSize)sizeAspectFromImage:(CGSize)imageSize width:(CGFloat)width;

// サイズ変更(高さから)
+ (CGSize)sizeAspectFromImage:(CGSize)imageSize height:(CGFloat)height;

@end
