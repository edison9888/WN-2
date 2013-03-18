//
//  GoodsListViewController.h
//  WN
//
//  Created by 王 尧 on 13-2-17.
//  Copyright (c) 2013年 BuildRun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseListViewController.h"
@interface GoodsListViewController : BaseListViewController


@property (nonatomic,assign) int cataId;
@property (nonatomic,assign) int itemId;

/**
 ** @Desc   TODO:返回
 ** @author 王尧
 ** @param  N/A
 ** @return N/A
 ** @since
 */
- (IBAction)backAction:(id)sender;

/**
 ** @Desc   TODO:打开淘宝
 ** @author 王尧
 ** @param  N/A
 ** @return N/A
 ** @since
 */
- (IBAction)openTaoBaoAction:(id)sender;

@end
