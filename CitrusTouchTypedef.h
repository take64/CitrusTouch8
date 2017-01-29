//
//  CitrusTouchTypedef.h
//  CitrusTouch
//
//  Created by take64 on 12/01/06.
//  Copyright (c) 2012 citrus.tk. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CTProgress;

#ifndef CitrusTouch_CitrusTouchTypedef_h
#define CitrusTouch_CitrusTouchTypedef_h


// 汎用ブロック
typedef void (^CitrusTouchBlock)(void);
typedef void (^CitrusTouchCompleteBlock)(id userInfo, NSError *error);
typedef void (^CitrusTouchProgressBlock)(CTProgress *progress, NSError *error);
typedef void (^CitrusTouchSwitchBlock)(NSNumber *switchValue);

#endif
