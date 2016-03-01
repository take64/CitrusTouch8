//
//  CTChartLine.m
//  CitrusTouch
//
//  Created by take64 on 2013/02/28.
//  Copyright (c) 2013年 citrus.tk. All rights reserved.
//

#import "CTChartLine.h"

#import "CTChart.h"
#import "CTChartList.h"
#import "CTChartData.h"

#import "CTGraphics.h"
#import "CTColor.h"

@implementation CTChartLine

//
// synthesize
//
@synthesize dataList;

// 初期化
- (id)initWithFrame:(CGRect)frame data:(NSArray<CTChartList *> *)dataValue
{
    self = [super initWithFrame:frame];
    if(self)
    {
        [self loadData:dataValue];
    }
    return self;
}

// データ読み込み
- (void)loadData:(NSArray<CTChartList *> *)dataValue
{
    [self setDataList:dataValue];
}
//
////
//// synthesize
////
//@synthesize xAxisTitles;
//@synthesize xAxisFrame;
//@synthesize xAxisMainInterval;
//@synthesize xAxisSubInterval;
//@synthesize xAxisMainLineLength;
//@synthesize xAxisSubLineLength;
//
//@synthesize yAxesLeftWidth;
//@synthesize yAxesRightWidth;
//@synthesize xAxisBottomWidth;
//
//@synthesize yAxesLeftLists;
//@synthesize yAxesRightLists;
//@synthesize yAxesLeftFrame;
//@synthesize yAxesRightFrame;
//@synthesize yAxesLeftMainInterval;
//@synthesize yAxesLeftSubInterval;
//@synthesize yAxesRightMainInterval;
//@synthesize yAxesRightSubInterval;
//@synthesize yAxesLeftMainLineLength;
//@synthesize yAxesLeftSubLineLength;
//@synthesize yAxesRightMainLineLength;
//@synthesize yAxesRightSubLineLength;
//
//@synthesize yAxesLeftLineStrokeColors;
//@synthesize yAxesLeftLineFillColors;
//@synthesize yAxesRightLineStrokeColors;
//@synthesize yAxesRightLineFillColors;
//
//@synthesize yAxesLeftRange;
//@synthesize yAxesRightRange;
//
//@synthesize gridColor;
//
//@synthesize chartFrame;
//@synthesize chartAreaPadding;
//
//
//- (id)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        
//        // 背景
//        [self setBackgroundColor:[UIColor whiteColor]];
//        
//    }
//    return self;
//}

- (void)drawRect:(CGRect)rect
{
    // データ
    NSArray<CTChartList *> *list = [self dataList];
    
    // 最小値・最大値
    NSNumber *min = @0;
    NSNumber *max = @0;
    for(CTChartList *chartList in list)
    {
        min = @(MIN([min doubleValue], [[chartList minValue] doubleValue]));
        max = @(MAX([max doubleValue], [[chartList maxValue] doubleValue]));
    }
    
    // ソート
    list = [CTCollection sortWithEntityArray:list sort:@[ @{@"maxValue":@NO} ]];
    
    // 色リスト
    NSArray<NSString *> *colorList = [CTChart callColorList];
    NSInteger colorLimit = [colorList count];
    NSInteger colorCount = 0;
    
    // 色設定
    for(CTChartList *chartList in list)
    {
        [chartList setColor:
         [CTColor colorWithHEXString:[colorList objectAtIndex:(colorCount++ % colorLimit)]]
         ];
    }
    
    // PADDING
    CGFloat padding = 20;
    
    
    // コンテクスト
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 透明レイヤー開始
    CGContextBeginTransparencyLayer(context, nil);
    
    // パスの描画を開始
    CGContextBeginPath(context);
    
    
    // 描画
    for(CTChartList *chartList in list)
    {
        // 描画色設定
        CGColorRef cgcolor = [[chartList color] CGColor];
        const CGFloat *colors;
        colors = CGColorGetComponents(cgcolor);
        CGContextSetRGBFillColor(context, colors[0], colors[1], colors[2], colors[3]);
        CGContextSetRGBStrokeColor(context, colors[0], colors[1], colors[2], colors[3]);
        
        CGFloat xOffset = (rect.size.width - padding * 2) / [[chartList dataList] count];
        CGFloat yOffset = (rect.size.height - padding * 2) / ([max doubleValue] - [min doubleValue]);
        CGFloat count = 0;
        CGPoint fromPoint = CGPointZero;
        for(CTChartData *chartData in [chartList dataList])
        {
            CGPoint point = CGPointMake((xOffset * count) + padding, rect.size.height - ((yOffset * [[chartData value] doubleValue]) + padding));
            
//            NSLog(@"x = %f; y = %f", point.x, point.y);
            
            // 線描画
            if(CGPointEqualToPoint(fromPoint, CGPointZero) == NO)
            {
                [CTGraphics drawLine:context fromPoint:fromPoint toPoint:point];
            }
            
            // 丸描画
            [CTGraphics drawCircle:context point:point size:4];
            
            fromPoint = point;
            
            count++;
        }
    }
    
    
    
    // 透明レイヤー終了
    CGContextEndTransparencyLayer(context);
    
//    // ベースのサイズ
//    CGFloat width = rect.size.width;
//    CGFloat height = rect.size.height;
//    
//    // padding
//    CTPadding padding = [self chartAreaPadding];
//    
//    
//    // 左目盛り領域
//    [self setYAxesLeftFrame:CGRectMake(padding.left,
//                                       padding.top,
//                                       [self yAxesLeftWidth],
//                                       height - [self xAxisBottomWidth] - padding.top - padding.bottom)];
//    
//    // 右目盛り領域
//    [self setYAxesRightFrame:CGRectMake(width - [self yAxesLeftWidth] - padding.left,
//                                        padding.top,
//                                        [self yAxesRightWidth],
//                                        height - [self xAxisBottomWidth] - padding.top - padding.bottom)];
//    
//    // 下目盛り領域
//    [self setXAxisFrame:CGRectMake([self yAxesLeftFrame].origin.x + [self yAxesLeftFrame].size.width,
//                                   height - [self xAxisBottomWidth] - padding.top,
//                                   width - [self yAxesLeftWidth] - [self yAxesRightWidth] - padding.left - padding.right,
//                                   [self xAxisBottomWidth])];
//    
//    // グラフ領域
//    [self setChartFrame:CGRectMake([self yAxesLeftFrame].origin.x + [self yAxesLeftFrame].size.width,
//                                   padding.top,
//                                   [self xAxisFrame].size.width,
//                                   height - [self xAxisFrame].size.height - padding.top - padding.bottom)];
//    
//    
//    
//    // テキストカラー
//    CGContextSetRGBFillColor(context, 0, 0, 0, 1);
//        
//    // y軸関係の描画
//    [self drawYAxesLeft:context];
//    [self drawYAxesRight:context];
//    
//    // x軸関係の描画
//    [self drawXAxis:context];
//    
//    // 格子描画
//    [self drawGrid:context];
//    
//    // グラフ領域の描画
//    [self drawChartBackground:context];
//    [self drawChartLeft:context];
//    [self drawChartRight:context];
    
}

#pragma mark -
#pragma mark private
//
// private
//

//// 線分
//- (void) addLine:(CGContextRef)context fromPoint:(CGPoint)fromPoint moveSize:(CGSize)moveSize
//{
//    [self addLine:context fromPoint:fromPoint toPoint:CGPointMake(fromPoint.x + moveSize.width, fromPoint.y + moveSize.height)];
//}
//
//// 線分
//- (void) addLine:(CGContextRef)context fromPoint:(CGPoint)fromPoint toPoint:(CGPoint)toPoint
//{
//    CGContextSaveGState(context);
//    
//    CGContextMoveToPoint(context, fromPoint.x, fromPoint.y);
//    CGContextAddLineToPoint(context, toPoint.x, toPoint.y);
//    
//    CGContextStrokePath(context);
//    
//    CGContextRestoreGState(context);
//}
//
//// X軸関係の描画
//- (void) drawXAxis:(CGContextRef)context
//{
//    CGContextSaveGState(context);
//    
//    
//    // 描画フレーム
////    CGRect frame = [self bounds];
//    CGRect rect = [self xAxisFrame];
//    
////    CGFloat width = frame.size.width;
////    CGFloat height = frame.size.height;
//    
//    
//    
//    // 一旦塗りつぶす
////    CGContextAddRect(context, rect);
////    CGContextSetRGBFillColor(context, 0, 1, 0, 1);
////    CGContextFillPath(context);
//    
//    // 線の太さ
//    CGContextSetLineWidth(context, 2);
//    
//    // 文字色/線色
//    CGContextSetRGBFillColor(context, 0, 0, 0, 1);
//    
//    // 下目盛り
//    [self addLine:context
//        fromPoint:rect.origin
//         moveSize:CGSizeMake(rect.size.width, 0)];
//    
//    
//    
//    
//    // 目盛り作成
//    NSUInteger count = ([[self xAxisTitles] count] - 1);
//    CGFloat lineLength = 0;
//    CGFloat lineOffset = rect.size.width / count;
//    for(double i = 0; i <= count; i++)
//    {
//        if(fmod(i, [self xAxisMainInterval]) == 0)
//        {
//            lineLength = [self xAxisMainLineLength];
//        }
//        else if(fmod(i, [self xAxisSubInterval]) == 0)
//        {
//            lineLength = [self xAxisSubLineLength];
//        }
//        else
//        {
//            continue;
//        }
//        
//        [self addLine:context
//            fromPoint:CGPointMake(rect.origin.x + (lineOffset * i),
//                                  rect.origin.y)
//             moveSize:CGSizeMake(0, lineLength)
//         ];
//    }
//    
//    // 項目作成
//    for (int i = 0; i <= count; i++)
//    {
//        if(fmod(i, [self xAxisMainInterval]) != 0)
//        {
//            continue;
//        }
//        
//        // 文字列要素
//        NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
//        
//        // パラグラフ
//        NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
//        [paragraph setAlignment:NSTextAlignmentCenter];
//        [paragraph setLineBreakMode:NSLineBreakByCharWrapping];
//        
//        
//        // 要素設定
//        [attributes addEntriesFromDictionary:@{NSParagraphStyleAttributeName:paragraph,
//                                               NSFontAttributeName:[UIFont systemFontOfSize:14]
//                                               }];
//        
//        
//        NSString *textString = [[self xAxisTitles] objectAtIndex:i];
//        CGSize textSize = [textString sizeWithAttributes:attributes];
//        [textString drawInRect:CGRectMake(rect.origin.x + (lineOffset * i) - (textSize.width / 2), rect.origin.y + [self xAxisMainLineLength],textSize.width, textSize.height) withAttributes:attributes];
//    }
//    
//    
//    CGContextRestoreGState(context);
//}
//
//
//// Y軸左関係の描画
//- (void) drawYAxesLeft:(CGContextRef)context
//{
//    CGContextSaveGState(context);
//    
//    
//    // 描画フレーム
////    CGRect frame = [self bounds];
//    CGRect rect = [self yAxesLeftFrame];
//    
////    CGFloat width = frame.size.width;
////    CGFloat height = frame.size.height;
//    
//    
//    
//    // 一旦塗りつぶす
////    CGContextAddRect(context, rect);
////    CGContextSetRGBFillColor(context, 1, 0, 0, 1);
////    CGContextFillPath(context);
//    
//    // 線の太さ
//    CGContextSetLineWidth(context, 2);
//    
//    // 文字色/線色
//    CGContextSetRGBFillColor(context, 0, 0, 0, 1);
//    
//    // 左目盛り
//    [self addLine:context
//        fromPoint:CGPointMake(rect.origin.x + rect.size.width, rect.origin.y)
//         moveSize:CGSizeMake(0, rect.size.height)];
//    
//    
//    // レンジ取得
//    NSRange lineRange = [self callYAxesLeftRange];
//    double start    = lineRange.location;
//    double end      = NSMaxRange(lineRange);
//    
//    CGFloat lineLength = 0;
//    CGFloat lineOffset = rect.size.height / (end - start);
//    for(double i = start; i <= end; i+=[self yAxesLeftSubInterval])
//    {
//        if(fmod(i, [self yAxesLeftMainInterval]) == 0)
//        {
//            lineLength = [self yAxesLeftMainLineLength];
//        }
//        else if(fmod(i, [self yAxesLeftSubInterval]) == 0)
//        {
//            lineLength = [self yAxesLeftSubLineLength];
//        }
//        else
//        {
//            continue;
//        }
//        
//        [self addLine:context
//            fromPoint:CGPointMake(rect.origin.x + rect.size.width - lineLength,
//                                  rect.origin.y + rect.size.height - (lineOffset * (i - start)))
//             moveSize:CGSizeMake(lineLength, 0)
//         ];
//    }
//    
//    // 項目作成
//    for(double i = start; i <= end; i+=[self yAxesLeftSubInterval])
//    {
//        if(fmod(i, [self yAxesLeftMainInterval]) != 0)
//        {
//            continue;
//        }
//        
//        
//        // 文字列要素
//        NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
//        
//        // パラグラフ
//        NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
//        [paragraph setAlignment:NSTextAlignmentRight];
//        [paragraph setLineBreakMode:NSLineBreakByCharWrapping];
//        
//        
//        // 要素設定
//        [attributes addEntriesFromDictionary:@{NSParagraphStyleAttributeName:paragraph,
//                                               NSFontAttributeName:[UIFont systemFontOfSize:14]
//                                               }];
//        
//        NSString *textString = [NSString stringWithFormat:@"%.1f", i];
//        CGSize textSize = [textString sizeWithAttributes:attributes];
//        [textString drawInRect:CGRectMake(rect.origin.x + rect.size.width - lineLength - textSize.width,
//                                          rect.origin.y + rect.size.height - (lineOffset * (i - start)) - (textSize.height / 2),
//                                          textSize.width,
//                                          textSize.height)
//                withAttributes:attributes];
////        [textString drawInRect:CGRectMake(rect.origin.x + rect.size.width - lineLength - textSize.width,
////                                          rect.origin.y + rect.size.height - (lineOffset * (i - start)) - (textSize.height / 2),
////                                          textSize.width,
////                                          textSize.height)
////                      withFont:[UIFont systemFontOfSize:14]
////                 lineBreakMode:NSLineBreakByCharWrapping
////                     alignment:NSTextAlignmentRight];
//    }
//    
//    CGContextRestoreGState(context);
//}
//
//// Y軸右関係の描画
//- (void) drawYAxesRight:(CGContextRef)context
//{
//    CGContextSaveGState(context);
//    
//    
//    // 描画フレーム
////    CGRect frame = [self bounds];
//    CGRect rect = [self yAxesRightFrame];
//    
////    CGFloat width = frame.size.width;
////    CGFloat height = frame.size.height;
//    
//    
//    
//    // 一旦塗りつぶす
////    CGContextAddRect(context, rect);
////    CGContextSetRGBFillColor(context, 1, 0, 0, 1);
////    CGContextFillPath(context);
//    
//    // 線の太さ
//    CGContextSetLineWidth(context, 2);
//    
//    // 文字色/線色
//    CGContextSetRGBFillColor(context, 0, 0, 0, 1);
//    
//    // 左目盛り
//    [self addLine:context
//        fromPoint:rect.origin
//         moveSize:CGSizeMake(0, rect.size.height)];
//    
//    
//    // レンジ取得
//    NSRange lineRange = [self callYAxesRightRange];
//    double start    = lineRange.location;
//    double end      = NSMaxRange(lineRange);
//    
//    CGFloat lineLength = 0;
//    CGFloat lineOffset = rect.size.height / (end - start);
//    for(double i = start; i <= end; i+=[self yAxesRightSubInterval])
//    {
//        if(fmod(i, [self yAxesRightMainInterval]) == 0)
//        {
//            lineLength = [self yAxesRightMainLineLength];
//        }
//        else if(fmod(i, [self yAxesRightSubInterval]) == 0)
//        {
//            lineLength = [self yAxesRightSubLineLength];
//        }
//        else
//        {
//            continue;
//        }
//        
//        [self addLine:context
//            fromPoint:CGPointMake(rect.origin.x,
//                                  rect.origin.y + rect.size.height - (lineOffset * (i - start)))
//             moveSize:CGSizeMake(lineLength, 0)
//         ];
//    }
//    
//    // 項目作成
//    for(double i = start; i <= end; i+=[self yAxesRightSubInterval])
//    {
//        if(fmod(i, [self yAxesRightMainInterval]) != 0)
//        {
//            continue;
//        }
//        
//        // 文字列要素
//        NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
//        
//        // パラグラフ
//        NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
//        [paragraph setAlignment:NSTextAlignmentLeft];
//        [paragraph setLineBreakMode:NSLineBreakByCharWrapping];
//        
//        
//        // 要素設定
//        [attributes addEntriesFromDictionary:@{NSParagraphStyleAttributeName:paragraph,
//                                               NSFontAttributeName:[UIFont systemFontOfSize:14]
//                                               }];
//        
//        NSString *textString = [NSString stringWithFormat:@"%.1f", i];
//        CGSize textSize = [textString sizeWithAttributes:attributes];
//        [textString drawInRect:CGRectMake(rect.origin.x + lineLength,
//                                          rect.origin.y + rect.size.height - (lineOffset * (i - start)) - (textSize.height / 2),
//                                          textSize.width,
//                                          textSize.height) withAttributes:attributes];
////        CGSize textSize = [textString sizeWithFont:[UIFont systemFontOfSize:14]];
////        [textString drawInRect:CGRectMake(rect.origin.x + lineLength,
////                                          rect.origin.y + rect.size.height - (lineOffset * (i - start)) - (textSize.height / 2),
////                                          textSize.width,
////                                          textSize.height)
////                      withFont:[UIFont systemFontOfSize:14]
////                 lineBreakMode:NSLineBreakByCharWrapping
////                     alignment:NSTextAlignmentLeft];
//    }
//    
//    CGContextRestoreGState(context);
//}
//
//
//// グラフ(左)の描画
//- (void) drawChartBackground:(CGContextRef)context
//{
//    CGContextSaveGState(context);
//    
//    // 描画フレーム
////    CGRect frame = [self bounds];
////    CGRect rect = [self chartFrame];
//    
//    // 一旦塗りつぶす
////    CGContextAddRect(context, rect);
////    CGContextSetRGBFillColor(context, 0, 0, 1, 0.5);
////    CGContextFillPath(context);
//    
//    
//    CGContextRestoreGState(context);
//}
//
//// グラフ(左)の描画
//- (void) drawChartLeft:(CGContextRef)context
//{
//    CGContextSaveGState(context);
//    
//    
//    // 描画フレーム
////    CGRect frame = [self bounds];
//    CGRect rect = [self chartFrame];
//    
//    
//    // 線キャップ
//    CGContextSetLineCap(context, kCGLineCapRound);
//    CGContextSetLineJoin(context, kCGLineJoinRound);
//    
//    // 線の太さ
//    CGContextSetLineWidth(context, 2);
//    
//    
//    // レンジ取得
//    NSRange lineLeftRange = [self callYAxesLeftRange];
//    double start    = lineLeftRange.location;
//    double end      = NSMaxRange(lineLeftRange);
//    double target;
//    
//    CGFloat xOffset = rect.size.width / ([[self xAxisTitles] count] - 1);
//    CGFloat yOffset = rect.size.height / (end - start);
//    
//    NSMutableArray *routePoints;
//    NSArray *items;
//    CGColorRef colorRef;
//    const CGFloat *colors;
//    
//    // Y軸左描画
//    for(double i = 0; i < [[self yAxesLeftLists] count]; i++)
//    {
//        // アイテムリスト
//        items = [[self yAxesLeftLists] objectAtIndex:i];
//        
//        // 初期化
//        routePoints = [NSMutableArray arrayWithCapacity:1];
//        
//        // ポイント設定
//        for(double j = 0; j < [[self xAxisTitles] count]; j++)
//        {
//            id item = [items objectAtIndex:j];
//        
//            if([item isKindOfClass:[NSNull class]] == YES)
//            {
//                continue;
//            }
//            if([item isKindOfClass:[NSNumber class]] == YES)
//            {
//                target = [(NSNumber *)item doubleValue];
//            }
//            else if([item isKindOfClass:[NSDecimalNumber class]] == YES)
//            {
//                target = [(NSDecimalNumber *)item doubleValue];
//            }
//            else
//            {
//                continue;
//            }
//            [routePoints addObject:[NSValue valueWithCGPoint:CGPointMake((j * xOffset) + rect.origin.x, rect.size.height - ((target - start) * yOffset) + rect.origin.y)]];
//        }
//        
//        // 線色設定(Stroke)
//        colorRef = [[[self yAxesLeftLineStrokeColors] objectAtIndex:i] CGColor];
//        colors = CGColorGetComponents(colorRef);
//        CGContextSetRGBStrokeColor(context, colors[0], colors[1], colors[2], colors[3]);
//        
//        // 線色設定(Fill)
//        colorRef = [[[self yAxesLeftLineFillColors] objectAtIndex:i] CGColor];
//        colors = CGColorGetComponents(colorRef);
//        CGContextSetRGBFillColor(context, colors[0], colors[1], colors[2], colors[3]);
//        
//        
//        CGPoint point;
//        // 線描画
//        for(int j = 0; j < [routePoints count]; j++)
//        {
//            point = [[routePoints objectAtIndex:j] CGPointValue];
//            if(j == 0)
//            {
//                CGContextMoveToPoint(context, point.x, point.y);
//            }
//            else
//            {
//                CGContextAddLineToPoint(context, point.x, point.y);
//            }
//        }
//        CGContextStrokePath(context);
//        
//        // 丸描画
//        for(int i = 0; i < [routePoints count]; i++)
//        {
//            point = [[routePoints objectAtIndex:i] CGPointValue];
//            
//            CGContextStrokeEllipseInRect(context, CGRectMake(point.x - 2, point.y - 2, 4, 4));
//            CGContextFillEllipseInRect(context, CGRectMake(point.x - 2, point.y - 2, 4, 4));
//        }
//    }
//    
//    CGContextRestoreGState(context);
//}
//// グラフ(右)の描画
//- (void) drawChartRight:(CGContextRef)context
//{
//    CGContextSaveGState(context);
//    
//    
//    // 描画フレーム
////    CGRect frame = [self bounds];
//    CGRect rect = [self chartFrame];
//    
//    
//    // 線キャップ
//    CGContextSetLineCap(context, kCGLineCapRound);
//    CGContextSetLineJoin(context, kCGLineJoinRound);
//    
//    // 線の太さ
//    CGContextSetLineWidth(context, 2);
//    
//    
//    // レンジ取得
//    NSRange lineRange = [self callYAxesRightRange];
//    double start    = lineRange.location;
//    double end      = NSMaxRange(lineRange);
//    double target;
//    
//    CGFloat xOffset = rect.size.width / ([[self xAxisTitles] count] - 1);
//    CGFloat yOffset = rect.size.height / (end - start);
//    
//    NSMutableArray *routePoints;
//    NSArray *items;
//    CGColorRef colorRef;
//    const CGFloat *colors;
//    
//    // Y軸右描画
//    for(double i = 0; i < [[self yAxesRightLists] count]; i++)
//    {
//        // アイテムリスト
//        items = [[self yAxesRightLists] objectAtIndex:i];
//        
//        // 初期化
//        routePoints = [NSMutableArray arrayWithCapacity:1];
//        
//        // ポイント設定
//        for(double j = 0; j < [[self xAxisTitles] count]; j++)
//        {
//            id item = [items objectAtIndex:j];
//            
//            if([item isKindOfClass:[NSNull class]] == YES)
//            {
//                continue;
//            }
//            if([item isKindOfClass:[NSNumber class]] == YES)
//            {
//                target = [(NSNumber *)item doubleValue];
//            }
//            else if([item isKindOfClass:[NSDecimalNumber class]] == YES)
//            {
//                target = [(NSDecimalNumber *)item doubleValue];
//            }
//            else
//            {
//                continue;
//            }
//            [routePoints addObject:[NSValue valueWithCGPoint:CGPointMake((j * xOffset) + rect.origin.x, rect.size.height - ((target - start) * yOffset) + rect.origin.y)]];
//        }
//        
//        // 線色設定(Stroke)
//        colorRef = [[[self yAxesRightLineStrokeColors] objectAtIndex:i] CGColor];
//        colors = CGColorGetComponents(colorRef);
//        CGContextSetRGBStrokeColor(context, colors[0], colors[1], colors[2], colors[3]);
//        
//        // 線色設定(Fill)
//        colorRef = [[[self yAxesRightLineFillColors] objectAtIndex:i] CGColor];
//        colors = CGColorGetComponents(colorRef);
//        CGContextSetRGBFillColor(context, colors[0], colors[1], colors[2], colors[3]);
//        
//        
//        CGPoint point;
//        // 線描画
//        for(int j = 0; j < [routePoints count]; j++)
//        {
//            point = [[routePoints objectAtIndex:j] CGPointValue];
//            if(j == 0)
//            {
//                CGContextMoveToPoint(context, point.x, point.y);
//            }
//            else
//            {
//                CGContextAddLineToPoint(context, point.x, point.y);
//            }
//        }
//        CGContextStrokePath(context);
//        
//        // 丸描画
//        for(int i = 0; i < [routePoints count]; i++)
//        {
//            point = [[routePoints objectAtIndex:i] CGPointValue];
//            
//            CGContextStrokeEllipseInRect(context, CGRectMake(point.x - 2, point.y - 2, 4, 4));
//            CGContextFillEllipseInRect(context, CGRectMake(point.x - 2, point.y - 2, 4, 4));
//        }
//    }
//    
//    CGContextRestoreGState(context);
//}
//
//
//// グラフ格子の描画
//- (void) drawGrid:(CGContextRef)context
//{
//    CGContextSaveGState(context);
//    
//    // 描画フレーム
////    CGRect frame = [self bounds];
//    CGRect rect = [self chartFrame];
//    
//    // レンジ計算
//    NSRange lineLeftRange = [self callYAxesLeftRange];
//    double start = lineLeftRange.location;
//    double end   = NSMaxRange(lineLeftRange);
//    
//    
//    // 線色
//    CGColorRef colorRef = [[self gridColor] CGColor];
//    const CGFloat *colors = CGColorGetComponents(colorRef);
//    CGContextSetRGBStrokeColor(context, colors[0], colors[1], colors[2], colors[3]);
//    
//    // X軸件数
//    CGFloat xCount = ([[self xAxisTitles] count] - 1);
//    
//    
//    // オフセット
//    CGFloat yOffset = rect.size.height / (end - start);
//    CGFloat xOffset = rect.size.width / xCount;
//    
//    // Y軸格子描画
//    for(double i = start; i < end; i+=[self yAxesLeftMainInterval])
//    {
//        [self addLine:context
//            fromPoint:CGPointMake(rect.origin.x, rect.origin.y + ((i - start) * yOffset))
//             moveSize:CGSizeMake(rect.size.width, 0)];
//    }
//    
//    // X軸格子描画
//    for(double i = 0; i <= xCount; i+=[self xAxisMainInterval])
//    {
//        [self addLine:context
//            fromPoint:CGPointMake(rect.origin.x + (xOffset * i),
//                                  rect.origin.y)
//             moveSize:CGSizeMake(0, rect.size.height)
//         ];
//    }
//
//    
//    
//    CGContextRestoreGState(context);
//}
//
//// Y軸左レンジ
//- (NSRange) callYAxesLeftRange
//{
//    // レンジ設定されていない場合に生成
//    if(NSEqualRanges([self yAxesLeftRange], NSMakeRange(0, 0)) == YES)
//    {
//        
//        // レンジ計算
//        double maxRange = -1;
//        double minRange = -1;
//        double target;
//        for(NSArray *items in [self yAxesLeftLists])
//        {
//            for(id item in items)
//            {
//                if([item isKindOfClass:[NSNull class]] == YES)
//                {
//                    continue;
//                }
//                if([item isKindOfClass:[NSNumber class]] == YES)
//                {
//                    target = [(NSNumber *)item doubleValue];
//                }
//                else if([item isKindOfClass:[NSDecimalNumber class]] == YES)
//                {
//                    target = [(NSDecimalNumber *)item doubleValue];
//                }
//                else
//                {
//                    continue;
//                }
//                
//                if(maxRange == -1 && minRange == -1)
//                {
//                    maxRange = target;
//                    minRange = target;
//                }
//                if(maxRange < target)
//                {
//                    maxRange = target;
//                }
//                if(minRange > target)
//                {
//                    minRange = target;
//                }
//            }
//        }
//        
//        // 丸め
//        double start = floor(minRange);
//        double end   = ceil(maxRange);
//        if(start == end)
//        {
//            start -= [self yAxesLeftMainInterval];
//            end   += [self yAxesLeftMainInterval];
//        }
////        double start = floor(minRange - [self yAxesLeftMainInterval]);
////        double end   = ceil(maxRange + [self yAxesLeftMainInterval]);
//        
//        // 生成
//        [self setYAxesLeftRange:NSMakeRange(start, end - start)];
//    }
//    return [self yAxesLeftRange];
//}
//
//// Y軸右レンジ
//- (NSRange) callYAxesRightRange
//{
//    // レンジ設定されていない場合に生成
//    if(NSEqualRanges([self yAxesRightRange], NSMakeRange(0, 0)) == YES)
//    {
//        // レンジ計算
//        double maxRange = -1;
//        double minRange = -1;
//        double target;
//        for(NSArray *items in [self yAxesRightLists])
//        {
//            for(id item in items)
//            {
//                if([item isKindOfClass:[NSNull class]] == YES)
//                {
//                    continue;
//                }
//                if([item isKindOfClass:[NSNumber class]] == YES)
//                {
//                    target = [(NSNumber *)item doubleValue];
//                }
//                else if([item isKindOfClass:[NSDecimalNumber class]] == YES)
//                {
//                    target = [(NSDecimalNumber *)item doubleValue];
//                }
//                else
//                {
//                    continue;
//                }
//                
//                if(maxRange == -1 && minRange == -1)
//                {
//                    maxRange = target;
//                    minRange = target;
//                }
//                if(maxRange < target)
//                {
//                    maxRange = target;
//                }
//                if(minRange > target)
//                {
//                    minRange = target;
//                }
//            }
//        }
//        
//        // 丸め
//        double start = floor(minRange);
//        double end   = ceil(maxRange);
//        if(start == end)
//        {
//            start -= [self yAxesRightMainInterval];
//            end   += [self yAxesRightMainInterval];
//        }
////        double start = floor(minRange - [self yAxesRightMainInterval]);
////        double end   = ceil(maxRange + [self yAxesRightMainInterval]);
//        
//        // 生成
//        [self setYAxesRightRange:NSMakeRange(start, end - start)];
//    }
//    return [self yAxesRightRange];
//}


@end
