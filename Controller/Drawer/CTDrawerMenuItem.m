//
//  CTDrawerMenuItem.m
//  ChinottoPod
//
//  Created by kouhei.takemoto on 2017/01/24.
//  Copyright © 2017年 citrus.live. All rights reserved.
//

#import "CTDrawerMenuItem.h"

@implementation CTDrawerMenuItem

//
// synthesize
//
@synthesize title;
@synthesize controller;


// init
- (id)initWithTitle:(NSString *)titleValue controller:(UIViewController *)controllerValue
{
    self = [super init];
    if(self)
    {
        [self setTitle:titleValue];
        [self setController:controllerValue];
    }
    return self;
}

// init
+ (CTDrawerMenuItem *)menuWithTitle:(NSString *)titleValue controller:(UIViewController *)controllerValue
{
    CTDrawerMenuItem *menu = [[CTDrawerMenuItem alloc] initWithTitle:titleValue controller:controllerValue];
    return menu;
}

@end
