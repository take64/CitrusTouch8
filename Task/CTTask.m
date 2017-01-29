//
//  CTTask.m
//  ChinottoPod
//
//  Created by kouhei.takemoto on 2017/01/28.
//  Copyright © 2017年 citrus.live. All rights reserved.
//

#import "CTTask.h"

@implementation CTTask

//
// synthesize
//
@synthesize taskItems;
//@synthesize taskQueue;
@synthesize progressBlock;
@synthesize delay;


// 初期化
- (id)init
{
    self = [super init];
    if(self)
    {
        // 初期化
        [self setTaskItems:[NSMutableArray array]];
        
        [self setDelay:0];
    }
    return self;
}


//
// method
//

// 開始
- (void)start
{
    // 実行予定タスク
    CTTaskItem *nextTask = nil;
    // 実行中タスク
    CTTaskItem *processingTask = nil;
    // タスク数
    int waitCount = 0;
    int processingCount = 0;
    int completeCount = 0;
    int totalCount = 0;
    
    // タスク処理
    for(CTTaskItem *one in [self taskItems])
    {
        // 総数
        totalCount++;
        // 処理分け
        switch ([one state])
        {
            case CitrusTouchTaskStateWait:
                // 実行待ち
                if(nextTask == nil)
                {
                    nextTask = one;
                }
                waitCount++;
                break;
            case CitrusTouchTaskStateProcessing:
                // 実行中
                processingTask = one;
                processingCount++;
                break;
            case CitrusTouchTaskStateComplete:
                // 実行終了
                completeCount++;
                break;
                
            default:
                break;
        }
    }
    
    // 実行中タスクがない場合は、実行予定タスクを実行
    if(processingTask == nil
       && nextTask != nil)
    {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, [self delay] * NSEC_PER_SEC), [CTTask sharedQueue], ^{
            
//        dispatch_async([CTTask sharedQueue], ^{
            
            [nextTask start];
        });
        
        dispatch_async([CTTask sharedQueue], ^{
           
            [nextTask setState:CitrusTouchTaskStateComplete];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if(self.progressBlock != nil)
                {
                    self.progressBlock([CTProgress progressing:@(completeCount+1) total:@(totalCount)], nil);
                }
                
                // 回帰実行する
                if([nextTask nextTaskAutoStart] == YES)
                {
                    [self start];
                }
            });
        });
        
    }
}


//// 開始
//- (void)start
//{
////    // 実行予定タスク
////    CTTaskItem *nextTask = nil;
////    // 実行中タスク
////    CTTaskItem *processingTask = nil;
////    // タスク数
////    int waitCount = 0;
////    int processingCount = 0;
////    int completeCount = 0;
////    int totalCount = 0;
//    
//    // タスク処理
//    for(CTTaskItem *one in [self taskItems])
//    {
//        dispatch_async([CTTask sharedQueue], ^{
//           
//            [one start];
//            [one setState:CitrusTouchTaskStateComplete];
//            
//            dispatch_async(dispatch_get_main_queue(), ^{
//                
//                if(self.progressBlock != nil)
//                {
//                    self.progressBlock([CTProgress progressing:@([[self taskItems] indexOfObject:one]+1) total:@([[self taskItems] count])], nil);
//                }
//            });
//        });
//        
//        
////        // 総数
////        totalCount++;
////        // 処理分け
////        switch ([one state])
////        {
////            case CitrusTouchTaskStateWait:
////                // 実行待ち
////                if(nextTask == nil)
////                {
////                    nextTask = one;
////                }
////                waitCount++;
////                break;
////            case CitrusTouchTaskStateProcessing:
////                // 実行中
////                processingTask = one;
////                processingCount++;
////                break;
////            case CitrusTouchTaskStateComplete:
////                // 実行終了
////                completeCount++;
////                break;
////                
////            default:
////                break;
////        }
//    }
//    
////    // 実行中タスクがない場合は、実行予定タスクを実行
////    if(processingTask == nil
////       && nextTask != nil)
////    {
////        dispatch_async([CTTask sharedQueue], ^{
////            
////            [nextTask start];
////        });
////        
////        dispatch_async([CTTask sharedQueue], ^{
////            
////            [nextTask setState:CitrusTouchTaskStateComplete];
////            
////            dispatch_async(dispatch_get_main_queue(), ^{
////                
////                if(self.progressBlock != nil)
////                {
////                    self.progressBlock([CTProgress progressing:@(completeCount+1) total:@(totalCount)], nil);
////                }
////                
////                // 回帰実行する
////                [self start];
////            });
////        });
////        
////    }
//}

// タスクの追加
- (void)addTask:(CitrusTouchTaskBlock)block
{
//    [[self taskItems] addObject:[CTTaskItem taskWithBlock:block]];
    [self addTask:block nextTaskAutoStart:YES];
}

// タスクの追加
- (void)addTask:(CitrusTouchTaskBlock)block nextTaskAutoStart:(BOOL)autoStart
{
    [[self taskItems] addObject:[CTTaskItem taskWithBlock:block nextTaskAutoStart:autoStart]];
}


#pragma mark - singleton
//
// singleton
//

// shared queue
+ (dispatch_queue_t)sharedQueue
{
    static dispatch_queue_t queue = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        queue = dispatch_queue_create("live.citrus.touch.task", DISPATCH_QUEUE_SERIAL);
    });
    return queue;
}



@end
