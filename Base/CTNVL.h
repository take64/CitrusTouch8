//
//  CTNVL.h
//  LorsPOS
//
//  Created by TAKEMOTO KOUHEI on 12/01/19.
//  Copyright (c) 2012 citrus.tk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTNVL : NSObject

// NVL関数
+ (id) compare:(id)compare replace:(id)replace;

// NVL2関数
+ (id) compare:(id)compare value1:(id)value1 value2:(id)value2;

@end
