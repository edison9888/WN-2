//
//  NewGoodsViewController.m
//  WN
//
//  Created by 王尧 on 13-2-17.
//  Copyright (c) 2013年 BuildRun. All rights reserved.
//

#import "NewGoodsViewController.h"
#import "GoodCataNode.h"
#import "AppDelegate.h"

@interface NewGoodsViewController ()

@property (nonatomic, retain) NSMutableArray *dataSourceArray;

@end

@implementation NewGoodsViewController

- (void)dealloc
{
    self.dataSourceArray = nil;
    self.contentScrollView = nil;
    [super dealloc];
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


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

/**
 * TODO: 打开分类列表
 * @author Wangyao
 * @param  node 分类节点
 * @return
 * @since  
 */
- (void)openCataListView:(id)sender
{
    int cataIndexId = [(UIButton *)sender tag];
    [app.viewController pushGoodsListViewControllerWithCataId:cataIndexId];
}


/**
 * TODO: 创建新品的单个View
 * @author Wangyao
 * @param node新品类别节点
 * @return UIView 创建的View
 * @since
 */
- (UIView *)itemViewCreated:(GoodCataNode *)node
{
    UIImage *frameImage = [[UIImage alloc] initWithContentsOfFile:[MHFile getResourcesFile:@"nts_item_bg.png"]];
    
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frameImage.size.width, frameImage.size.height)];
    //ImageView
    UIImageView *contentImageView = [[UIImageView alloc] initWithFrame:contentView.bounds];
 //   [contentImageView setImageWithURL:[NSURL URLWithString:node.picURL] placeholderImage:nil];
    [contentImageView setImageWithURL:[NSURL URLWithString:node.picURL] placeholderImage:nil isGood:YES];
    [contentView addSubview:contentImageView];
    [contentImageView release];
    //Button
    UIButton *button = [[UIButton alloc] initWithFrame:contentView.bounds];
    button.tag = node.index;
    [button addTarget:self action:@selector(openCataListView:) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:frameImage forState:UIControlStateNormal];
    [contentView addSubview:button];
    [button release];
    
    [frameImage release];
    
    return [contentView autorelease];
}

/**
 ** @Desc   TODO:刷新内容界面
 ** @author 王尧
 ** @param  N/A
 ** @return N/A
 ** @since  
 */
- (void)refreshContentView
{
    UIImage *frameImage = [[UIImage alloc] initWithContentsOfFile:[MHFile getResourcesFile:@"nts_item_bg.png"]];
    int half_Width = (160 - frameImage.size.width)/2;
    [frameImage release];
    
    int row = 0;
    int height = 0;
    for (int i = 0 ; i < self.dataSourceArray.count; i++) {
        GoodCataNode *node = [self.dataSourceArray objectAtIndex:i];
        UIView *view = [self itemViewCreated:node];
        if ((i + 1) % 2 != 0) {
            //第一排
            [view setFrame:CGRectMake(half_Width, half_Width + row*(view.frame.size.height + half_Width), view.frame.size.width, view.frame.size.height)];
            height += view.frame.size.height + half_Width;
            
        }else{
            //第二排
            [view setFrame:CGRectMake(half_Width*3 + view.frame.size.width, half_Width + row*(view.frame.size.height + half_Width), view.frame.size.width, view.frame.size.height)];
            row ++;
        }
        [self.contentScrollView addSubview:view];
    }
    [self.contentScrollView setContentSize:CGSizeMake(320, height)];
}

- (void)initData
{
    self.dataSourceArray = [[[NSMutableArray alloc] init] autorelease];
    [self.httpRequest requestGoodsCatagoryListAction];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    if (![[dict objectForKey:@"goodsCategoryList"] isKindOfClass:[NSArray class]] && [[dict objectForKey:@"goodsCategoryList"] integerValue] == -1) {
        //数据错误
        return;
    }
    NSMutableArray *array = [dict objectForKey:@"goodsCategoryList"];
    for (NSDictionary *itemDict in array) {
        GoodCataNode *node = [[GoodCataNode alloc] init];
        
        node.index = [[itemDict objectForKey:@"id"] integerValue];
        node.name = [itemDict objectForKey:@"name"];
        node.picURL = [itemDict objectForKey:@"picURL"];
        
        [self.dataSourceArray addObject:node];
        [node release];
    }
    
    [self refreshContentView];
}


@end
