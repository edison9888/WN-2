//
//  WebDetailViewController.m
//  WN
//
//  Created by 王尧 on 13-2-17.
//  Copyright (c) 2013年 BuildRun. All rights reserved.
//

#import "WebDetailViewController.h"
#import "AppDelegate.h"
#import "WN_Http.h"

@interface WebDetailViewController ()

//类型
@property (nonatomic, assign) DETAIL_TYPE type;

@end

@implementation WebDetailViewController

- (void)dealloc
{
    if (_shareManager) {
        [_shareManager release];
        _shareManager = nil;
    }
    self.fashionNode = nil;
    
    self.webView = nil;
    self.titleLabel = nil;
    
    self.collectBtn = nil;
    self.goodsNode = nil;
    
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
 ** @Desc   TODO:返回操作
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
 ** @Desc   TODO:加载webview的内容
 ** @author 王尧
 ** @param  (NSString *)url webview需要加载的URL type 详情类型
 ** @return N/A
 ** @since
 */
- (void)loadWebViewWithUrl:(NSString *)url type:(DETAIL_TYPE)type
{
    switch (type) {
        case DETAIL_TYPE_FASHION_NEWS:
        {
            self.type = DETAIL_TYPE_FASHION_NEWS;
            [self.shareBtn setHidden:NO];
            [self.titleLabel setText:@"资讯详情"];
        }
            break;
        case DETAIL_TYPE_GOODS:
        {
            self.type = DETAIL_TYPE_GOODS;
            [self.collectBtn setHidden:NO];
            [self.titleLabel setText:@"商品详情"];
            
            BOOL isCollect = [self isCollection];
            if (isCollect) {
                //按钮状态改为未收藏
                [self.collectBtn setImage:[UIImage imageWithContentsOfFile:[MHTool getResourcesFile:@"collect_yes.png"]] forState:UIControlStateNormal];
            }else{
                //按钮状态改为已收藏
                [self.collectBtn setImage:[UIImage imageWithContentsOfFile:[MHTool getResourcesFile:@"collect_no.png"]] forState:UIControlStateNormal];
            }
            
        }
            break;
        case DETAIL_TYPE_FOCUS_RECOM:
        {
            self.type = DETAIL_TYPE_FOCUS_RECOM;
            [self.titleLabel setText:@"焦点详情"];
        }
            break;
        default:
            break;
    }
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
}

/**
 * TODO: 加载品牌文化
 * @author Wangyao
 * @param
 * @return
 * @since
 */
- (void)loadWebPingPaiInfo:(NSString *)url
{
    [self.titleLabel setText:@"品牌文化"];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
}

/**
 * TODO: 加载淘宝主页
 * @author Wangyao
 * @param
 * @return
 * @since
 */
- (void)loadWebTaoBaoView:(NSString *)url
{
    [self.titleLabel setText:@"淘宝主页"];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 * TODO: 分享操作
 * @author Wangyao
 * @param  (id)sender
 * @return
 * @since
 */
- (IBAction)shareAction:(id)sender
{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"分享给好友",@"分享给微信好友",@"分享给微信朋友圈",@"分享给新浪微博",@"分享给腾讯微博",nil];
    [sheet showInView:app.viewController.view];
    [sheet release];
}

#pragma mark-================================UIActionSheetDelegate=========================================

/*
 TODO:短信分享
 */
- (void)messageShare
{
    if( [MFMessageComposeViewController canSendText] )
    {
        MFMessageComposeViewController * controller = [[MFMessageComposeViewController alloc] init];
        controller.body = [NSString stringWithFormat:@"%@%@",self.fashionNode.intro,SHARE_URL];
        controller.messageComposeDelegate = self;
        [app.viewController presentViewController:controller animated:YES completion:^{
            
        }];
        
        [[[[controller viewControllers] lastObject] navigationItem] setTitle:@"title"];//修改短信界面标题
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示信息"
                                                        message:@"该设备不支持短信功能"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
}

-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [controller dismissViewControllerAnimated:YES completion:^{
        
    }];
    
    switch (result) {
        case MessageComposeResultCancelled:
        {
            //click cancel button
        }
            break;
        case MessageComposeResultFailed:// send failed
            
            break;
            
        case MessageComposeResultSent:
        {
            //do something
        }
            break;
        default:
            break;
    }
    
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            [self messageShare];
            break;
        case 1:
            [app shareMsgToWeixin_Session:[NSString stringWithFormat:@"%@%@",self.fashionNode.intro,SHARE_URL]];
            break;
        case 2:
            [app shareMsgToWeixin_TimeLine:[NSString stringWithFormat:@"%@%@",self.fashionNode.intro,SHARE_URL]];
            break;
        case 3:
        {
            if (_shareManager) {
                [_shareManager release];
                _shareManager = nil;
            }
            _shareManager = [[FHShareManager alloc] init];
            _shareManager.type = SINAWEIBO;
            [app.viewController pushShareViewController:_shareManager shareTextInfo:[NSString stringWithFormat:@"%@%@",self.fashionNode.intro,SHARE_URL] shareImageUrl:self.fashionNode.picURL shareImage:nil];
        }
            break;
        case 4:
        {
            if (_shareManager) {
                [_shareManager release];
                _shareManager = nil;
            }
            _shareManager = [[FHShareManager alloc] init];
            _shareManager.type = TCWEIBO;
            [_shareManager setTCweiboRootController:app.viewController];
            [app.viewController pushShareViewController:_shareManager shareTextInfo:[NSString stringWithFormat:@"%@%@",self.fashionNode.intro,SHARE_URL] shareImageUrl:self.fashionNode.picURL shareImage:nil];
        }
            break;
        case 5:
            
            break;
            
        default:
            break;
    }
}

#pragma mark-===================================商品收藏=================================

- (BOOL)isCollection
{
    NSMutableDictionary *dict = [[NSUserDefaults standardUserDefaults] objectForKey:COLLECTION_INFO];
    GoodsNode *node = [dict objectForKey:[NSString stringWithFormat:@"%d",self.goodsNode.index]];
    if (node) {
        return YES;
    }else{
        return NO;
    }
}

/**
 ** @Desc   TODO: 收藏与取消收藏
 ** @author 王尧
 ** @param  N/A
 ** @return N/A
 ** @since
 */
- (IBAction)collectionGoods:(id)sender
{
    //判断是否已经收藏了此单品
    BOOL isCollect = [self isCollection];
    if (isCollect) {
        //已经收藏，
        //取消收藏操作
        NSMutableDictionary *dict = [[NSUserDefaults standardUserDefaults] objectForKey:COLLECTION_INFO];
        [dict removeObjectForKey:[NSString stringWithFormat:@"%d",self.goodsNode.index]];
        //按钮状态改为未收藏
        [self.collectBtn setImage:[UIImage imageWithContentsOfFile:[MHTool getResourcesFile:@"collect_no.png"]] forState:UIControlStateNormal];
        
        [MHTool alertWithTitle:nil Message:@"取消收藏成功" delegate:nil cancelButton:@"确定" otherButton:nil];
        
    }else{
        //还未收藏，
        //收藏操作
        NSMutableDictionary *dict = [[NSUserDefaults standardUserDefaults] objectForKey:COLLECTION_INFO];
        
        NSMutableDictionary *goodsDict = [[NSMutableDictionary alloc] init];
        [goodsDict setObject:self.goodsNode.categoryName forKey:@"categoryName"];
        [goodsDict setObject:[NSString stringWithFormat:@"%d",self.goodsNode.favNum] forKey:@"favNum"];
        [goodsDict setObject:[NSString stringWithFormat:@"%d",self.goodsNode.index] forKey:@"index"];
        [goodsDict setObject:self.goodsNode.intro forKey:@"intro"];
        [goodsDict setObject:self.goodsNode.name forKey:@"name"];
        [goodsDict setObject:self.goodsNode.picURL forKey:@"picURL"];
        [goodsDict setObject:[NSString stringWithFormat:@"%d",self.goodsNode.price] forKey:@"price"];
        [goodsDict setObject:self.goodsNode.taobaoURL forKey:@"taobaoURL"];
        
        
        [dict setObject:goodsDict forKey:[NSString stringWithFormat:@"%d",self.goodsNode.index]];
        
        [goodsDict release];
        
        //按钮状态改为已收藏
        [self.collectBtn setImage:[UIImage imageWithContentsOfFile:[MHTool getResourcesFile:@"collect_yes.png"]] forState:UIControlStateNormal];
        
        [self.httpRequest requestWithURL:[NSString stringWithFormat:GOODS_COLLECTION_URL,self.goodsNode.index]];
        [MHTool alertWithTitle:nil Message:@"收藏成功" delegate:nil cancelButton:@"确定" otherButton:nil];
    }
    [app.viewController.collectViewController initData];
}

@end
