//
//  CTDrawerMenuSection.m
//  ChinottoPod
//
//  Created by kouhei.takemoto on 2017/01/25.
//  Copyright © 2017年 citrus.live. All rights reserved.
//

#import "CTDrawerMenuSection.h"

@implementation CTDrawerMenuSection

//
// synthesize
//
@synthesize title;
@synthesize menuItems;


//
// method
//

// init
- (id)initWithTitle:(NSString *)titleValue menuItems:(NSArray<CTDrawerMenuItem *> *)menuItemList
{
    self = [super init];
    if(self)
    {
        [self setTitle:titleValue];
        [self setMenuItems:menuItemList];
    }
    return self;
}

// init
+ (CTDrawerMenuSection *)sectionWithTitle:(NSString *)titleValue menuItems:(NSArray<CTDrawerMenuItem *> *)menuItemList
{
    CTDrawerMenuSection *menuSection = [[CTDrawerMenuSection alloc] initWithTitle:titleValue menuItems:menuItemList];
    return menuSection;
}

@end
