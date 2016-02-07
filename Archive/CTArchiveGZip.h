//
//  CTArchiveGZip.h
//  CitrusTouch
//
//  Created by take64 on 2016/01/11.
//  Copyright © 2016年 citrus.tk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTArchiveGZip : NSObject

// 圧縮
+ (NSData *)archive:(NSData *)dataValue level:(int)level;

// 解凍
+ (NSData *)unarchive:(NSData *)dataValue;

@end
