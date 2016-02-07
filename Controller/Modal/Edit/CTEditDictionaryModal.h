//
//  CTEditDictionaryModal.h
//  CitrusTouch
//
//  Created by take64 on 2012/11/24.
//  Copyright (c) 2012年 citrus.tk. All rights reserved.
//

#import "CTEditModal.h"

@interface CTEditDictionaryModal : CTEditModal
{
    // 対象Dictionary
    NSMutableDictionary *dictionary;
}

//
// property
//
@property (nonatomic, retain) NSMutableDictionary *dictionary;

@end
