//
//  CTTableCellNumberPad.m
//  CitrusTouch
//
//  Created by take64 on 2012/11/28.
//  Copyright (c) 2012年 citrus.tk. All rights reserved.
//

#import "CTTableCellNumberPad.h"

@implementation CTTableCellNumberPad

//
// synthesize
//
@synthesize inputPackingView;




#pragma mark -
#pragma mark method
//
// method
//

// 初期化
- (id) initWithPrefix:(NSString *)prefixString suffix:(NSString *)suffixString reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithPrefix:prefixString suffix:suffixString reuseIdentifier:reuseIdentifier];
    if(self)
    {
        // テキストフィールド
        [[self textField] setEnableMenu:NO];
        
        // パッキングビュー
        [self setInputPackingView:[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 256)]];
        [[self inputPackingView] setBackgroundColor:[CTColor colorWithHEXString:@"999999"]];

        // 共通ボタンスタイル
        CTStyle *buttonStyleNormal = [[CTStyle alloc] initWithStyleDictionary:@{
                                      @"width"              :@"128",
                                      @"height"             :@"64",
                                      @"color"              :@"FFFFFF",
                                      @"font-size"          :@"24",
                                      @"font-weight"        :@"bold",
                                      @"text-shadow"        :@"0 -1 1 333333",
                                      @"border-color"       :@"FFFFFF",
                                      @"border-width"       :@"1",
                                      @"border-radius"      :@"8",
                                      @"margin"             :@"4",
                                      @"box-shadow"         :@"0 1 4 000000",
                                      @"background-color"   :@"333333",
                                      @"background-image"   :@"linear-gradient(rgba(1.00, 1.00, 1.00, 0.75) 0.00, rgba(0.75, 0.75, 0.75, 0.50) 0.05, rgba(0.50, 0.50, 0.50, 0.50) 0.95, rgba(0.25, 0.25, 0.25, 0.75) 1.00)",
                                      }];
        CTStyle *buttonStyleHighlight  = [[CTStyle alloc] initWithStyleDictionary:@{
                                          @"background-image":@"linear-gradient(rgba(0.10, 0.10, 0.10, 0.90) 0.00, rgba(0.10, 0.10, 0.10, 0.50) 0.05, rgba(0.10, 0.10, 0.10, 0.50) 0.95, rgba(0.10, 0.10, 0.10, 0.90) 1.00)",
                                          }];
        
        // ボタン
        CTButton *numberButton;
        
        NSArray *buttonList = @[
                                @[ @"7", @"8", @"9", @"BS" ],
                                @[ @"4", @"5", @"6", @"CLEAR" ],
                                @[ @"1", @"2", @"3", @"OK" ],
                                @[ @"0", @"",  @"00" ],
                                ];
        NSString *buttonTitle = @"";
        CGFloat baseWidth = 128;
        CGFloat baseHeight = 64;
        CGFloat width = 128;
        CGFloat height = 64;
        CGFloat left = 0;
        CGFloat top = 0;
        CGFloat offsetLeft = 256;
        
        // ボタン
        for(int i = 0; i < [buttonList count]; i++)
        {
            for(int j = 0; j < [(NSArray *)[buttonList objectAtIndex:i] count]; j++)
            {
                // ボタン調整
                left = (j * baseWidth) + offsetLeft;
                top = (i * baseHeight);
                width = baseWidth;
                height = baseHeight;
                buttonTitle = [[buttonList objectAtIndex:i] objectAtIndex:j];
                if([buttonTitle isEqualToString:@"0"] == YES)
                {
                    width = baseWidth * 2;
                }
                else if([buttonTitle isEqualToString:@"OK"] == YES)
                {
                    height = baseHeight * 2;
                }
                else if([buttonTitle isEqualToString:@""] == YES)
                {
                    continue;
                }
                
                // ボタン
                numberButton = [[CTButton alloc] initWithText:buttonTitle];
                [numberButton setStyle:buttonStyleNormal];
                if([buttonTitle isEqualToString:@"CLEAR"] == YES)
                {
                    [[numberButton callStyle] addStyleDictionary:@{
                     @"background-color"    :@"FF9900",
                     }];
                }
                else if([buttonTitle isEqualToString:@"BS"] == YES)
                {
                    [[numberButton callStyle] addStyleDictionary:@{
                     @"background-color"    :@"FF3300",
                     }];
                }
                else if([buttonTitle isEqualToString:@"OK"] == YES)
                {
                    [[numberButton callStyle] addStyleDictionary:@{
                     @"background-color"    :@"3333FF",
                     }];
                }
                [numberButton setStyleHighlighted:buttonStyleHighlight];
                [[numberButton callStyle] addStyleDictionary:@{
                 @"left"    :[NSNumber numberWithInt:left],
                 @"top"     :[NSNumber numberWithInt:top],
                 @"width"   :[NSNumber numberWithInt:width],
                 @"height"  :[NSNumber numberWithInt:height],
                 }];
                [numberButton setOnTappedComplete:^(CTButton *buttonValue) {
                    [self onTapButtonNumber:buttonTitle];
                }];
                [[self inputPackingView] addSubview:numberButton];
            }
        }
        
        // 配置
        [[self textField] setInputView:[self inputPackingView]];
    }
    return self;
}

// 初期化
- (id) initWithPrefix:(NSString *)prefixString content:(NSString *)decimalString suffix:(NSString *)suffixString reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [self initWithPrefix:prefixString suffix:suffixString reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self setContentText:decimalString];
    }
    return self;
}


#pragma mark -
#pragma mark private
//
// private
//

// 値設定
- (void) onTapButtonNumber:(NSString *)numberString
{
    if([numberString isEqualToString:@"OK"] == YES)
    {
        if([[self responder] canResignFirstResponder] == YES)
        {
            [[self responder] resignFirstResponder];
        }
    }
    else if([numberString isEqualToString:@"CLEAR"] == YES)
    {
        [[self textField] setText:@""];
    }
    else if([numberString isEqualToString:@"BS"] == YES)
    {
        NSMutableString *stringValue = [NSMutableString stringWithString:[[self textField] text]];
        if([stringValue length] > 0)
        {
            [stringValue deleteCharactersInRange:NSMakeRange([stringValue length] - 1, 1)];
            [[self textField] setText:[stringValue copy]];
        }
    }
    else
    {
        NSMutableString *stringValue = [NSMutableString stringWithString:[[self textField] text]];
        [stringValue appendString:numberString];
        [[self textField] setText:[stringValue copy]];
    }
}
@end
