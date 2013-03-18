//
//  CollectionViewController.m
//  WN
//
//  Created by 王尧 on 13-2-20.
//  Copyright (c) 2013年 BuildRun. All rights reserved.
//

#import "CollectionViewController.h"
#import "GoodsNode.h"
#import "InfoCell.h"
#import "AppDelegate.h"

@interface CollectionViewController ()

@property (nonatomic, retain) NSMutableArray *dataSourceArray;

@end

@implementation CollectionViewController

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

- (void)initData
{
    
    self.dataSourceArray = [[[NSMutableArray alloc] init] autorelease];
    
    NSMutableDictionary *dict = [[NSUserDefaults standardUserDefaults] objectForKey:COLLECTION_INFO];
    NSArray *array = [dict allValues];
    
    for (NSDictionary *itemDict in array) {
        NSString *categoryName = [itemDict objectForKey:@"categoryName"];
        NSInteger favNum = [[itemDict objectForKey:@"favNum"] integerValue];
        NSInteger index = [[itemDict objectForKey:@"index"] integerValue];
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
        
        [self.dataSourceArray addObject:goodsNode];
        
        [goodsNode release];
    }
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    [self initData];
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
    
    static NSString *CellIdentifier = @"collectGoodsDetailCell";
    
    InfoCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"InfoCell" owner:self options:nil] objectAtIndex:4];
    }
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    GoodsNode *node = [self.dataSourceArray objectAtIndex:indexPath.row];
        
    [cell refreshGoodsDetaiCellInfo:node];
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 115.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GoodsNode *node = [self.dataSourceArray objectAtIndex:indexPath.row];
    [app.viewController pushFocusDetaiWebViewController:node];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    GoodsNode *node = [self.dataSourceArray objectAtIndex:indexPath.row];
    NSMutableDictionary *dict = [[NSUserDefaults standardUserDefaults] objectForKey:COLLECTION_INFO];
    [dict removeObjectForKey:[NSString stringWithFormat:@"%d",node.index]];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self.dataSourceArray removeObjectAtIndex:indexPath.row];
    
    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationRight];
    
    [tableView reloadData];
}

- (IBAction)cleanAllAction:(id)sender
{
    [MHTool alertWithTitle:nil Message:@"确定删除全部吗？" delegate:self cancelButton:@"确定" otherButton:@"取消"];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
        {
            NSMutableDictionary *dict = [[NSUserDefaults standardUserDefaults] objectForKey:COLLECTION_INFO];
            [dict removeAllObjects];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            [self.dataSourceArray removeAllObjects];
            [self.tableView reloadData];
            
            [MHTool alertWithTitle:nil Message:@"删除成功" delegate:nil cancelButton:@"确定" otherButton:nil];
            
        }
            break;
            
        default:
            break;
    }
}

#pragma mark -
#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource{
	
	//  should be calling your tableviews data source model to reload
	//  put here just for demo
	_reloading = YES;
    [self initData];
}

- (void)doneLoadingTableViewData{
	
	//  model should call this when its done loading
	_reloading = NO;
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
}




@end
