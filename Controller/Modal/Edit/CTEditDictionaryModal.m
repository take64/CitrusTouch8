//
//  CTEditDictionaryModal.m
//  CitrusTouch
//
//  Created by take64 on 2012/11/24.
//  Copyright (c) 2012年 citrus.tk. All rights reserved.
//

#import "CTEditDictionaryModal.h"

#import "CTButton.h"

@interface CTEditDictionaryModal ()

@end

@implementation CTEditDictionaryModal

//
// synthesize
//
@synthesize dictionary;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}
- (void) viewWillAppear:(BOOL)animated
{
    // 削除ボタン表示
    if([self dictionary] != nil)
    {
        [[self removeButton] setHidden:NO];
    }
    else
    {
        [[self removeButton] setHidden:YES];
    }
    
    [super viewWillAppear:animated];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}




#pragma mark -
#pragma mark method
//
// method
//

// 保存
- (void) save
{
    // 閉じる
    [self hide];
}
// 削除
- (void) remove
{
    // 削除処理
    if([self dictionary] != nil)
    {
        [[self dictionary] setObject:@9 forKey:@"status"];
        [[self dictionary] setObject:[NSDate date] forKey:@"modified"];
    }
    
    // 閉じる
    [self hide];
}

@end
