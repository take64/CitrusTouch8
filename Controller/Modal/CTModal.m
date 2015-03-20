//
//  CTModal.m
//  CitrusTouch
//
//  Created by TAKEMOTO KOUHEI on 2013/02/21.
//  Copyright (c) 2013年 citrus.tk. All rights reserved.
//

#import "CTModal.h"

@interface CTModal ()

@end

@implementation CTModal

//
// synthesize
//
@synthesize _parentController;
@synthesize modalComplete;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



// 表示
- (void) show
{
    if([self _parentController] != nil)
    {
        [[self _parentController] presentViewController:self animated:YES completion:nil];
    }
}
// 表示
- (void) showWithComplete:(CTModalComplete)complete
{
    // 画面閉じ完了
    [self setModalComplete:complete];
    // 表示
    [self show];
}
// 非表示
- (void) hide
{
    [self dismissViewControllerAnimated:YES completion:^(void){
        // 画面閉じ完了がある場合
        if([self modalComplete] != nil)
        {
            self.modalComplete(self);
        }
    }];
}

@end
