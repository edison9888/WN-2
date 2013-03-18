//
//  PromotionViewController.m
//  WN
//
//  Created by 王尧 on 13-2-17.
//  Copyright (c) 2013年 BuildRun. All rights reserved.
//

#import "PromotionViewController.h"
#import "PromotionNode.h"
#import "InfoCell.h"

@interface PromotionViewController ()
{
    int currentPage;
}
@property (nonatomic, retain) NSMutableArray *dataSourceArray;
@property (nonatomic, assign) int dataTotalCount;
@end

@implementation PromotionViewController


- (void)dealloc
{
    self.dataSourceArray = nil;
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
/**
 ** @Desc   TODO:返回
 ** @author 王尧
 ** @param  N/A
 ** @return N/A
 ** @since
 */
- (IBAction)backAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)refreshTableView
{
    [self.tableView reloadData];
    if (self.dataSourceArray.count < self.dataTotalCount) {
        [self showFooterView];
    }else{
        self.tableView.tableFooterView = nil;
    }
}

- (void)loadData
{
    [self.httpRequest requestPromotionListActionWith:currentPage pageCount:LIST_PAGE_COUNT];
}

/**
 ** @Desc   TODO:初始化数据
 ** @author 王尧
 ** @param  N/A
 ** @return N/A
 ** @since
 */
- (void)initData
{
    self.dataSourceArray = [[[NSMutableArray alloc] init] autorelease];
    [self loadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    currentPage  =1;
    [self initData];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"promotionCell";
    
    InfoCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"InfoCell" owner:self options:nil] objectAtIndex:3];
    }
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    PromotionNode *node = [self.dataSourceArray objectAtIndex:indexPath.row];
    [cell refreshPromotionCellInfo:node];
    
	// Configure the cell.
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 186.0f;
}

#pragma mark -
#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource{
	
	//  should be calling your tableviews data source model to reload
	//  put here just for demo
	_reloading = YES;
    currentPage = 1;
    [self loadData];
}

- (void)doneLoadingTableViewData{
	
	//  model should call this when its done loading
	_reloading = NO;
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
}


- (void)loadMore:(id)sender
{
    [super loadMore:sender];
    
    currentPage ++;
    [self loadData];
}

#pragma mark-================================HttpRequestDelegate=====================================
/**
 ** @Desc   TODO:网络请求回调成功
 ** @author 王尧
 ** @param  N/A
 ** @return N/A
 ** @since
 */
- (void)httpRequestFinished:(NSString *)responseString
{
    NSDictionary *dict = [responseString JSONValue];
    if ([[dict objectForKey:@"success"] boolValue]) {
        self.dataTotalCount = [[dict objectForKey:@"total"] integerValue];
        if (![[dict objectForKey:@"promotionList"] isKindOfClass:[NSArray class]] && [[dict objectForKey:@"promotionList"] integerValue] == -1) {
            //数据错误
            return;
        }
        NSMutableArray *array = [dict objectForKey:@"promotionList"];
        
        if (currentPage == 1) {
            self.dataSourceArray = [[[NSMutableArray alloc] init] autorelease];
        }
        
        for (NSDictionary *itemDict in array) {
            PromotionNode *node = [[PromotionNode alloc] init];
            
            node.content = [itemDict objectForKey:@"content"];
            node.endDate = [itemDict objectForKey:@"endDate"];
            node.index = [[itemDict objectForKey:@"id"] integerValue];
            node.intro = [itemDict objectForKey:@"intro"];
            node.picURL = [itemDict objectForKey:@"picURL"];
            node.startDate = [itemDict objectForKey:@"startDate"];
            node.title = [itemDict objectForKey:@"title"];
            
            [self.dataSourceArray addObject:node];
            [node release];
        }
        [self refreshTableView];
    }
}
@end
