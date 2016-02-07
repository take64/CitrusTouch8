//
//  CTFile.h
//  CitrusTouch
//
//  Created by take64 on 9/20/14.
//  Copyright (c) 2014 citrus.tk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTFile : NSObject

// Documentにファイルがあるか
+ (BOOL) existDocumentFile:(NSString *)filename;

// Documentのファイルを取得
+ (NSData *) loadDocumentFile:(NSString *)filename;

// Documentにファイルを保存
+ (void) saveDocument:(NSData *)dataValue filename:(NSString *)filename;

@end
