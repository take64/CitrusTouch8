//
//  CTFirebaseSignInGoogle.h
//  ChinottoPod
//
//  Created by kouhei.takemoto on 2017/01/24.
//  Copyright © 2017年 citrus.live. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTFirebaseSignInGoogle : NSObject<GIDSignInDelegate>
{
    // complete block
    CitrusTouchFirebaseSignInBlock signInBlock;
    CitrusTouchFirebaseSignInBlock signOutBlock;
}

//
// property
//
@property (nonatomic, copy) CitrusTouchFirebaseSignInBlock signInBlock;
@property (nonatomic, copy) CitrusTouchFirebaseSignInBlock signOutBlock;



//
// method
//

// sign-in
- (void)signInWithControllr:(UIViewController<GIDSignInUIDelegate> *)controller;

// bind block
- (void)bindBlockSignIn:(CitrusTouchFirebaseSignInBlock)signIn signOut:(CitrusTouchFirebaseSignInBlock)signOut;

// is sign-in
+ (BOOL)isSignIn;

// singleton
+ (instancetype)sharedService;

@end
