//
//  CTControl.m
//  CitrusTouch
//
//  Created by take64 on 2012/09/30.
//  Copyright (c) 2012年 citrus.tk. All rights reserved.
//
#import "CTControl.h"

#import <objc/runtime.h>

#import "CitrusTouchUI.h"
#import "CTString.h"

@implementation CTControl

//
// synthesize
//
@synthesize ctstyleNormal;
@synthesize ctstyleHighlighted;
@synthesize ctstyleDisabled;
@synthesize _textString;
@synthesize _state;
@synthesize userInfo;

- (id)initWithFrame:(CGRect)frame
{
    // デフォルト処理
    CGFloat widthDefault = 64;
    CGFloat heightDefault = 48;
    if(CGRectIsEmpty(frame) == YES)
    {
        frame = CGRectMake(0, 0, widthDefault, heightDefault);
    }
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setBackgroundColor:[UIColor clearColor]];
        // 初期設定
        [[self callStyleNormal] addStyleDictionary:@{
                                                     @"background-color"    :@"00000000",
                                                     @"left"                :@"0",
                                                     @"top"                 :@"0",
                                                     @"width"               :[@(frame.size.width) stringValue],
                                                     @"height"              :[@(frame.size.height) stringValue],
                                                     }];
        
        // 値監視
        [[[self callStyleNormal] callAllStyles] addObserver:self forKeyPath:@"width" options:NSKeyValueObservingOptionNew context:NULL];
        [[[self callStyleNormal] callAllStyles] addObserver:self forKeyPath:@"height" options:NSKeyValueObservingOptionNew context:NULL];
        [[[self callStyleNormal] callAllStyles] addObserver:self forKeyPath:@"top" options:NSKeyValueObservingOptionNew context:NULL];
        [[[self callStyleNormal] callAllStyles] addObserver:self forKeyPath:@"left" options:NSKeyValueObservingOptionNew context:NULL];
        //        [self addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:NULL];
        
    }
    return self;
}
// キー値監視
- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    // width 変更時
    if([keyPath isEqualToString:@"width"] == YES)
    {
        CGRect _frame = [self frame];
        CGSize _size = _frame.size;
        _size.width = [[[self callStyleNormal] callStyleKey:@"width"] floatValue];
        _frame.size = _size;
        [self setFrame:_frame];
    }
    // height 変更時
    else if([keyPath isEqualToString:@"height"] == YES)
    {
        CGRect _frame = [self frame];
        CGSize _size = _frame.size;
        _size.height = [[[self callStyleNormal] callStyleKey:@"height"] floatValue];
        _frame.size = _size;
        [self setFrame:_frame];
    }
    // top 変更時
    else if([keyPath isEqualToString:@"top"] == YES)
    {
        CGRect _frame = [self frame];
        CGPoint _origin = _frame.origin;
        _origin.y = [[[self callStyleNormal] callStyleKey:@"top"] floatValue];
        _frame.origin = _origin;
        [self setFrame:_frame];
    }
    // left 変更時
    else if([keyPath isEqualToString:@"left"] == YES)
    {
        CGRect _frame = [self frame];
        CGPoint _origin = _frame.origin;
        _origin.x = [[[self callStyleNormal] callStyleKey:@"left"] floatValue];
        _frame.origin = _origin;
        [self setFrame:_frame];
    }
}
// 描画
- (void) drawRect:(CGRect)rect
{
    // コンテクスト
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    
    // スタイルシート
    CTStyle *stylesheet = [[self callStyleNormal] copy];
    
    switch ([self _state]) {
        case CTControlStateNormal:
            break;
        case CTControlStateHighlighted:
            stylesheet = [self callStyleHighlighted];
            break;
        case CTControlStateDisabled:
            stylesheet = [self callStyleDisabled];
            break;
        default:
            break;
    }
    
    // 文字列要素
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    // パラグラフ
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    [attributes addEntriesFromDictionary:@{NSParagraphStyleAttributeName:paragraph}];
    
    CGContextSaveGState(context);
    
    CGRect contentRect = rect;
    
    // マージン
    NSString *_marginString = [stylesheet callStyleKey:@"margin"];
    CGFloat _margins[4] = {0, 0, 0, 0};
    if(_marginString != nil)
    {
        NSArray *_marginsComponents = [_marginString componentsSeparatedByString:@" "];
        
        if([_marginsComponents count] == 4)
        {
            _margins[0] = [[_marginsComponents objectAtIndex:0] floatValue];
            _margins[1] = [[_marginsComponents objectAtIndex:1] floatValue];
            _margins[2] = [[_marginsComponents objectAtIndex:2] floatValue];
            _margins[3] = [[_marginsComponents objectAtIndex:3] floatValue];
        }
        else if([_marginsComponents count] == 2)
        {
            _margins[0] = [[_marginsComponents objectAtIndex:0] floatValue];
            _margins[1] = [[_marginsComponents objectAtIndex:1] floatValue];
            _margins[2] = _margins[0];
            _margins[3] = _margins[1];
        }
        else if([_marginsComponents count] == 1)
        {
            _margins[0] = [[_marginsComponents objectAtIndex:0] floatValue];
            _margins[1] = _margins[0];
            _margins[2] = _margins[0];
            _margins[3] = _margins[0];
        }
        
        contentRect = CGRectMake((contentRect.origin.x + _margins[3]),
                                 (contentRect.origin.y + _margins[0]),
                                 (contentRect.size.width - (_margins[3] + _margins[1])),
                                 (contentRect.size.height - (_margins[0] + _margins[2])));
    }
    
    // パッディング
    CGRect paddedContentRect = contentRect;
    NSString *_paddingString = [stylesheet callStyleKey:@"padding"];
    CGFloat _paddings[4] = {0, 0, 0, 0};
    if(_paddingString != nil)
    {
        NSArray *_paddingsComponents = [_paddingString componentsSeparatedByString:@" "];
        long count = [_paddingsComponents count];
        
        if(count == 4)
        {
            _paddings[0] = [[_paddingsComponents objectAtIndex:0] floatValue];
            _paddings[1] = [[_paddingsComponents objectAtIndex:1] floatValue];
            _paddings[2] = [[_paddingsComponents objectAtIndex:2] floatValue];
            _paddings[3] = [[_paddingsComponents objectAtIndex:3] floatValue];
        }
        else if(count == 2)
        {
            _paddings[0] = [[_paddingsComponents objectAtIndex:0] floatValue];
            _paddings[1] = [[_paddingsComponents objectAtIndex:1] floatValue];
            _paddings[2] = _margins[0];
            _paddings[3] = _paddings[1];
        }
        else if(count == 1)
        {
            _paddings[0] = [[_paddingsComponents objectAtIndex:0] floatValue];
            _paddings[1] = _paddings[0];
            _paddings[2] = _paddings[0];
            _paddings[3] = _paddings[0];
        }
        
        paddedContentRect = CGRectMake((contentRect.origin.x + _paddings[3]),
                                       (contentRect.origin.y + _paddings[0]),
                                       (contentRect.size.width - (_paddings[3] + _paddings[1])),
                                       (contentRect.size.height - (_paddings[0] + _paddings[2])));
    }
    
    
    // 背景描画
    NSString *_backgroundColorString = [stylesheet callStyleKey:@"background-color"];
    if(_backgroundColorString != nil)
    {
        CTColor *_ctcolor = [CTColor colorWithHEXString:_backgroundColorString];
        CGColorRef _colorref = [_ctcolor CGColor];
        const CGFloat *_colors = CGColorGetComponents(_colorref);
        CGContextSetRGBFillColor(context, _colors[0], _colors[1], _colors[2], _colors[3]);
    }
    
    // ボーダー角丸
    NSString *_borderRadiusString = [stylesheet callStyleKey:@"border-radius"];
    CGFloat _borderRadiuses[4];
    if(_borderRadiusString != nil)
    {
        NSArray *_borderRadiusComponents = [_borderRadiusString componentsSeparatedByString:@" "];
        long count = [_borderRadiusComponents count];
        if(count == 4)
        {
            _borderRadiuses[0] = [[_borderRadiusComponents objectAtIndex:0] floatValue];
            _borderRadiuses[1] = [[_borderRadiusComponents objectAtIndex:1] floatValue];
            _borderRadiuses[2] = [[_borderRadiusComponents objectAtIndex:2] floatValue];
            _borderRadiuses[3] = [[_borderRadiusComponents objectAtIndex:3] floatValue];
        }
        else if(count == 2)
        {
            _borderRadiuses[0] = [[_borderRadiusComponents objectAtIndex:0] floatValue];
            _borderRadiuses[1] = [[_borderRadiusComponents objectAtIndex:1] floatValue];
            _borderRadiuses[2] = _borderRadiuses[0];
            _borderRadiuses[3] = _borderRadiuses[1];
        }
        else if(count == 1)
        {
            _borderRadiuses[0] = [[_borderRadiusComponents objectAtIndex:0] floatValue];
            _borderRadiuses[1] = _borderRadiuses[0];
            _borderRadiuses[2] = _borderRadiuses[0];
            _borderRadiuses[3] = _borderRadiuses[0];
        }
        //
        //        // content
        //        contentRect = CGRectMake(contentRect.origin.x + (_borderRadiuses[3] / 2),
        //                                 contentRect.origin.y + (_borderRadiuses[0] / 2),
        //                                 contentRect.size.width - ((_borderRadiuses[3] / 2) + (_borderRadiuses[1] / 2)),
        //                                 contentRect.size.height - ((_borderRadiuses[2] / 2) + (_borderRadiuses[0] / 2)));
    }
    else
    {
        _borderRadiuses[0] = 0;
        _borderRadiuses[1] = 0;
        _borderRadiuses[2] = 0;
        _borderRadiuses[3] = 0;
    }
    [self addPathRadius:_borderRadiuses rect:contentRect];
    CGContextFillPath(context);
    
    CGContextRestoreGState(context);
    
    
    
    
    // 影設定
    NSString *_boxShadowString = [stylesheet callStyleKey:@"box-shadow"];
    if(_boxShadowString != nil)
    {
        CGContextSaveGState(context);
        [self addPathRadius:_borderRadiuses rect:contentRect];
        
        NSArray *_boxShadowComponents = [_boxShadowString componentsSeparatedByString:@" "];
        CGFloat  _boxShadowLeft    = [[_boxShadowComponents objectAtIndex:0] floatValue];
        CGFloat  _boxShadowTop     = [[_boxShadowComponents objectAtIndex:1] floatValue];
        CGFloat  _boxShadowShading = [[_boxShadowComponents objectAtIndex:2] floatValue];
        CTColor *_boxShadowColor   = [CTColor colorWithHEXString:[_boxShadowComponents objectAtIndex:3]];
        
        
        // 背景色処理
        if(_backgroundColorString != nil)
        {
            CGColorRef colorRef = [[CTColor colorWithHEXString:_backgroundColorString] CGColor];
            const CGFloat *colors = CGColorGetComponents(colorRef);
            CGContextSetRGBFillColor(context, colors[0], colors[1], colors[2], colors[3]);
        }
        
        CGContextSetShadowWithColor(context, CGSizeMake(_boxShadowLeft, _boxShadowTop), _boxShadowShading, [_boxShadowColor CGColor]);
        CGContextFillPath(context);
        
        CGContextRestoreGState(context);
    }
    
    
    // グラデーション
    NSString *_backgroundImageString = [stylesheet callStyleKey:@"background-image"];
    if([_backgroundImageString hasPrefix:@"linear-gradient"] == YES)
    {
        // 描画範囲
        CGContextSaveGState(context);
        [self addPathRadius:_borderRadiuses rect:contentRect];
        CGContextClip(context);
        
        // トリム
        _backgroundImageString = [_backgroundImageString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        
        // 文字列置換
        _backgroundImageString = [_backgroundImageString stringByReplacingOccurrencesOfString:@"linear-gradient(" withString:@""];
        _backgroundImageString = [_backgroundImageString stringByReplacingOccurrencesOfString:@"rgba(" withString:@""];
        _backgroundImageString = [_backgroundImageString stringByReplacingOccurrencesOfString:@")" withString:@","];
        _backgroundImageString = [_backgroundImageString stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        // 要素数の取得
        NSArray *component = [_backgroundImageString componentsSeparatedByString:@","];
        NSInteger size = [component count] - 1;
        
        const long locationSize = (size / 5);
        const long componentSize = ((size / 5) * 4);
        
        // 要素
        CGFloat locations[locationSize];
        CGFloat components[componentSize];
        
        // 設定
        NSInteger count = 0;
        NSInteger locationCount = 0;
        NSInteger componentCount = 0;
        for(NSString *column in component)
        {
            if(count >= size)
            {
                break;
            }
            
            if(((count + 1) % 5) == 0)
            {
                locations[locationCount] = [column floatValue];
                locationCount++;
            }
            else
            {
                components[componentCount] = [column floatValue];
                componentCount++;
            }
            count++;
        }
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, components, locations, locationSize);
        CGContextDrawLinearGradient(context, gradient, CGPointMake(0, contentRect.origin.y), CGPointMake(0, contentRect.origin.y + contentRect.size.height), 0);
        
        CGContextRestoreGState(context);
        
        CGColorSpaceRelease(colorSpace);
        CGGradientRelease(gradient);
    }
    
    
    // 枠線
    NSString *_borderWidthString = [stylesheet callStyleKey:@"border-width"];
    CGFloat _borderWidth = 0;
    if(_borderWidthString != nil)
    {
        // 枠線幅
        _borderWidth = [_borderWidthString floatValue];
        
        CGContextSaveGState(context);
        
        
        // 枠線色
        NSString *_borderColorString = [stylesheet callStyleKey:@"border-color"];
        CTColor *_borderColor;
        if(_borderColorString == nil)
        {
            _borderColorString = @"000000";
        }
        _borderColor = [CTColor colorWithHEXString:_borderColorString];
        CGColorRef _colorref = [_borderColor CGColor];
        const CGFloat *_colors = CGColorGetComponents(_colorref);
        
        
        CGContextSetRGBStrokeColor(context, _colors[0], _colors[1], _colors[2], _colors[3]);
        CGContextSetLineWidth(context, _borderWidth);
        CGContextSetLineCap(context, kCGLineCapRound);
        
        // 描画範囲
        CGRect _drawRect = CGRectInset(contentRect, (_borderWidth / 2), (_borderWidth / 2));
        [self addPathRadius:_borderRadiuses rect:_drawRect offset:(_borderWidth / -1)];
        CGContextStrokePath(context);
        
        CGContextRestoreGState(context);
    }
    
    
    // テキストレンダリング
    if([self text] != nil)
    {
        CGContextSaveGState(context);
        
        // テキスト影
        NSString *_textShadowString = [stylesheet callStyleKey:@"text-shadow"];
        if(_textShadowString != nil)
        {
            NSArray *_textShadowComponents = [_textShadowString componentsSeparatedByString:@" "];
            CGFloat  _textShadowLeft    = [[_textShadowComponents objectAtIndex:0] floatValue];
            CGFloat  _textShadowTop     = [[_textShadowComponents objectAtIndex:1] floatValue];
            CGFloat  _textShadowShading = [[_textShadowComponents objectAtIndex:2] floatValue];
            CTColor *_textShadowColor   = [CTColor colorWithHEXString:[_textShadowComponents objectAtIndex:3]];
            CGContextSetShadowWithColor(context, CGSizeMake(_textShadowLeft, _textShadowTop), _textShadowShading, [_textShadowColor CGColor]);
        }
        
        // 文字色
        NSString *_colorString = [stylesheet callStyleKey:@"color"];
        CTColor *_ctcolor;
        if(_colorString != nil)
        {
            _ctcolor = [CTColor colorWithHEXString:_colorString];
        }
        else
        {
            _ctcolor = [CTColor colorWithHEXString:@"FFFFFF"];
        }
        [attributes addEntriesFromDictionary:@{NSForegroundColorAttributeName:_ctcolor}];
        //        CGColorRef _colorref = [_ctcolor CGColor];
        //        const CGFloat *_colors = CGColorGetComponents(_colorref);
        //        CGContextSetRGBFillColor(context, _colors[0], _colors[1], _colors[2], _colors[3]);
        
        // ラインブレイク
        NSString *_lineBreak = [stylesheet callStyleKey:@"line-break"];
        NSLineBreakMode lineBreakMode = 0;
        if(_lineBreak != nil)
        {
            if([_lineBreak rangeOfString:@"truncating-middle"].location != NSNotFound)
            {
                lineBreakMode |= NSLineBreakByTruncatingMiddle;
            }
            if([_lineBreak isEqualToString:@"word-wrapping"] == YES)
            {
                lineBreakMode = NSLineBreakByWordWrapping;// Wrap at word boundaries, default
            }
            else if([_lineBreak isEqualToString:@"char-wrapping"] == YES)
            {
                lineBreakMode = NSLineBreakByCharWrapping; // Wrap at character boundaries
            }
            else if([_lineBreak isEqualToString:@"clipping"] == YES)
            {
                lineBreakMode = NSLineBreakByClipping; // Simply clip
            }
            else if([_lineBreak isEqualToString:@"truncating-head"] == YES)
            {
                lineBreakMode = NSLineBreakByTruncatingHead; // Truncate at head of line: "...wxyz"
            }
            else if([_lineBreak isEqualToString:@"truncating-tail"] == YES)
            {
                lineBreakMode = NSLineBreakByTruncatingTail; // Truncate at head of line: "...wxyz"
            }
            else if([_lineBreak isEqualToString:@"truncating-middle"] == YES)
            {
                lineBreakMode = NSLineBreakByTruncatingMiddle;  // Truncate middle of line:  "ab...yz"
            }
        }
        [paragraph setLineBreakMode:lineBreakMode];
        
        
        
        // フォント計算
        UIFont *font;
        CGSize fontBounds;
        if([[stylesheet callStyleKey:@"adjust-font"] isEqualToString:@"true"] == YES)
        {
            BOOL adjust = NO;
            while (adjust == NO)
            {
                font = [stylesheet callFont];
                [attributes addEntriesFromDictionary:@{NSFontAttributeName:font}];
                fontBounds = [[self text] boundingRectWithSize:CGSizeMake(paddedContentRect.size.width, CGFLOAT_MAX) options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine) attributes:attributes context:nil].size;
                fontBounds.width = paddedContentRect.size.width;
                double fontSize = [[stylesheet callStyleKey:@"font-size"] doubleValue];
                if(fontBounds.height > paddedContentRect.size.height && fontSize > 1)
                {
                    fontBounds.height = paddedContentRect.size.height;
                    
                    [stylesheet addStyleKey:@"font-size" value:[@(fontSize - 0.5) stringValue]];
                }
                else
                {
                    adjust = YES;
                }
            }
        }
        else
        {
            font = [stylesheet callFont];
            [attributes addEntriesFromDictionary:@{NSFontAttributeName:font}];
            fontBounds = [[self text] boundingRectWithSize:paddedContentRect.size options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine) attributes:attributes context:nil].size;
            fontBounds.width = paddedContentRect.size.width;
            if(fontBounds.height > paddedContentRect.size.height)
            {
                fontBounds.height = paddedContentRect.size.height;
            }
        }
        
        
        
        // 文字寄せ
        CGRect titleFrame = CGRectMake(0, 0, (fontBounds.width), (fontBounds.height));
        NSString *_textAlignString = [stylesheet callStyleKey:@"text-align"];
        NSTextAlignment _textAlignment;
        if(_textAlignString == nil)
        {
            _textAlignString = @"center";
        }
        if([_textAlignString isEqualToString:@"center"] == YES)
        {
            titleFrame.origin = CGPointMake((paddedContentRect.size.width / 2 - fontBounds.width / 2) + paddedContentRect.origin.x,
                                            (paddedContentRect.size.height / 2 - fontBounds.height / 2) + paddedContentRect.origin.y);
            _textAlignment = NSTextAlignmentCenter;
        }
        else if([_textAlignString isEqualToString:@"left"] == YES)
        {
            titleFrame.origin = CGPointMake(paddedContentRect.origin.x,
                                            (paddedContentRect.size.height / 2 - fontBounds.height / 2) + paddedContentRect.origin.y);
            _textAlignment = NSTextAlignmentLeft;
        }
        else if([_textAlignString isEqualToString:@"right"] == YES)
        {
            titleFrame.origin = CGPointMake((paddedContentRect.origin.x + paddedContentRect.size.width) - fontBounds.width,
                                            (paddedContentRect.size.height / 2 - fontBounds.height / 2) + paddedContentRect.origin.y);
            _textAlignment = NSTextAlignmentRight;
        }
        // AnalyzeのLogic error対策
        else
        {
            titleFrame.origin = CGPointMake((paddedContentRect.size.width / 2 - fontBounds.width / 2) + paddedContentRect.origin.x,
                                            (paddedContentRect.size.height / 2 - fontBounds.height / 2) + paddedContentRect.origin.y);
            _textAlignment = NSTextAlignmentCenter;
        }
        
        [paragraph setAlignment:_textAlignment];
        
        [[self text] drawInRect:titleFrame withAttributes:attributes];
        
        CGContextRestoreGState(context);
    }
}
// 強制描画
- (void) setNeedsDisplay
{
    [super setNeedsDisplay];
    
    for(id childView in [self subviews])
    {
        if([childView isKindOfClass:[CTControl class]] == YES)
        {
            [(CTControl *)childView setNeedsDisplay];
        }
    }
}



#pragma mark -
#pragma mark method
//
// method
//

// 初期化
- (id) initWithText:(NSString *)textString
{
    self = [self initWithFrame:CGRectZero];
    if(self)
    {
        // タイトル
        [self setText:textString];
    }
    return self;
}

- (void) dealloc
{
    [[[self callStyleNormal] callAllStyles] removeObserver:self forKeyPath:@"left"];
    [[[self callStyleNormal] callAllStyles] removeObserver:self forKeyPath:@"top"];
    [[[self callStyleNormal] callAllStyles] removeObserver:self forKeyPath:@"width"];
    [[[self callStyleNormal] callAllStyles] removeObserver:self forKeyPath:@"height"];
}

// スタイル設定
- (CTStyle *) callStyle
{
    return [self callStyleNormal];
}
- (CTStyle *) callStyleNormal
{
    if([self ctstyleNormal] == nil)
    {
        [self setCtstyleNormal:[[CTStyle alloc] init]];
    }
    return [self ctstyleNormal];
}
- (CTStyle *) callStyleHighlighted
{
    if([self ctstyleHighlighted] == nil)
    {
        if([self ctstyleNormal] != nil)
        {
            NSMutableDictionary *tmpStyles = [[[self ctstyleNormal] _styles] mutableCopy];
            [self setCtstyleHighlighted:[[CTStyle alloc] initWithStyleDictionary:tmpStyles]];
        }
        else
        {
            [self setCtstyleHighlighted:[[CTStyle alloc] init]];
        }
    }
    return [self ctstyleHighlighted];
}
- (CTStyle *) callStyleDisabled
{
    if([self ctstyleDisabled] == nil)
    {
        if([self ctstyleNormal] != nil)
        {
            NSMutableDictionary *tmpStyles = [[[self ctstyleNormal] _styles] mutableCopy];
            [self setCtstyleDisabled:[[CTStyle alloc] initWithStyleDictionary:tmpStyles]];
        }
        else
        {
            [self setCtstyleDisabled:[[CTStyle alloc] init]];
        }
    }
    return [self ctstyleDisabled];
}
// スタイル設定
- (void) setStyle:(CTStyle *)styleValue
{
    [[self callStyle] addStyleDictionary:[styleValue callAllStyles]];
}
- (void) setStyleNormal:(CTStyle *)styleValue
{
    [[self callStyleNormal] addStyleDictionary:[styleValue callAllStyles]];
}
- (void) setStyleHighlighted:(CTStyle *)styleValue
{
    [[self callStyleHighlighted] addStyleDictionary:[styleValue callAllStyles]];
}
- (void) setStyleDisabled:(CTStyle *)styleValue
{
    [[self callStyleDisabled] addStyleDictionary:[styleValue callAllStyles]];
}

// ステート
- (void) setState:(CTControlState)state
{
    // ステート設定
    [self set_state:state];
    
    // 強制描画
    [self setNeedsDisplay];
}
// ステート変更(enable)
- (void) setEnabled:(BOOL)enabled
{
    [super setEnabled:enabled];
    if(enabled == YES)
    {
        [self setState:CTControlStateNormal];
    }
    else
    {
        [self setState:CTControlStateDisabled];
    }
    [self setNeedsDisplay];
}
// ステート変更(highlighted)
- (void) setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    if(highlighted == YES)
    {
        [self setState:CTControlStateHighlighted];
    }
    else
    {
        [self setState:CTControlStateNormal];
    }
}




#pragma mark -
#pragma mark private method
//
// private method
//

// 角丸のパスを生成
- (void) addPathRadius:(const CGFloat *)radius rect:(CGRect)rect
{
    [self addPathRadius:radius rect:rect offset:0];
}

// 角丸のパスを生成
- (void) addPathRadius:(const CGFloat *)radius rect:(CGRect)rect offset:(CGFloat)offset
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 角丸rect
    CGRect cornerCircleRect  = rect;
    
    // get points
    CGFloat minx = CGRectGetMinX(cornerCircleRect);
    CGFloat midx = CGRectGetMidX(cornerCircleRect);
    CGFloat maxx = CGRectGetMaxX(cornerCircleRect);
    CGFloat miny = CGRectGetMinY(cornerCircleRect);
    CGFloat midy = CGRectGetMidY(cornerCircleRect);
    CGFloat maxy = CGRectGetMaxY(cornerCircleRect);
    
    // 黒下地
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, minx, midy);
    CGContextAddArcToPoint(context, minx, miny, midx, miny, radius[0] + offset);
    CGContextAddArcToPoint(context, maxx, miny, maxx, midy, radius[1] + offset);
    CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, radius[2] + offset);
    CGContextAddArcToPoint(context, minx, maxy, minx, midy, radius[3] + offset);
    CGContextClosePath(context);
}

@end
