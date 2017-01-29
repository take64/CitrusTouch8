//
//  CitrusTouchBase.h
//  CitrusTouch
//
//  Created by take64 on 2012/10/30.
//  Copyright (c) 2012年 citrus.tk. All rights reserved.
//

#ifndef CitrusTouch_CitrusTouchBase_h
#define CitrusTouch_CitrusTouchBase_h

#import "CTDate.h"
#import "CTNVL.h"
#import "CTEmptyVL.h"
#import "CTString.h"
#import "CTCrypt.h"
#import "CTRegexp.h"
#import "CTMath.h"
#import "CTProgress.h"

#import "CTSectionDatastore.h"
#import "CTCollection.h"

#endif

#define CELL08 8
#define CL8(key) (CELL08 * key)
#define CL8Str(key) [@(CELL08 * key) stringValue]

// nil
#define CTNil [NSNull null]

// zero
#define CTDecimalZero [NSDecimalNumber zero]

// from string
#define CTDecimalFromString(key) [NSDecimalNumber decimalNumberWithString:key]

// string from float
#define CTStringFromFloat(key) [@(key) stringValue]

// logger
//#ifdef DEBUG
#define CTLog(...) NSLog(__VA_ARGS__)
//#else
//#define CTLog(...)
//#endif
