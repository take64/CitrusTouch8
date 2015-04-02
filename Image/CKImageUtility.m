//
//  CKImageUtility.m
//  CitrusTouch
//
//  Created by TAKEMOTO KOUHEI on 2012/10/08.
//  Copyright (c) 2012年 citrus.tk. All rights reserved.
//

#import "CKImageUtility.h"

@implementation CKImageUtility

// サイズ変更
+ (UIImage *)resizeFromImage:(UIImage *)image size:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *resizedImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return resizedImage;
}


// トリム
+ (UIImage *)trimFromImage:(UIImage *)image rect:(CGRect)rect
{
    CGImageRef srcImageRef = [image CGImage];
    CGImageRef trimmedImageRef = CGImageCreateWithImageInRect(srcImageRef, rect);
    UIImage *trimmedImage = [UIImage imageWithCGImage:trimmedImageRef];
    
//    CGImageRelease(srcImageRef);
    CGImageRelease(trimmedImageRef);
    
    return trimmedImage;
}

@end
