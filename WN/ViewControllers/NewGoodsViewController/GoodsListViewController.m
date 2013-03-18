//
//  GoodsListViewController.m
//  WN
//
//  Created by 王 尧 on 13-2-17.
//  Copyright (c) 2013年 BuildRun. All rights reserved.
//

#import "GoodsListViewController.h"
#import "AppDelegate.h"
#import "GoodsNode.h"
#import "InfoCell.h"

@interface GoodsListViewController ()
{
    int currentPage;
}
@property (nonatomic, retain) NSMutableArray *dataSourceArray;
@property (nonatomic, assign) int dataTotalCount;
@end

@implementation GoodsListViewController
@synthesize itemId;
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

-(void)viewWillAppear:(BOOL)animated{
    [self loadData];
    [self.tableView reloadData];
}

/**
 ** @Desc   TODO:打开淘宝
 ** @author 王尧
 ** @param  N/A
 ** @return N/A
 ** @since
 */
- (IBAction)openTaoBaoAction:(id)sender
{
    [app.viewController pushWebView_TaoBao];
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

/**
 * TODO: 刷新TableView
 * @author Wangyao
 * @param
 * @return
 * @since  
 */
- (void)refreshTableView
{
    [self.tableView reloadData];
    if (self.dataSourceArray.count < self.dataTotalCount) {
        [self showFooterView];
    }else{
        self.tableView.tableFooterView = nil;
    }
}

/**
 * TODO: 加载数据
 * @author Wangyao
 * @param
 * @return
 * @since  
 */
- (void)loadData
{
    [self.httpRequest requestGoodsListActionWith:currentPage pageCount:LIST_PAGE_COUNT cataId:self.cataId];
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
    
    static NSString *CellIdentifier = @"goodsDetailCell";
    
    InfoCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"InfoCell" owner:self options:nil] objectAtIndex:1];
    }
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
    
    GoodsNode *node = [self.dataSourceArray objectAtIndex:indexPath.row];
    
    [cell refreshGoodsDetaiCellInfo:node];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 115.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GoodsNode *node = [self.dataSourceArray objectAtIndex:indexPath.row];
    [app.viewController pushFocusDetaiWebViewController:node];
    [self performSelector:@selector(deselect) withObject:nil afterDelay:0.5f];
}
- (void)deselect
{
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
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
        if (![[dict objectForKey:@"goodsList"] isKindOfClass:[NSArray class]] && [[dict objectForKey:@"goodsList"] integerValue] == -1) {
            //数据错误
            return;
        }
        NSMutableArray *array = [dict objectForKey:@"goodsList"];
        
        if (currentPage == 1) {
            self.dataSourceArray = [[[NSMutableArray alloc] init] autorelease];
        }
        
        for (NSDictionary *itemDict in array) {
            NSString *categoryName = [itemDict objectForKey:@"categoryName"];
            NSInteger favNum = [[itemDict objectForKey:@"favNum"] integerValue];
            NSInteger index = [[itemDict objectForKey:@"id"] integerValue];
            NSString *intro = [itemDict objectForKey:@"intro"];
            NSString *name = [itemDict objectForKey:@"name"];
            NSString *picURL = [itemDict objectForKey:@"picURL"];
            NSInteger price = [[itemDict objectForKey:@"price"] integerValue];
            NSString *taobaoURL = [itemDict objectForKey:@"taobaoURL"];
            
            GoodsNode *goodsNode = [[GoodsNode alloc] init];
            
            goodsNode.categoryName = categoryName;
            goodsNode.favNum = favNum;
            goodsNode.index = index;
            goodsNode.intro = intro;
            goodsNode.name = name;
            goodsNode.picURL = picURL;
            goodsNode.price = price;
            goodsNode.taobaoURL = taobaoURL;
            if (itemId>0) {
                if (goodsNode.index==itemId) {
                    [self.dataSourceArray addObject:goodsNode];
                    [self refreshTableView];
                    [app.viewController performSelector:@selector(pushFocusDetaiWebViewController:) withObject:goodsNode afterDelay:0.3];
                    [goodsNode release];
                    itemId=-1;
                    return;
                }
            }
            [self.dataSourceArray addObject:goodsNode];
            [goodsNode release];
        }
        [self refreshTableView];
    }
}

@end
