//
//  CTTableCellNumberPicker.m
//  CitrusTouch
//
//  Created by take64 on 2016/02/07.
//  Copyright © 2016年 citrus.tk. All rights reserved.
//

#import "CTTableCellNumberPicker.h"

@implementation CTTableCellNumberPicker

//
// synthesize
//
@synthesize numberPicker;
@synthesize dataList;
@synthesize displayFormat;
@synthesize inputPackingView;

#pragma mark - method
//
// method
//

// 初期化
- (id) initWithPrefix:(NSString *)prefixString suffix:(NSString *)suffixString reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithPrefix:prefixString suffix:suffixString reuseIdentifier:reuseIdentifier];
    if(self)
    {
        // ピッカー
        [self setNumberPicker:[[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 320, 216)]];
        [[self numberPicker] setDataSource:self];
        [[self numberPicker] setDelegate:self];
        
        // テキストフィールド
        [[self textField] setEnableMenu:NO];
        
        // パッキングビュー
        [self setInputPackingView:[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 216)]];
        [[self inputPackingView] setBackgroundColor:[CTColor colorWithHEXString:@"999999"]];
        
        // 配置
        [[self inputPackingView] addSubview:[self numberPicker]];
        [[self textField] setInputView:[self inputPackingView]];
    }
    return self;
}

// 初期化
- (id) initWithPrefix:(NSString *)prefixString content:(NSNumber *)numberValue data:(NSArray *)dataValue format:(NSString *)format suffix:(NSString *)suffixString reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [self initWithPrefix:prefixString suffix:suffixString reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self setDataList:dataValue];
        [self setDisplayFormat:format];
        [self setNumber:numberValue];
    }
    return self;
}


// 値設定
- (void)setNumber:(NSNumber *)numberValue
{
    NSInteger selectRow = 0;
    if(numberValue != nil)
    {
        selectRow = [[self dataList] indexOfObject:numberValue];
    }
    [[self numberPicker] selectRow:selectRow inComponent:0 animated:NO];
}
// 値取得
- (NSNumber *)number
{
    return [[self dataList] objectAtIndex:
            [[self numberPicker] selectedRowInComponent:0]
            ];
}


#pragma mark - UIPickerViewDataSource
//
// UIPickerViewDataSource
//

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [[self dataList] count];
}


#pragma mark - UIPickerViewDelegate
//
// UIPickerViewDelegate
//

//- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component;
//- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component;
- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [NSString stringWithFormat:[self displayFormat], [[self dataList] objectAtIndex:row]];
}
//- (nullable NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:
//- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view;
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSNumber *numberValue = [[self dataList] objectAtIndex:row];
    
    [[self textField] setText:[numberValue stringValue]];
}



@end
