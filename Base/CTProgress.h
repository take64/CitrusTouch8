//
//  CTProgress.h
//  ChinottoPod
//
//  Created by kouhei.takemoto on 2016/11/15.
//  Copyright © 2016年 citrus.live. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTProgress : NSObject
{
    NSNumber *processing;
    NSNumber *total;
    
    NSNumber *progress;
//    NSData *resultData;
}

//
// property
//
@property (nonatomic, retain) NSNumber *processing;
@property (nonatomic, retain) NSNumber *total;
@property (nonatomic, retain) NSNumber *progress;
//@property (nonatomic, retain) NSData *resultData;

//
// method
//

// 初期化(途中)
- (id)initWithProgressing:(NSNumber *)progressingNumber total:(NSNumber *)totalNumber;

//// 初期化(完了)
//- (id)initWithResultData:(NSData *)datadile;

// 初期化(完了)
- (id)initWithComplete;

// 初期化(途中)
+ (instancetype)progressing:(NSNumber *)progressingValue total:(NSNumber *)totalValue;

// 初期化(完了)
+ (instancetype)complete;

@end
