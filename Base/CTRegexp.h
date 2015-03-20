//
//  CTRegexp.h
//  CitrusTouch
//
//  Created by TAKEMOTO KOUHEIon 12/01/17.
//  Copyright (c) 2012 citrus.tk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTRegexp : NSObject


// マッチする回数を取得
+ (int) matchOfPattern:(NSString *)pattern context:(NSString *)context;


@end
