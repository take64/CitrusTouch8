//
//  CTFirebaseSignIn.h
//  ChinottoPod
//
//  Created by kouhei.takemoto on 2017/01/28.
//  Copyright © 2017年 citrus.live. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTFirebaseSignIn : NSObject

// いずれかでサインインしていたか
+ (BOOL)isSignInAny;

// Googleでサインインしていたか
+ (BOOL)isSignInGoogle;

// サインインアカウント一覧取得
+ (NSArray<NSString *> *)callSignInList;

@end
