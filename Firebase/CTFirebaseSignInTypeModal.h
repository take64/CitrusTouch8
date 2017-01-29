//
//  CTFirebaseSignInTypeModal.h
//  ChinottoPod
//
//  Created by kouhei.takemoto on 2017/01/23.
//  Copyright © 2017年 citrus.live. All rights reserved.
//

#import "CTSelectKeyModal.h"

@interface CTFirebaseSignInTypeModal : CTSelectKeyModal<GIDSignInUIDelegate>
{
    // 配色
    NSDictionary *colors;
}

//
// property
//
@property (nonatomic, retain) NSDictionary *colors;

@end
