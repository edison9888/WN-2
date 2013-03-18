//
//  BaseListViewController.h
//  WN
//
//  Created by 王尧 on 13-2-17.
//  Copyright (c) 2013年 BuildRun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WN_HttpRequest.h"
#import "EGORefreshTableHeaderView.h"

@interface BaseListViewController : UIViewController<EGORefreshTableHeaderDelegate, UITableViewDelegate, UITableViewDataSource,WN_HttpRequestDelegate>
{
    EGORefreshTableHeaderView *_refreshHeaderView;
    
    BOOL _reloading;
}

@property (nonatomic, retain) WN_HttpRequest *httpRequest;

@property (nonatomic, retain) IBOutlet UITableView *tableView;

@property (nonatomic, retain) UIView   *tableFooterView;
@property (nonatomic, retain) UILabel   *moreInfoLabel;

- (void)reloadTableViewDataSource;
- (void)doneLoadingTableViewData;

/**
 ** @Desc   TODO:显示FotterView
 ** @author 王尧
 ** @param  N/A
 ** @return N/A
 ** @since
 */
- (void)showFooterView;

- (void)loadMore:(id)sender;
@end
