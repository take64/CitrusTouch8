//
//  CTWebBrowser.m
//  CitrusTouch
//
//  Created by TAKEMOTO KOUHEI on 2015/10/11.
//  Copyright © 2015年 citrus.tk. All rights reserved.
//

#import "CTWebBrowser.h"

@implementation CTWebBrowser

// Mozilla Firefoxが起動できるか
+ (BOOL)isInstalledFirefox
{
    return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"firefox://"]];
}

// Google Chromeが起動できるか
+ (BOOL)isInstalledChrome
{
    return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"googlechrome://"]];
}

// Operaが起動できるか
+ (BOOL)isInstalledOpera
{
    return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"ohttp://"]];
}

// fenrir Sleipnirが起動できるか
+ (BOOL)isInstalledSleipnir
{
    return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"shttp://"]];
}

// fenrir Sleipnir Blackが起動できるか
+ (BOOL)isInstalledSleipnirBlack
{
    return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"bhttp://"]];
}

// URLを開く
+ (BOOL)openURL:(NSString *)urlString browserKey:(NSString *)browserKey
{
    BOOL result = YES;
    
    // 元URL
    NSString *sourceUrlString = urlString;
    
    // そのままsafariで開く
    if(browserKey == nil)
    {
        
    }
    // firefoxで開く
    else if([browserKey isEqualToString:CTBrowserKeyFirefox] == YES && [CTWebBrowser isInstalledFirefox] == YES)
    {
        urlString = [urlString stringByReplacingOccurrencesOfString:@"https" withString:@"firefox"];
        urlString = [urlString stringByReplacingOccurrencesOfString:@"http" withString:@"firefox"];
    }
    // chromeで開く
    else if([browserKey isEqualToString:CTBrowserKeyChrome] == YES && [CTWebBrowser isInstalledChrome] == YES)
    {
        urlString = [urlString stringByReplacingOccurrencesOfString:@"https" withString:@"googlechrome"];
        urlString = [urlString stringByReplacingOccurrencesOfString:@"http" withString:@"googlechrome"];
    }
    // operaで開く
    else if([browserKey isEqualToString:CTBrowserKeyOpera] == YES && [CTWebBrowser isInstalledOpera] == YES)
    {
        urlString = [urlString stringByReplacingOccurrencesOfString:@"https" withString:@"ohttps"];
        urlString = [urlString stringByReplacingOccurrencesOfString:@"http" withString:@"ohttp"];
    }
    // sleipnirで開く
    else if([browserKey isEqualToString:CTBrowserKeySleipnir] == YES && [CTWebBrowser isInstalledSleipnir] == YES)
    {
        urlString = [urlString stringByReplacingOccurrencesOfString:@"https" withString:@"shttps"];
        urlString = [urlString stringByReplacingOccurrencesOfString:@"http" withString:@"shttp"];
    }
    // sleipnir blackで開く
    else if([browserKey isEqualToString:CTBrowserKeySleipnirBlack] == YES && [CTWebBrowser isInstalledSleipnirBlack] == YES)
    {
        urlString = [urlString stringByReplacingOccurrencesOfString:@"https" withString:@"bhttps"];
        urlString = [urlString stringByReplacingOccurrencesOfString:@"http" withString:@"bhttp"];
    }
    // safariで開く
    else
    {
        // そのままsafariで開く
    }
    
    // 起動する
    if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:urlString]] == YES)
    {
        result = [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
    }
    // 起動できない場合は元のURLでの起動を試みる
    else
    {
        result = [[UIApplication sharedApplication] openURL:[NSURL URLWithString:sourceUrlString]];
    }
    
    
    return result;
}



@end
