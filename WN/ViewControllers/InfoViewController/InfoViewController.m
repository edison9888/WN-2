//
//  InfoViewController.m
//  WN
//
//  Created by 王 尧 on 13-2-16.
//  Copyright (c) 2013年 BuildRun. All rights reserved.
//

#import "InfoViewController.h"
#import "BaseViewController.h"
#import "FocusNode.h"
#import "WebDetailViewController.h"
#import "WN_Http.h"
#import "AppDelegate.h"

#define SCROLL_BTN_TAG_PLUS 101

@interface InfoViewController ()

@property (nonatomic, retain) NSMutableArray *scrollDataArray;

@end

@implementation InfoViewController

- (void)dealloc
{
    self.scrollDataArray = nil;
    self.scrollView = nil;
    self.pageController = nil;
    
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

#pragma mark-===============================按钮操作======================================
/**
 ** @Desc   TODO:时尚资讯
 ** @author 王尧
 ** @param  sender消息对象
 ** @return N/A
 ** @since
 */
- (IBAction)fashionListAction:(id)sender
{
    [app.viewController pushFashionNewsListViewController];
}

/**
 ** @Desc   TODO:打开促销信息
 ** @author 王尧
 ** @param  N/A
 ** @return N/A
 ** @since  
 */
- (IBAction)promotionNewsAction:(id)sender
{
    [app.viewController pushPromotionListViewController];
}

/**
 ** @Desc:   TODO:打开官方微博
 ** @Author: StackHero
 ** @Params: N/A
 ** @Return: N/A
 ** @Since:
 **/
- (IBAction)weiboOffcialAction:(id)sender
{
    [app.viewController pushWeiBOListViewController];
}

/**
 ** @Desc   TODO:scrollView中 某个选项被选中
 ** @author 王尧
 ** @param  N/A
 ** @return N/A
 ** @since  
 */
- (void)scrollItemSelect:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    FocusNode *node = [self.scrollDataArray objectAtIndex:btn.tag - SCROLL_BTN_TAG_PLUS];
    [app.viewController pushFocusDetaiWebViewController:node];
}

/**
 ** @Desc   TODO:刷新ScrollView
 ** @author 王尧
 ** @param  N/A
 ** @return N/A
 ** @since  
 */
- (void)refreshScrollView
{
    self.pageController.numberOfPages = self.scrollDataArray.count;
    for (int i = 0 ; i < self.scrollDataArray.count; i++) {
        FocusNode *node = [self.scrollDataArray objectAtIndex:i];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * self.scrollView.frame.size.width, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height)];
        [imageView setUserInteractionEnabled:YES];
        [imageView setImageWithURL:[NSURL URLWithString:node.bigPic]];
        UIButton *button = [[UIButton alloc] initWithFrame:imageView.bounds];
        [button addTarget:self action:@selector(scrollItemSelect:) forControlEvents:UIControlEventTouchUpInside];
        [button setTag:SCROLL_BTN_TAG_PLUS + i];
        [imageView addSubview:button];
        [self.scrollView addSubview:imageView];
        [imageView release];
        [button release];
    }
    
    [self.scrollView setContentSize:CGSizeMake(self.scrollView.frame.size.width*self.scrollDataArray.count, self.scrollView.frame.size.height)];
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
    self.scrollDataArray = [[[NSMutableArray alloc] init] autorelease];
    
    [self.httpRequest requestFocusListAction];
}



- (void)viewDidLoad
{
    [self.navigationController setNavigationBarHidden:YES];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.scrollView setPagingEnabled:YES];
    [self.scrollView setDelegate:self];
    
    [self initData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark-================================UIScrollViewDelgate=====================================
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    int index = fabs(scrollView.contentOffset.x) / scrollView.frame.size.width;
    self.pageController.currentPage = index;
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
    if ( ![[dict objectForKey:@"focusList"] isKindOfClass:[NSArray class]] && [[dict objectForKey:@"focusList"] integerValue] == -1) {
        //数据错误
        return;
    }
    
    NSMutableArray *array = [dict objectForKey:@"focusList"];
    
    for (NSDictionary *itemDict in array) {
        FocusNode *node = [[FocusNode alloc] init];
        
        node.bigPic = [itemDict objectForKey:@"bigPic"];
        node.index = [[itemDict objectForKey:@"id"] integerValue];
        node.title =[itemDict objectForKey:@"title"];
        
        [self.scrollDataArray addObject:node];
        [node release];
    }
    [self refreshScrollView];
}

@end
