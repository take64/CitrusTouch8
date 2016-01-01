//
//  CTDropboxHttpRequest.h
//  CitrusTouch
//
//  Created by TAKEMOTO KOUHEI on 2013/12/22.
//  Copyright (c) 2013年 citrus.tk. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^CTDropboxHttpRequestComplete)(NSDictionary *userInfo);

@interface CTDropboxHttpRequest : NSObject

// ファイルの保存
+ (void) filePut:(NSData *)dataValue path:(NSString *)pathString complete:(CTDropboxHttpRequestComplete)complete;

@end
