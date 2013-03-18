//
//  WeiBoListViewController.m
//  WN
//
//  Created by 王尧 on 13-2-23.
//  Copyright (c) 2013年 BuildRun. All rights reserved.
//

#import "WeiBoListViewController.h"
#import "WN_Http.h"
#import "WeiBoItemCell.h"

@interface WeiBoListViewController ()
{
    int currentPage;
}

@property (nonatomic, retain) NSMutableArray *dataSourceArray;

@end


@implementation WeiBoListViewController

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    currentPage  =1;
    [self initData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadData
{
    [self.httpRequest requestWithURL:[NSString stringWithFormat:WEI_BO_INFO_URL,currentPage]];
}

- (IBAction)backAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
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

/**
 ** @Desc:   TODO:刷新tableView
 ** @Author: StackHero
 ** @Params: N/A
 ** @Return: N/A
 ** @Since:  
 **/
- (void)refreshTableView
{
    [self.tableView reloadData];
    [self showFooterView];
}


#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"WeiBoItemCellIdentifier";
    
    WeiBoItemCell *cell = (WeiBoItemCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    WeiBoNode *node = [self.dataSourceArray objectAtIndex:indexPath.row];
    if (cell == nil) {
        cell = [[[WeiBoItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier weiBoNode:node] autorelease];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
	// Configure the cell.
    
    [cell refreshCellInfoWith:node];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WeiBoNode *node = [self.dataSourceArray objectAtIndex:indexPath.row];
    
    WeiBoItemCell *cell = [[WeiBoItemCell alloc] init];
    CGFloat h = [cell returnCellHeight:node];
    [cell release];
    return h;
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
#pragma mark-====================HttpRequestDelegate=========================
- (void)httpRequestFinished:(NSString *)responseString
{
    NSDictionary *dict = [responseString JSONValue];
    NSMutableArray *statuseArray = [dict objectForKey:@"statuses"];
    
    if (currentPage == 1) {
        self.dataSourceArray = [[[NSMutableArray alloc] init] autorelease];
    }
    
    for (NSDictionary *itemDict in statuseArray) {
        
        WeiBoNode *node = [[WeiBoNode alloc] init];
        NSString *createDate = [itemDict objectForKey:@"created_at"];
        NSString *thumbImageUrl = [itemDict objectForKey:@"thumbnail_pic"];
        NSString *shareText = [itemDict objectForKey:@"text"];
        NSString *source = [itemDict objectForKey:@"source"];
        NSDictionary *userDict = [itemDict objectForKey:@"user"];
        NSString *screen_name = [userDict objectForKey:@"screen_name"];
        NSString *iconImageUrl = [userDict objectForKey:@"profile_image_url"];

        
        NSDictionary *reTweetDict = [itemDict objectForKey:@"retweeted_status"];
        if (reTweetDict) {
            //如果有回复，那么就需要将回复的原微博显示出来
            NSString *reTweetCreateDate = [reTweetDict objectForKey:@"created_at"];
            NSString *reTweetthumbImageUrl = [reTweetDict objectForKey:@"thumbnail_pic"];
            NSString *reTweetshareText = [reTweetDict objectForKey:@"text"];
            NSString *reTweetsource = [reTweetDict objectForKey:@"source"];
            NSDictionary *reTweetuserDict = [reTweetDict objectForKey:@"user"];
            NSString *reTweetscreen_name = [reTweetuserDict objectForKey:@"screen_name"];
            
            WeiBoNode *retweetWeiBoNode = [[WeiBoNode alloc] init];
            retweetWeiBoNode.createDate = reTweetCreateDate;
            retweetWeiBoNode.thumbImageUrl = reTweetthumbImageUrl;
            retweetWeiBoNode.shareText = reTweetshareText;
            retweetWeiBoNode.source = reTweetsource;
            retweetWeiBoNode.screen_name = reTweetscreen_name;
            node.reTweetWweiBoNode = retweetWeiBoNode;
            [retweetWeiBoNode release];
        }
        
        node.createDate = createDate;
        node.thumbImageUrl = thumbImageUrl;
        node.shareText = shareText;
        node.source = source;
        node.screen_name = screen_name;
        node.iconImageUrl = iconImageUrl;
        
        
        [self.dataSourceArray addObject:node];
        [node release];
    }
    [self refreshTableView];
}


@end
