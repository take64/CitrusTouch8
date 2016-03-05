//
//  CTModal.h
//  CitrusTouch
//
//  Created by take64 on 2013/02/21.
//  Copyright (c) 2013年 citrus.tk. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void (^CTModalComplete)(id modal);

@class CTColor;

@interface CTModal : UINavigationController
{
//    // 親コントローラー
//    UIViewController *_parentController;
    
    // 画面閉じ完了
    CTModalComplete modalComplete;
    
}



//
// property
//
//@property (nonatomic, retain) UIViewController *_parentController;
@property (nonatomic, copy) CTModalComplete modalComplete;

//
// method
//

// 表示
- (void) showWithParent:(UIViewController *)parent;
// 表示
- (void) showWithParent:(UIViewController *)parent complete:(CTModalComplete)complete;
// 非表示
- (void) hide;



@end
