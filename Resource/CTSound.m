//
//  CTSound.m
//  CitrusTouch
//
//  Created by Take on 13/12/12.
//  Copyright (c) 2013年 naissance sapporo co,.Ltd. All rights reserved.
//

#import "CTSound.h"

@implementation CTSound

// ボタン押下音
+ (void)playButtonSound
{
    static SystemSoundID beepSoundId;
    if(!beepSoundId)
    {
        NSBundle *mainBundle = [NSBundle mainBundle];
        NSURL *beepWavURL = [NSURL fileURLWithPath:[mainBundle pathForResource:@"buttonSound" ofType:@"m4a"] isDirectory:NO];
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)beepWavURL, &beepSoundId);
    }
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void) {
        AudioServicesPlaySystemSound(beepSoundId);
    });
}

@end
