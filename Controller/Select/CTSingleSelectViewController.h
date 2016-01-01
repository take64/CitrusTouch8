//
//  CTSingleSelectViewController.h
//  CitrusTouch
//
//  Created by Take on 13/12/26.
//  Copyright (c) 2013年 citrus.tk. All rights reserved.
//

#import "CTListViewController.h"

typedef void (^CTListViewControllerComplete)(id selectedObject);

@interface CTSingleSelectViewController : CTListViewController
{
    id selectedObject;  // 選択オブジェクト
    
    CTListViewControllerComplete complete; // コールバック
}

//
// property
//
@property (nonatomic, retain) id selectedObject;
@property (nonatomic, copy)   CTListViewControllerComplete complete;


//
// method
//

// オブジェクト読み込み
- (void)loadObject:(id)objectValue complete:(CTListViewControllerComplete)completeBlock;

@end
