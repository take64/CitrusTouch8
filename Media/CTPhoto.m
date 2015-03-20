//
//  CTPhoto.m
//  PStamp
//
//  Created by Take on 13/02/15.
//  Copyright (c) 2013年 naissance sapporo. co., ltd. All rights reserved.
//

#import "CTPhoto.h"

@implementation CTPhoto

// Exif情報から回転各を取得して、回転処理させる
+ (UIImage *) rotateNormalizeImage:(UIImage *)imageValue
{
    // 回転角取得
    UIImageOrientation imageOrientation = [imageValue imageOrientation];
    
    // 回転角取得
    CGFloat angle = 0;
    switch (imageOrientation) {
        case UIImageOrientationRight:   angle =  90;    break;
        case UIImageOrientationLeft:    angle = 270;    break;
        case UIImageOrientationDown:    angle = 180;    break;
        default:                                        break;
    }
    
    // 回転の必要なし
    if(angle == 0)
    {
        return imageValue;
    }
    
    return [CTImage rotateImage:imageValue angle:angle];
}

@end
