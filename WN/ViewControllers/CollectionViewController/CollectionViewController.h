//
//  CollectionViewController.h
//  WN
//
//  Created by 王尧 on 13-2-20.
//  Copyright (c) 2013年 BuildRun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseListViewController.h"
@interface CollectionViewController : BaseListViewController<UIAlertViewDelegate>

- (IBAction)cleanAllAction:(id)sender;
- (void)initData;

@end
