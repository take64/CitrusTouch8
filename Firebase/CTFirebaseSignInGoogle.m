//
//  CTFirebaseSignInGoogle.m
//  ChinottoPod
//
//  Created by kouhei.takemoto on 2017/01/24.
//  Copyright © 2017年 citrus.live. All rights reserved.
//

#import "CTFirebaseSignInGoogle.h"

@implementation CTFirebaseSignInGoogle

//
// synthesize
//
@synthesize signInBlock;
@synthesize signOutBlock;




#pragma mark - GIDSignInDelegate
//
// GIDSignInDelegate
//

// sign-in
- (void)signIn:(GIDSignIn *)signIn didSignInForUser:(GIDGoogleUser *)user withError:(NSError *)error
{
    GIDAuthentication *authentication = [user authentication];
    FIRAuthCredential *credential = [FIRGoogleAuthProvider credentialWithIDToken:[authentication idToken] accessToken:[authentication accessToken]];
    
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
}

// sign-out
- (void)signIn:(GIDSignIn *)signIn didDisconnectWithUser:(GIDGoogleUser *)user withError:(NSError *)error
{
    if(self.signOutBlock != nil)
    {
        self.signOutBlock(user, error);
    }
}


//
// method
//

// sign in
- (void)signInWithControllr:(UIViewController<GIDSignInUIDelegate> *)controller;
{
    [[GIDSignIn sharedInstance] setUiDelegate:controller];
    [[GIDSignIn sharedInstance] signIn];
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
