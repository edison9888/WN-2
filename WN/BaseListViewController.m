//
//  BaseListViewController.m
//  WN
//
//  Created by 王尧 on 13-2-17.
//  Copyright (c) 2013年 BuildRun. All rights reserved.
//

#import "BaseListViewController.h"

@interface BaseListViewController ()

@end

@implementation BaseListViewController

- (void)dealloc
{
    _refreshHeaderView = nil;
    self.httpRequest = nil;
    self.tableView = nil;
    self.tableFooterView = nil;
    [super dealloc];
}

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
    self.httpRequest = [[[WN_HttpRequest alloc] initRequestWithDelegate:self] autorelease];
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    if (_refreshHeaderView == nil) {
		
		EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.tableView.bounds.size.height, self.view.frame.size.width, self.tableView.bounds.size.height)];
		view.delegate = self;
		[self.tableView addSubview:view];
		_refreshHeaderView = view;
		[view release];
	}
	
	//  update the last update date
	[_refreshHeaderView refreshLastUpdatedDate];
}

- (void)loadMore:(id)sender
{
    [self.moreInfoLabel setText:@"正在加载..."];
}

/**
 ** @Desc   TODO:显示FotterView
 ** @author 王尧
 ** @param  N/A
 ** @return N/A
 ** @since  
 */
- (void)showFooterView
{
    if (!self.tableFooterView) {
        self.tableFooterView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)] autorelease];
        self.moreInfoLabel = [[[UILabel alloc] initWithFrame:self.tableFooterView.bounds] autorelease];
        [self.moreInfoLabel setBackgroundColor:[UIColor clearColor]];
        [self.moreInfoLabel setTextAlignment:NSTextAlignmentCenter];
        [self.moreInfoLabel setText:@"点击显示更多"];
        [self.tableFooterView addSubview:self.moreInfoLabel];
        
        UIButton *button = [[UIButton alloc] initWithFrame:[self.tableFooterView bounds]];
        [button addTarget:self action:@selector(loadMore:) forControlEvents:UIControlEventTouchUpInside];
        [self.tableFooterView addSubview:button];
        [button release];
        
        self.tableView.tableFooterView = self.tableFooterView;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	
    [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	
	[_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
	
}


#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
	
	[self reloadTableViewDataSource];
	[self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:3.0];
	
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
	
	return _reloading; // should return if data source model is reloading
	
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
	
	return [NSDate date]; // should return date data source was last changed
	
}



#pragma mark-================================HttpRequestDelegate=====================================
/**   函数名称 :httpRequestError:
 **   函数作用 :TODO:服务器请求错误
 **   函数参数 :errorInfo 错误信息
 **   函数返回值:
 **/
- (void)httpRequestError:(NSString *)errorInfo
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"网络请求错误" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
}

/**
 ** @Desc   TODO:网络请求回调成功
 ** @author 王尧
 ** @param  N/A
 ** @return N/A
 ** @since
 */
- (void)httpRequestFinished:(NSString *)responseString
{
    
}

@end
