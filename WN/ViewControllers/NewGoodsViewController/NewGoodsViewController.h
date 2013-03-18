//
//  NewGoodsViewController.h
//  WN
//
//  Created by 王尧 on 13-2-17.
//  Copyright (c) 2013年 BuildRun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface NewGoodsViewController : BaseViewController

@property (nonatomic, retain) IBOutlet UIScrollView *contentScrollView;


/**
 ** @Desc   TODO:打开淘宝
 ** @author 王尧
 ** @param  N/A
 ** @return N/A
 ** @since
 */
- (IBAction)openTaoBaoAction:(id)sender;
@end
