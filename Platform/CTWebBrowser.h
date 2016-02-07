//
//  CTWebBrowser.h
//  CitrusTouch
//
//  Created by take64 on 2015/10/11.
//  Copyright © 2015年 citrus.tk. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *CTBrowserKeyInner          = @"inner";         // http:// https://
static NSString *CTBrowserKeySafari         = @"safari";        // http:// https://
static NSString *CTBrowserKeyFirefox        = @"firefox";       // firefox://
static NSString *CTBrowserKeyChrome         = @"chrome";        // googlechrome:// googlechromes://
static NSString *CTBrowserKeyOpera          = @"opera";         // ohttp:// ohttps:// oftp://
static NSString *CTBrowserKeySleipnir       = @"sleipnir";      // shttp:// shttps://
static NSString *CTBrowserKeySleipnirBlack  = @"sleipnir_black";// bhttp:// bhttps://

@interface CTWebBrowser : NSObject

// Mozilla Firefoxが起動できるか
+ (BOOL)isInstalledFirefox;

// Google Chromeが起動できるか
+ (BOOL)isInstalledChrome;

// Opera miniが起動できるか
+ (BOOL)isInstalledOpera;

// fenrir Sleipnirが起動できるか
+ (BOOL)isInstalledSleipnir;

// fenrir Sleipnir Blackが起動できるか
+ (BOOL)isInstalledSleipnirBlack;

// URLを開く
+ (BOOL)openURL:(NSString *)urlString browserKey:(NSString *)browserKey;

// 名称リスト取得
+ (NSArray *)callNames;

// 名称Dic取得
+ (NSDictionary *)callNameDicWithKey:(NSString *)keyString;

// 名称取得
+ (NSString *)callNameStringWidhKey:(NSString *)keyString;


@end
