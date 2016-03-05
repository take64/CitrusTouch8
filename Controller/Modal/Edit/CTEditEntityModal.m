//
//  CTEditEntityModal.m
//  CitrusTouch
//
//  Created by take64 on 2012/11/24.
//  Copyright (c) 2012年 citrus.tk. All rights reserved.
//

#import "CTEditEntityModal.h"

#import "CTButton.h"

@interface CTEditEntityModal ()

@end

@implementation CTEditEntityModal

//
// synthesize
//
@synthesize entity;

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
    if([self entity] != nil)
    {
        [[self removeButton] setEnabled:YES];
    }
    else
    {
        [[self removeButton] setEnabled:NO];
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
    // 保存
    [CoreDataManager saveWithMergeObject:[self entity]];
    
    // 閉じる
    [self hide];
}
// 削除
- (void) remove
{
    // 削除処理
    if([self entity] != nil)
    {
        if([[self entity] respondsToSelector:@selector(setStatus:)] == YES)
        {
            [[self entity] performSelector:@selector(setStatus:) withObject:CTCoreDataStatusRemove];
            
            if([[self entity] respondsToSelector:@selector(setModified:)] == YES)
            {
                [[self entity] performSelector:@selector(setModified:) withObject:[NSDate date]];
            }
            [CoreDataManager saveWithMergeObject:[self entity]];
        }
        else
        {
            [CoreDataManager deleteWithSave:[self entity]];
        }
    }
    
    // 閉じる
    [self hide];
}

@end
