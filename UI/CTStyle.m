//
//  CTStyle.m
//  Panel15
//
//  Created by TAKEMOTO KOUHEI on 2012/09/30.
//  Copyright (c) 2012年 citrus.tk. All rights reserved.
//

#import "CTStyle.h"

@implementation CTStyle

//
// synthesize
//
@synthesize _styles;


- (id) init
{
    self = [super init];
    if(self)
    {
        [self set_styles:[NSMutableDictionary dictionaryWithCapacity:2]];
    }
    return self;
}


#pragma mark -
#pragma mark method
//
// method
//

// 初期化
- (id) initWithStyleDictionary:(NSDictionary *)dictionaryValue
{
    self = [self init];
    if(self)
    {
        [self setStyleDictionary:dictionaryValue];
    }
    return self;
}
// 追加
- (void) addStyleKey:(NSString *)keyValue value:(NSString *)dataValue
{
//    BOOL isRootExist = NO;
//    for(NSString *rootKey in @[ @"top", @"left", @"width", @"height" ])
//    {
//        if([keyValue isEqualToString:rootKey] == YES)
//        {
//            isRootExist = YES;
//            break;
//        }
//    }
//
    if([[self _styles] objectForKey:keyValue] == nil)
    {
        [[self _styles] setValue:dataValue forKey:keyValue];
    }
    else if([[[self _styles] objectForKey:keyValue] isEqualToString:dataValue] == YES)
    {
        // 同じなら変更しない
    }
    else
    {
        [[self _styles] willChangeValueForKey:keyValue];
        [[self _styles] setValue:dataValue forKey:keyValue];
        [[self _styles] didChangeValueForKey:keyValue];
    }
}
// 追加
- (void) addStyleDictionary:(NSDictionary *)dictionaryValue
{
    for(NSString *keyValue in [dictionaryValue allKeys])
    {
        [self addStyleKey:keyValue value:[dictionaryValue objectForKey:keyValue]];
    }
}
// 削除
- (void) removeStyleKey:(NSString *)keyValue
{
    if([[self _styles] objectForKey:keyValue] != nil)
    {
        [[self _styles] willChangeValueForKey:keyValue];
        [[self _styles] removeObjectForKey:keyValue];
        [[self _styles] didChangeValueForKey:keyValue];
    }
    else
    {
        [[self _styles] removeObjectForKey:keyValue];
    }
}
// 取得
- (NSString *) callStyleKey:(NSString *)keyValue
{
    return [[self _styles] objectForKey:keyValue];
}
// 設定
- (void) setStyleKey:(NSString *)keyValue value:(NSString *)dataValue
{
    [self addStyleKey:keyValue value:dataValue];
}
// 設定
- (void) setStyleDictionary:(NSDictionary *)dictionaryValue
{
    [self addStyleDictionary:dictionaryValue];
}
// 全取得
- (NSMutableDictionary *) callAllStyles
{
    return [self _styles];
}
// フォント取得
- (UIFont *) callFont
{
    // フォントサイズ
    NSString *_fontSizeString = [[self _styles] objectForKey:@"font-size"];
    CGFloat _fontSize = 12;
    if(_fontSizeString != nil)
    {
        _fontSize = [_fontSizeString floatValue];
    }
    
//    // フォントファミリー
//    NSString *_fontFamily = [[self _styles] objectForKey:@"font-family"];
//    
    // フォントボールド
    NSString *_fontWeight = [[self _styles] objectForKey:@"font-weight"];
    BOOL isFontBold = NO;
    if(_fontWeight != nil)
    {
        if([_fontWeight isEqualToString:@"bold"] == YES)
        {
            isFontBold = YES;
        }
    }
//
//    // フォントイタリック
//    NSString *_fontStyle = [[self _styles] objectForKey:@"font-style"];
    
    
    // 生成
    UIFont *_font;
    
//    // ボールド
//    if(_fontWeight != nil)
//    {
//        if(_fontFamily != nil)
//        {
//            _font = [UIFont fontWithName:_fontFamily size:_fontSize];
//        }
//        else
//        {
//            _font = [UIFont boldSystemFontOfSize:_fontSize];
//        }
//    }
    if(isFontBold == YES)
    {
        _font = [UIFont boldSystemFontOfSize:_fontSize];
    }
    else
    {
        _font = [UIFont systemFontOfSize:_fontSize];
    }
    
    return _font;
}
// サイズ取得
- (CGSize) callSize
{
    NSString *_widthString = [[self _styles] objectForKey:@"width"];
    NSString *_heightString = [[self _styles] objectForKey:@"height"];
    
    CGFloat _width = 0;
    CGFloat _height = 0;
    if(_widthString != nil)
    {
        _width = [_widthString floatValue];
    }
    if(_heightString != nil)
    {
        _height = [_heightString floatValue];
    }
    
    return CGSizeMake(_width, _height);
}
// ポイント取得
- (CGPoint) callPoint
{
    NSString *_topString = [[self _styles] objectForKey:@"top"];
    NSString *_leftString = [[self _styles] objectForKey:@"left"];
    
    CGFloat _top = 0;
    CGFloat _left = 0;
    if(_topString != nil)
    {
        _top = [_topString floatValue];
    }
    if(_leftString != nil)
    {
        _left = [_leftString floatValue];
    }
    
    return CGPointMake(_left, _top);
}
// フレーム取得
- (CGRect) callFrame
{
    CGPoint _point = [self callPoint];
    CGSize _size = [self callSize];
    
    CGRect _rect = CGRectZero;
    _rect.origin = _point;
    _rect.size = _size;
    return _rect;
}
// マージン取得(右)
- (CGFloat) callMarginRight
{
    // マージン
    NSString *_marginString = [self callStyleKey:@"margin"];
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
    }
    return _margins[1];
}
// マージン取得(下)
- (CGFloat) callMarginBottom
{
    // マージン
    NSString *_marginString = [self callStyleKey:@"margin"];
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
    }
    return _margins[2];
}
// ボーダー幅取得
- (CGFloat) callBorderWidth
{
    NSString *_borderWidthString = [self callStyleKey:@"border-width"];
    CGFloat _borderWidth = 0;
    if(_borderWidthString != nil)
    {
        // 枠線幅
        _borderWidth = [_borderWidthString floatValue];
    }
    return _borderWidth;
}




#pragma mark -
#pragma mark NSCopying
//
// NSCopying
//
- (id)copyWithZone:(NSZone *)zone
{
    CTStyle *result = [[self class] allocWithZone:zone];
    if(result)
    {
        [result set_styles:[[self _styles] mutableCopyWithZone:zone]];
    }
    return result;
}

@end
