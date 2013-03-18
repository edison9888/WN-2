//
//  ViewController.m
//  WN
//
//  Created by 王 尧 on 13-2-16.
//  Copyright (c) 2013年 BuildRun. All rights reserved.
//

#import "ViewController.h"
#import "TabBarView.h"
#import "InfoViewController.h"

#import "WN_Http.h"

#import "FocusNode.h"
#import "FashionNewsNode.h"
#import "GoodsNode.h"

#import "WebDetailViewController.h"
#import "FashionInfoViewController.h"
#import "PromotionViewController.h"
#import "NewGoodsViewController.h"
#import "GoodsListViewController.h"
#import "ShopListViewController.h"
#import "MoreViewController.h"
#import "ShareViewController.h"
#import "CollectionViewController.h"
#import "WeiBoListViewController.h"


@interface ViewController ()

@property (nonatomic, retain) UINavigationController *info_NavigateViewController;


@property (nonatomic, retain) InfoViewController        *infoViewController;
@property (nonatomic, retain) NewGoodsViewController    *goodsCataViewController;
@property (nonatomic, retain) ShopListViewController    *shopListViewController;
@property (nonatomic, retain) MoreViewController        *moreViewController;


@end

@implementation ViewController

- (void)dealloc
{
    self.tabView = nil;
    self.info_NavigateViewController = nil;
    self.infoViewController = nil;
    self.goodsCataViewController = nil;
    self.shopListViewController = nil;
    self.moreViewController = nil;
    self.collectViewController = nil;
    
    [super dealloc];
}

- (void)initTabView
{
    self.tabView = [[[NSBundle mainBundle] loadNibNamed:@"TabBarView" owner:self options:nil] lastObject];
    [self.tabView setDelegate:self];
    [self.tabView setFrame:CGRectMake(0, self.view.frame.size.height-self.tabView.frame.size.height, self.tabView.frame.size.width, self.tabView.frame.size.height)];
    [self.view addSubview:self.tabView];
}

/**
 * TODO: 初始化情报ViewController
 * @author Wangyao
 * @param  N/A
 * @return N/A
 * @since  N/A
 */
- (void)initInfoViewController
{
    if (self.infoViewController) {
        [self.view bringSubviewToFront:self.infoViewController.view];
    }else{
        self.infoViewController = [[[InfoViewController alloc] initWithNibName:@"InfoViewController" bundle:nil] autorelease];
        [self.view addSubview:self.infoViewController.view];
    }
}

/**
 * TODO: 初始化新品ViewController
 * @author Wangyao
 * @param
 * @return
 * @since  
 */
- (void)initNewGoodsViewController
{
    if (self.goodsCataViewController) {
        [self.view bringSubviewToFront:self.goodsCataViewController.view];
    }else{
        self.goodsCataViewController = [[[NewGoodsViewController alloc] initWithNibName:@"NewGoodsViewController" bundle:nil] autorelease];
        [self.view addSubview:self.goodsCataViewController.view];
    }
}

/**
 ** @Desc   TODO:初始化门市ViewController
 ** @author 王尧
 ** @param  N/A
 ** @return N/A
 ** @since  
 */
- (void)initShopInfoViewController
{
    if (self.shopListViewController) {
        [self.view bringSubviewToFront:self.shopListViewController.view];
    }else{
        self.shopListViewController = [[[ShopListViewController alloc] initWithNibName:@"ShopListViewController" bundle:nil] autorelease];
        [self.view addSubview:self.shopListViewController.view];
    }
}

/**
 ** @Desc   TODO:初始化收藏ViewController
 ** @author 王尧
 ** @param  N/A
 ** @return N/A
 ** @since  
 */
- (void)initCollectionViewController
{
    if (self.collectViewController) {
        [self.view bringSubviewToFront:self.collectViewController.view];
    }else{
        self.collectViewController = [[[CollectionViewController alloc] initWithNibName:@"CollectionViewController" bundle:nil] autorelease];
        [self.view addSubview:self.collectViewController.view];
    }
}

/**
 ** @Desc   TODO:初始化更多ViewController
 ** @author 王尧
 ** @param  N/A
 ** @return N/A
 ** @since  
 */
- (void)initMoreViewController
{
    if (self.moreViewController) {
        [self.view bringSubviewToFront:self.moreViewController.view];
    }else{
        self.moreViewController = [[[MoreViewController alloc] initWithNibName:@"MoreViewController" bundle:nil] autorelease];
        [self.view addSubview:self.moreViewController.view];
    }
}

- (void)initView
{
    [self initTabView];
    [self initInfoViewController];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self initView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark-================================================TabBarViewDelegate========================================
/**
 * TODO: 某个模块被选中
 * @author Wangyao
 * @param  index  选中的下标
 * @return N/A
 * @since  2013 02 16
 */
- (void)itemDidSelectedIndex:(int)index
{
    switch (index) {
        case 0:
            [self initInfoViewController];
            break;
        case 1:
            [self initNewGoodsViewController];
            break;
        case 2:
            [self initShopInfoViewController];
            break;
        case 3:
            [self initCollectionViewController];
            break;
        case 4:
            [self initMoreViewController];
            break;
            
        default:
            break;
    }
    /*
    CATransition *transition=[CATransition animation];
    [transition setDuration:0.5f];
    [transition setType:kCATransitionReveal];
    [transition setSubtype:kCATransitionFromRight];
    [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [self.view.layer addAnimation:transition forKey:@"switchview"];
    NSLog(@"%d",[self.view.layer.sublayers count]);
     */
}

#pragma mark-==================================NavigationController  Push  Action======================================
/**
 ** @Desc   TODO:打开焦点详情界面
 ** @author 王尧
 ** @param  (id)node  详情节点
 ** @return N/A
 ** @since
 */
- (void)pushFocusDetaiWebViewController:(id)node
{
    WebDetailViewController *detailViewController = [[WebDetailViewController alloc] initWithNibName:@"WebDetailViewController" bundle:nil];
    [self.navigationController pushViewController:detailViewController animated:YES];
    
    if ([node isKindOfClass:[FocusNode class]]) {
        [detailViewController loadWebViewWithUrl:[NSString stringWithFormat:FOCUS_SHOWINFO_JSP_URL,[(FocusNode *)node index]] type:DETAIL_TYPE_FOCUS_RECOM];
        
    }else if([node isKindOfClass:[FashionNewsNode class]]){
        detailViewController.fashionNode = (FashionNewsNode *)node;
        [detailViewController loadWebViewWithUrl:[NSString stringWithFormat:NEWS_SHOWINFO_JSP_URL,[(FashionNewsNode *)node index]] type:DETAIL_TYPE_FASHION_NEWS];
        
    }else if([node isKindOfClass:[GoodsNode class]]){
        detailViewController.goodsNode = (GoodsNode *)node;
        [detailViewController loadWebViewWithUrl:[(GoodsNode *)node taobaoURL] type:DETAIL_TYPE_GOODS];
        
    }
    [detailViewController release];
}

- (void)pushWebView_Pingpai
{
    WebDetailViewController *detailViewController = [[WebDetailViewController alloc] initWithNibName:@"WebDetailViewController" bundle:nil];
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController loadWebPingPaiInfo:COMPANY_INFO_SHOW_JSP_URL];
    [detailViewController release];
}
- (void)pushWebView_TaoBao
{
    WebDetailViewController *detailViewController = [[WebDetailViewController alloc] initWithNibName:@"WebDetailViewController" bundle:nil];
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController loadWebTaoBaoView:TAO_BAO_URL];
    [detailViewController release];
}

/**
 ** @Desc   TODO:打开时尚资讯
 ** @author 王尧
 ** @param  N/A
 ** @return N/A 
 ** @since
 */
- (void)pushFashionNewsListViewController
{
    FashionInfoViewController *viewController = [[FashionInfoViewController alloc] initWithNibName:@"FashionInfoViewController" bundle:nil];
    [self.navigationController pushViewController:viewController animated:YES];
    [viewController release];
}

/**
 ** @Desc   TODO:促销资讯界面
 ** @author 王尧
 ** @param  N/A 
 ** @return N/A 
 ** @since  
 */
- (void)pushPromotionListViewController
{
    PromotionViewController *viewController = [[PromotionViewController alloc] initWithNibName:@"PromotionViewController" bundle:nil];
    [self.navigationController pushViewController:viewController animated:YES];
    [viewController release];
}

/**
 ** @Desc:   TODO:打开官方微博
 ** @Author: StackHero
 ** @Params: N/A
 ** @Return: N/A
 ** @Since:
 **/
- (void)pushWeiBOListViewController
{
    WeiBoListViewController *viewController = [[WeiBoListViewController alloc] initWithNibName:@"WeiBoListViewController" bundle:nil];
    [self.navigationController pushViewController:viewController animated:YES];
    [viewController release];
}

/**
 * TODO: 商品列表界面
 * @author Wangyao
 * @param  cataId 类别ID
 * @return N/A
 * @since  N/A
 */
- (void)pushGoodsListViewControllerWithCataId:(int)cataId
{
    GoodsListViewController *viewController = [[GoodsListViewController alloc] initWithNibName:@"GoodsListViewController" bundle:nil];
    viewController.cataId = cataId;
    [self.navigationController pushViewController:viewController animated:YES];
    [viewController release];
}

-(void)pushGoodsListViewControllerWithCataId:(int)cataId withItemId:(int)itemId{
    GoodsListViewController *viewController = [[GoodsListViewController alloc] initWithNibName:@"GoodsListViewController" bundle:nil];
    viewController.cataId = cataId;
    viewController.itemId=itemId;
    [self.navigationController pushViewController:viewController animated:YES];
  //  [viewController reloadTableViewDataSource];
    [viewController release];
}

- (void)pushShareViewController:(FHShareManager *)shareManager shareTextInfo:(NSString *)shareInfo shareImageUrl:(NSString *)imageUrl shareImage:(UIImage *)image
{
    ShareViewController *viewController = [[ShareViewController alloc] initWithNibName:@"ShareViewController" bundle:nil];
    [self.navigationController pushViewController:viewController animated:YES];
    [viewController openShareViewAction:shareManager shareTextInfo:shareInfo shareImageUrl:imageUrl shareImage:image];
    [viewController release];
}


@end
