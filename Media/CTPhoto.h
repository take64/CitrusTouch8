//
//  CTPhoto.h
//  PStamp
//
//  Created by Take on 13/02/15.
//  Copyright (c) 2013年 naissance sapporo. co., ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CitrusTouchMedia.h"

@interface CTPhoto : NSObject


// Exif情報から回転各を取得して、回転処理させる
+ (UIImage *) rotateNormalizeImage:(UIImage *)imageValue;


@end
