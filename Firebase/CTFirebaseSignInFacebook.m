//
//  CTFirebaseSignInFacebook.m
//  ChinottoPod
//
//  Created by kouhei.takemoto on 2017/01/30.
//  Copyright © 2017年 citrus.live. All rights reserved.
//

#import "CTFirebaseSignInFacebook.h"

@implementation CTFirebaseSignInFacebook

//
// synthesize
//
@synthesize signInBlock;
@synthesize signOutBlock;
@synthesize loginManager;



// 初期化
- (id)init
{
    self = [super init];
    if(self)
    {
        [self setLoginManager:[[FBSDKLoginManager alloc] init]];
    }
    return self;
}


//
// method
//

// sign in
- (void)signInWithControllr:(UIViewController *)controller;
{
    [[self loginManager] logInWithReadPermissions:@[ @"public_profile", @"email" ] fromViewController:controller handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
       
        FIRAuthCredential *credential = [FIRFacebookAuthProvider credentialWithAccessToken:[[FBSDKAccessToken currentAccessToken] tokenString]];
        
        if(error == nil)
        {
            if([[FIRAuth auth] currentUser])
            {
                [[[FIRAuth auth] currentUser] linkWithCredential:credential completion:^(FIRUser * _Nullable user, NSError * _Nullable error) {
                    
                    
                    if(self.signInBlock != nil)
                    {
                        self.signInBlock(user, error);
                    }
                }];
            }
            else
            {
                [[FIRAuth auth] signInWithCredential:credential completion:^(FIRUser * _Nullable user, NSError * _Nullable error) {
                    
                    if(self.signInBlock != nil)
                    {
                        self.signInBlock(user, error);
                    }
                }];
            }
        }
    }];
}

// bind block
- (void)bindBlockSignIn:(CitrusTouchFirebaseSignInBlock)signIn signOut:(CitrusTouchFirebaseSignInBlock)signOut
{
    [self setSignInBlock:signIn];
    [self setSignOutBlock:signOut];
}


// is sign-in
+ (BOOL)isSignIn
{
    BOOL result = NO;
    if([[FIRAuth auth] currentUser])
    {
        NSArray<id<FIRUserInfo>> *providerData = [[[FIRAuth auth] currentUser] providerData];
        for(id<FIRUserInfo> userInfo in providerData)
        {
            if([[userInfo providerID] isEqualToString:@"google.com"] == YES)
            {
                result = YES;
                break;
            }
        }
    }
    return result;
}

// singleton
+ (instancetype)sharedService
{
    static id singleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [[[self class] alloc] init];
    });
    return singleton;
}

@end
