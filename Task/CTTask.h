//
//  CTTask.h
//  ChinottoPod
//
//  Created by kouhei.takemoto on 2017/01/28.
//  Copyright © 2017年 citrus.live. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CTTaskItem.h"

@interface CTTask : NSObject
{
    // task list
    NSMutableArray<CTTaskItem *> *taskItems;
    
//    // task queue
//    dispatch_queue_t taskQueue;
    
    // progress
    CitrusTouchProgressBlock progressBlock;
    
    double delay;
}

//
// property
//
@property (nonatomic, retain) NSMutableArray<CTTaskItem *> *taskItems;
//@property (nonatomic)         dispatch_queue_t taskQueue;
@property (nonatomic, copy)   CitrusTouchProgressBlock progressBlock;
@property (nonatomic, assign) double delay;


//
// method
//

// 開始
- (void)start;

// タスクの追加
- (void)addTask:(CitrusTouchTaskBlock)block;

// タスクの追加
- (void)addTask:(CitrusTouchTaskBlock)block nextTaskAutoStart:(BOOL)autoStart;

@end
