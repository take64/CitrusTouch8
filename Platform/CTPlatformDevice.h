//
//  CTPlatformDevice.h
//  ProtoRegi02
//
//  Created by take64 on 11/12/16.
//  Copyright (c) 2011 citrus.tk. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CTPlatformDevice : NSObject

// Retinaディスプレイ
+ (BOOL) isRetinaDisplay;

// iPhone?
+ (BOOL) isIPhone;

// iPad?
+ (BOOL) isIPad;

// iPod touch?
+ (BOOL) isIPodTouch;

// プラットフォームを取得
+ (NSString *) platform;

// モデルを取得
+ (NSString *) model;

// システム情報取得
+ (NSString *) getSystemInfByName:(char *)typeSpecifier;

// ランダムなUUIDの生成
+ (NSString *) createUUID;


@end
