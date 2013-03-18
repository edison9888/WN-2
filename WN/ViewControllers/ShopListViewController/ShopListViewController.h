//
//  ShopListViewController.h
//  WN
//
//  Created by 王尧 on 13-2-18.
//  Copyright (c) 2013年 BuildRun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"


@interface ShopListViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, retain) IBOutlet UITableView *tableView;


@end
