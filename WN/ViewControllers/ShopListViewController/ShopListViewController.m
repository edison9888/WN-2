//
//  ShopListViewController.m
//  WN
//
//  Created by 王尧 on 13-2-18.
//  Copyright (c) 2013年 BuildRun. All rights reserved.
//

#import "ShopListViewController.h"
#import "ShopInfoNode.h"
#import "InfoCell.h"

@interface ShopListViewController ()

@property (nonatomic, retain) NSMutableArray *dataSourceArray;

@end

@implementation ShopListViewController

- (void)dealloc
{
    self.tableView = nil;
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
 ** @Desc   TODO:初始化数据
 ** @author 王尧
 ** @param  N/A
 ** @return N/A
 ** @since  
 */
- (void)initData
{
    self.dataSourceArray = [[[NSMutableArray alloc] init] autorelease];
    [self.httpRequest requestShopListAction];
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
    
    static NSString *CellIdentifier = @"shopDetailCell";
    
    InfoCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"InfoCell" owner:self options:nil] objectAtIndex:2];
    }
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    ShopInfoNode *node = [self.dataSourceArray objectAtIndex:indexPath.row];
    
    [cell refreshShopListCellInfo:node];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 265.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

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
    NSDictionary *dict = [responseString JSONValue];
    if (![[dict objectForKey:@"shopList"] isKindOfClass:[NSArray class]] && [[dict objectForKey:@"shopList"] integerValue] == -1) {
        //数据错误
        return;
    }
    if (dict && [dict isKindOfClass:[NSDictionary class]]) {
        NSArray *array = [dict objectForKey:@"shopList"];
        for (NSDictionary *itemDict in array) {
            ShopInfoNode *node = [[ShopInfoNode alloc] init];
            
            node.address = [itemDict objectForKey:@"address"];
            node.addressE = [itemDict objectForKey:@"addressE"];
            node.index = [[itemDict objectForKey:@"id"] integerValue];
            node.intro = [itemDict objectForKey:@"intro"];
            node.name = [itemDict objectForKey:@"name"];
            node.picURL = [itemDict objectForKey:@"picURL"];
            node.tel = [itemDict objectForKey:@"tel"];
            node.tel2 = [itemDict objectForKey:@"tel2"];
            
            
            [self.dataSourceArray addObject:node];
            [node release];
        }
    }
    [self.tableView reloadData];
}

@end
