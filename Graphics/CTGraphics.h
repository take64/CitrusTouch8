//
//  CTGraphics.h
//  CitrusTouch
//
//  Created by take64 on 2016/02/06.
//  Copyright © 2016年 citrus.tk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTGraphics : NSObject

// 線分
+ (void)drawLine:(CGContextRef)context fromPoint:(CGPoint)fromPoint toPoint:(CGPoint)toPoint;

// 丸
+ (void)drawCircle:(CGContextRef)context point:(CGPoint)point size:(CGFloat)size;

@end
