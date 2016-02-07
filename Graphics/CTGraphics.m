//
//  CTGraphics.m
//  CitrusTouch
//
//  Created by take64 on 2016/02/06.
//  Copyright © 2016年 citrus.tk. All rights reserved.
//

#import "CTGraphics.h"

@implementation CTGraphics


// 線分
+ (void)drawLine:(CGContextRef)context fromPoint:(CGPoint)fromPoint toPoint:(CGPoint)toPoint
{
    CGContextSaveGState(context);

    CGContextMoveToPoint(context, fromPoint.x, fromPoint.y);
    CGContextAddLineToPoint(context, toPoint.x, toPoint.y);

    CGContextStrokePath(context);

    CGContextRestoreGState(context);
}

// 丸
+ (void)drawCircle:(CGContextRef)context point:(CGPoint)point size:(CGFloat)size
{
    CGContextSaveGState(context);
    
    CGContextStrokeEllipseInRect(context, CGRectMake(point.x - (size / 2), point.y - (size / 2), size, size));
    CGContextFillEllipseInRect(context, CGRectMake(point.x - (size / 2), point.y - (size / 2), size, size));
    
    CGContextRestoreGState(context);
}


@end
