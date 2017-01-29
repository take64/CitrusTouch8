//
//  CTFirebaseSignInFacebook.h
//  ChinottoPod
//
//  Created by kouhei.takemoto on 2017/01/30.
//  Copyright © 2017年 citrus.live. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTFirebaseSignInFacebook : NSObject
{
    // complete block
    CitrusTouchFirebaseSignInBlock signInBlock;
    CitrusTouchFirebaseSignInBlock signOutBlock;
    
    // login manager
    FBSDKLoginManager *loginManager;
}

//
// property
//
@property (nonatomic, copy)   CitrusTouchFirebaseSignInBlock signInBlock;
@property (nonatomic, copy)   CitrusTouchFirebaseSignInBlock signOutBlock;
@property (nonatomic, retain) FBSDKLoginManager *loginManager;



//
// method
//

// sign-in
- (void)signInWithControllr:(UIViewController *)controller;

// bind block
- (void)bindBlockSignIn:(CitrusTouchFirebaseSignInBlock)signIn signOut:(CitrusTouchFirebaseSignInBlock)signOut;

// is sign-in
+ (BOOL)isSignIn;

// singleton
+ (instancetype)sharedService;

@end
