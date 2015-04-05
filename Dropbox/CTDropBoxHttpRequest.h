//
//  CTDropBoxHttpRequest.h
//  CitrusTouch
//
//  Created by TAKEMOTO KOUHEI on 2013/12/22.
//  Copyright (c) 2013年 naissance sapporo co,.Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^CTDropBoxHttpRequestComplete)(NSDictionary *userInfo);

@interface CTDropBoxHttpRequest : NSObject

// ファイルの保存
+ (void) filePut:(NSData *)dataValue path:(NSString *)pathString complete:(CTDropBoxHttpRequestComplete)complete;

@end
