//
//  CTFirebaseSignIn.m
//  ChinottoPod
//
//  Created by kouhei.takemoto on 2017/01/28.
//  Copyright © 2017年 citrus.live. All rights reserved.
//

#import "CTFirebaseSignIn.h"

@implementation CTFirebaseSignIn

// いずれかでサインインしていたか
+ (BOOL)isSignInAny
{
    if([CTFirebaseSignInGoogle isSignIn] == YES)
    {
        return YES;
    }
    
    return NO;
}

// Googleでサインインしていたか
+ (BOOL)isSignInGoogle
{
    return [CTFirebaseSignInGoogle isSignIn];
}

// サインインアカウント一覧取得
+ (NSArray<NSString *> *)callSignInList
{
    NSMutableArray *lists = [NSMutableArray array];
    
    if([self isSignInGoogle] == YES)
    {
        [lists addObject:CTFirebaseSignInTypeGoogle];
    }
    return [lists copy];
}

@end
