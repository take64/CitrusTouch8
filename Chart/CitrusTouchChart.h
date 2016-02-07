//
//  CitrusTouchChart.h
//  CitrusTouch
//
//  Created by take64 on 2013/02/28.
//  Copyright (c) 2013年 citrus.tk. All rights reserved.
//

#ifndef CitrusTouch_CitrusTouchChart_h
#define CitrusTouch_CitrusTouchChart_h

#import "CTChart.h"

#import "CTChartLine.h"
#import "CTChartPie.h"

#import "CTChartData.h"
#import "CTChartList.h"


// padding
typedef struct {
    CGFloat topPadding;
    CGFloat rightPadding;
    CGFloat bottomPadding;
    CGFloat leftPadding;
} CTChartPadding;

// line style
typedef struct {
    CGFloat lineWidth;
    CGFloat colorRed;
    CGFloat colorGreen;
    CGFloat colorBule;
    CGFloat colorAlpha;
} CTChartLineStyle;


// degree text format
typedef enum {
    CTChartDegreeTextFormatTypeText,
    CTChartDegreeTextFormatTypeDate,
} CTChartDegreeTextFormatType;

//// degree text style
//typedef struct {
//    NSString *fontName;
//    NSTextAlignment textAlignment;
//    CTChartDegreeTextFormatType textTypeFormat;
//    
//    NSString *textFormat;
//    NSDateFormatter *dateFormat;
//    
//    
//} CTChartDegreeTextStyle;

#endif
