//
//  CitrusTouchUIStruct.h
//  CitrusTouch
//
//  Created by TAKEMOTO KOUHEI on 2013/03/07.
//  Copyright (c) 2013年 citrus.tk. All rights reserved.
//

//#ifndef CitrusTouch_CitrusTouchUIStruct_h
//#define CitrusTouch_CitrusTouchUIStruct_h

#import <Foundation/NSObjCRuntime.h>

typedef struct {
    CGFloat top;
    CGFloat right;
    CGFloat bottom;
    CGFloat left;
} CTPadding;

NS_INLINE CTPadding CTPaddingMake(CGFloat top, CGFloat right, CGFloat bottom, CGFloat left)
{
    CTPadding padding = {top, right, bottom, left};
    return padding;
}



//#endif
