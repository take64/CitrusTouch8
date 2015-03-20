//
//  CTImage.m
//  PStamp
//
//  Created by Take on 13/02/15.
//  Copyright (c) 2013年 naissance sapporo. co., ltd. All rights reserved.
//

#import "CTImage.h"

@implementation CTImage

// 画像の回転
+ (UIImage *) rotateImage:(UIImage *)sourceImage angle:(CGFloat)angle
{
    CGFloat radian = (angle * M_PI / 180);
    
	// calculate the size of the rotated view's containing box for our drawing space
	UIView *rotatedViewBox = [[UIView alloc] initWithFrame:CGRectMake(0,0,sourceImage.size.width, sourceImage.size.height)];
	CGAffineTransform t = CGAffineTransformMakeRotation(radian);
	rotatedViewBox.transform = t;
	CGSize rotatedSize = rotatedViewBox.frame.size;
	
	// Create the bitmap context
	UIGraphicsBeginImageContext(rotatedSize);
	CGContextRef bitmap = UIGraphicsGetCurrentContext();
	
	// Move the origin to the middle of the image so we will rotate and scale around the center.
	CGContextTranslateCTM(bitmap, rotatedSize.width/2, rotatedSize.height/2);
	
	//   // Rotate the image context
	CGContextRotateCTM(bitmap, radian);
	
	// Now, draw the rotated/scaled image into the context
	CGContextScaleCTM(bitmap, 1.0, -1.0);
	CGContextDrawImage(bitmap, CGRectMake(-sourceImage.size.width / 2, -sourceImage.size.height / 2, sourceImage.size.width, sourceImage.size.height), [sourceImage CGImage]);
	
	UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return newImage;
}

// サイズ変更
+ (UIImage *)resizeFromImage:(UIImage *)image size:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *resizedImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return resizedImage;
}

// サイズ変更(横幅から)
+ (UIImage *)resizeAspectFromImage:(UIImage *)image width:(CGFloat)width
{
    CGFloat sourceWidth = image.size.width;
    CGFloat sourceHeihgt = image.size.height;
    
    CGFloat height = sourceHeihgt * (width / sourceWidth);
    
    return [self resizeFromImage:image size:CGSizeMake(width, height)];
}

// サイズ変更(高さから)
+ (UIImage *)resizeAspectFromImage:(UIImage *)image height:(CGFloat)height
{
    CGFloat sourceWidth = image.size.width;
    CGFloat sourceHeihgt = image.size.height;
    
    CGFloat width = sourceWidth * (height / sourceHeihgt);
    
    return [self resizeFromImage:image size:CGSizeMake(width, height)];
}

// サイズ取得(横幅から)
+ (CGSize)sizeAspectFromImage:(CGSize)imageSize width:(CGFloat)width
{
    CGFloat sourceWidth = imageSize.width;
    CGFloat sourceHeihgt = imageSize.height;
    
    CGFloat height = sourceHeihgt * ((double)width / sourceWidth);
    
    return CGSizeMake(width, height);
    
}

// サイズ変更(高さから)
+ (CGSize)sizeAspectFromImage:(CGSize)imageSize height:(CGFloat)height
{
    CGFloat sourceWidth = imageSize.width;
    CGFloat sourceHeihgt = imageSize.height;
    
    CGFloat width = sourceWidth * ((double)height / sourceHeihgt);
    
    return CGSizeMake(width, height);
}
@end
