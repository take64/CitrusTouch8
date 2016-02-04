//
//  CTColor.m
//  CitrusTouch
//
//  Created by TAKEMOTO KOUHEI on 2012/10/01.
//  Copyright (c) 2012年 citrus.tk. All rights reserved.
//

#import "CTColor.h"

@implementation CTColor

// 16進数カラー からCTColor(UIColor) オブジェクトを取得
+ (CTColor *) colorWithHEXString:(NSString *)hexString
{
    static NSMutableDictionary *cacheColors;
    if(cacheColors == nil)
    {
        cacheColors = [NSMutableDictionary dictionaryWithCapacity:10];
    }
    CTColor *color = [cacheColors objectForKey:hexString];
    if(color == nil)
    {
        color = [CTColor colorWithHEXString:hexString alpha:1.0];
        [cacheColors setObject:color forKey:hexString];
    }
    return color;
}

// 16進数カラー からCTColor(UIColor) オブジェクトを取得(透過色付き)
+ (CTColor *) colorWithHEXString:(NSString *)hexString alpha:(CGFloat)alpha
{
    // 色文字列長
    long length = [hexString length];
    
    // 16進文字列変換( 'FFFFFF' => '0xFFFFFF' )
    NSString *color = [NSString stringWithFormat:@"0x%@", hexString];
    
    // 16進数値変換( '0xFFFFFF' => 0xFFFFFF )
    const char *str = [color UTF8String];
    char *endptr;  // 変換不可能文字列の格納先
    int base = 0;  // 0: 8進(先頭0), 16進(先頭0x), 10進数モード
    long long hexcolor = strtoll(str, &endptr, base);
    
    // 色型に変更
    UIColor *uicolor;
    if(length == 6)
    {
        uicolor = [UIColor colorWithRed:((hexcolor>>16)&0xFF)/255.0
                                  green:((hexcolor>>8)&0xFF)/255.0
                                   blue:((hexcolor)&0xFF)/255.0
                                  alpha:alpha];
    }
    else if(length == 8)
    {
        uicolor = [UIColor colorWithRed:((hexcolor>>24)&0xFF)/255.0
                                  green:((hexcolor>>16)&0xFF)/255.0
                                   blue:((hexcolor>>8)&0xFF)/255.0
                                  alpha:((hexcolor)&0xFF)/255.0];
    }
    else
    {
        uicolor = [UIColor whiteColor];
    }
    
    return (CTColor *)uicolor;
}

// 16進数カラー から補色CTColor(UIColor) オブジェクトを取得
+ (CTColor *) complementaryColorWithHEXString:(NSString *)hexString
{
    // 色文字列長
    long length = [hexString length];
    
    // 16進文字列変換( 'FFFFFF' => '0xFFFFFF' )
    NSString *color = [NSString stringWithFormat:@"0x%@", hexString];
    
    // 16進数値変換( '0xFFFFFF' => 0xFFFFFF )
    const char *str = [color UTF8String];
    char *endptr;  // 変換不可能文字列の格納先
    int base = 0;  // 0: 8進(先頭0), 16進(先頭0x), 10進数モード
    long long hexcolor = strtoll(str, &endptr, base);
    
    // 色型に変更
    int red;
    int green;
    int blue;
    int alpha;
    if(length == 6)
    {
        red     = ((hexcolor>>16)&0xFF);
        green   = ((hexcolor>>8)&0xFF);
        blue    = ((hexcolor)&0xFF);
        alpha   = 1.0;
    }
    else if(length == 8)
    {
        red     = ((hexcolor>>24)&0xFF);
        green   = ((hexcolor>>16)&0xFF);
        blue    = ((hexcolor>>8)&0xFF);
        alpha   = ((hexcolor)&0xFF);
    }
    else
    {
        red     = 1.0;
        green   = 1.0;
        blue    = 1.0;
        alpha   = 1.0;
    }
    
    int max = MAX(MAX(red, green), blue);
    int min = MIN(MIN(red, green), blue);
    
    int total = max + min;
    if(total == 510)
    {
        total = 0;
    }
    red     = total - red;
    green   = total - green;
    blue    = total - blue;
    
    UIColor *uicolor = [UIColor colorWithRed:red    / 255.0
                                       green:green  / 255.0
                                        blue:blue   / 255.0
                                       alpha:alpha];
    
    return (CTColor *)uicolor;
}

// CTColor(UIColor) から 16進数文字列を取得
+ (NSString *) hexStringWithColor:(CTColor *)colorValue
{
    CGColorRef cgcolor = [colorValue CGColor];
    
    // 色を分解
    const CGFloat *colors;
    colors = CGColorGetComponents(cgcolor);
    int red     = colors[0] * 255.0;
    int green   = colors[1] * 255.0;
    int blue    = colors[2] * 255.0;
    int alpha   = colors[3] * 255.0;
    
    NSString *colorString = [NSString stringWithFormat:@"%02X%02X%02X%02X",
                             red,
                             green,
                             blue,
                             alpha
                             ];
    return colorString;
}

- (NSString *)description
{
    return [CTColor hexStringWithColor:self];
}

@end
