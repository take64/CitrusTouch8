//
//  CTEditEntityModal.h
//  CitrusTouch
//
//  Created by take64 on 2012/11/24.
//  Copyright (c) 2012年 citrus.tk. All rights reserved.
//

#import "CTEditModal.h"

@interface CTEditEntityModal : CTEditModal
{
    // 対象Entity
    NSManagedObject *entity;
}

//
// property
//
@property (nonatomic, retain) NSManagedObject *entity;

@end
