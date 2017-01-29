//
//  CitrusTouchFirebase.h
//  ChinottoPod
//
//  Created by kouhei.takemoto on 2017/01/23.
//  Copyright © 2017年 citrus.live. All rights reserved.
//

#ifndef CitrusTouchFirebase_h
#define CitrusTouchFirebase_h

static NSString *CTFirebaseSignInTypeFacebook   = @"facebook";  // facebook
static NSString *CTFirebaseSignInTypeTwitter    = @"twitter";   // twitter
static NSString *CTFirebaseSignInTypeGoogle     = @"google";    // google

// Firebase
#import "Firebase.h"

// google
#import <GoogleSignIn/GoogleSignIn.h>

// facebook
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>


typedef void (^CitrusTouchFirebaseSignInBlock)(FIRUser *user, NSError *error);

//typedef void (^CitrusTouchFirebaseSignInGoogleBlock)(GIDGoogleUser *user, NSError *error);
//typedef void (^CitrusTouchFirebaseSignInFacebookBlock)(void);

typedef void (^CitrusTouchFirebaseDatabaseResultBlock)(NSDictionary *result);


#import "CTFirebaseSignInTypeModal.h"

// sign-in
#import "CTFirebaseSignIn.h"
#import "CTFirebaseSignInGoogle.h"
#import "CTFirebaseSignInFacebook.h"

// database
#import "CTFirebaseDatabase.h"


#endif /* CitrusTouchFirebase_h */
