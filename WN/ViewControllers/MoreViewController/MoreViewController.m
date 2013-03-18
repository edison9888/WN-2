//
//  MoreViewController.m
//  WN
//
//  Created by 王尧 on 13-2-18.
//  Copyright (c) 2013年 BuildRun. All rights reserved.
//

#import "MoreViewController.h"
#import "AppDelegate.h"
#import "FHShareManager.h"
#import "WN_Http.h"

@interface MoreViewController ()



@end

@implementation MoreViewController
- (void)dealloc
{
    if (_shareManager) {
        [_shareManager release];
        _shareManager = nil;
    }
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SINA_DID_BIND object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:TECENT_DID_BIND object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SINA_DID_CANCELBIND object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:TECENT_DID_CANCELBIND object:nil];    
    [_innerScrollView release];
    [_downStateLabel release];
    [_downStateIcon release];
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

- (void)sindDidBind:(NSNotification *)notification
{
    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:isBindSina];
    [MHTool alertWithTitle:nil Message:@"绑定成功" delegate:nil cancelButton:@"确定" otherButton:nil];
    [self updateBindState];
}

- (void)tecentDidBind:(NSNotification *)notification
{
    [MHTool alertWithTitle:nil Message:@"绑定成功" delegate:nil cancelButton:@"确定" otherButton:nil];
    [self updateBindState];
}

- (void)sindDidCancelBind:(NSNotification *)notification
{
    [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:isBindSina];
    [MHTool alertWithTitle:nil Message:@"解除绑定成功" delegate:nil cancelButton:@"确定" otherButton:nil];
    [self updateBindState];
}

- (void)tecentDidCancelBind:(NSNotification *)notification
{
    [MHTool alertWithTitle:nil Message:@"解除绑定成功" delegate:nil cancelButton:@"确定" otherButton:nil];
    [self updateBindState];
}

- (void)updateBindState
{
    NSString *sinaStr = [[NSUserDefaults standardUserDefaults] objectForKey:isBindSina];
    if ([sinaStr boolValue]) {
        [self.sinaBindState setTextColor:[UIColor blackColor]];
        [self.sinaBindState setText:@"解绑"];
    }else{
        [self.sinaBindState setTextColor:[UIColor orangeColor]];
        [self.sinaBindState setText:@"绑定"];
    }
    TCWBEngine *tcweibo = [[[TCWBEngine alloc] initWithAppKey:TCAppKey andSecret:TCAppSecret andRedirectUrl:TCAppRedirectURI] autorelease];
    BOOL isLogin = [tcweibo isLoggedIn];
    if (isLogin) {
        [self.tecentBindState setTextColor:[UIColor blackColor]];
        [self.tecentBindState setText:@"解绑"];
    }else{
        [self.tecentBindState setTextColor:[UIColor orangeColor]];
        [self.tecentBindState setText:@"绑定"];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sindDidBind:) name:SINA_DID_BIND object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tecentDidBind:) name:TECENT_DID_BIND object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sindDidCancelBind:) name:SINA_DID_CANCELBIND object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tecentDidCancelBind:) name:TECENT_DID_CANCELBIND object:nil];
    self.innerScrollView.contentSize=CGSizeMake(320, 500);
    [self updateBindState];
    NSString *down=[[NSUserDefaults standardUserDefaults]stringForKey:@"down"];
    NSLog(@"%@",down);
    if ([down boolValue]) {
        self.downStateLabel.text=@"不限";
        self.downStateLabel.textColor=[UIColor blackColor];
        self.downStateIcon.image=[UIImage imageNamed:@"more_go.png"];
    }else{
        self.downStateLabel.text=@"仅Wifi";
        self.downStateLabel.textColor=[UIColor orangeColor];
        self.downStateIcon.image=[UIImage imageNamed:@"more_go_press.png"];
    }

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 ** @Desc   TODO:打开淘宝
 ** @author 王尧
 ** @param  N/A
 ** @return N/A
 ** @since
 */
- (IBAction)openTaoBao:(id)sender
{
    [app.viewController pushWebView_TaoBao];
}

/**
 ** @Desc   TODO:打开品牌文化
 ** @author 王尧
 ** @param  N/A
 ** @return N/A
 ** @since
 */
- (IBAction)openPinpaiCulture:(id)sender
{
    [app.viewController pushWebView_Pingpai];
}

/**
 ** @Desc   TODO:版本检测
 ** @author 王尧
 ** @param  N/A
 ** @return N/A
 ** @since
 */
- (IBAction)versionCheck:(id)sender
{
    [self.httpRequest requestWithURL:VERSION_UPDATE_URL];
}

/**
 ** @Desc   TODO:分享好友
 ** @author 王尧
 ** @param  N/A
 ** @return N/A
 ** @since
 */
- (IBAction)shareToFrend:(id)sender
{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"分享给好友",@"分享给微信好友",@"分享给微信朋友圈",@"分享给新浪微博",@"分享给腾讯微博",nil];
    [sheet showInView:app.viewController.view];
    [sheet release];
}

/**
 ** @Desc   TODO:绑定新浪微博
 ** @author 王尧
 ** @param  N/A
 ** @return N/A
 ** @since
 */
- (IBAction)bindSina:(id)sender
{
    NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:isBindSina];
    if ([str boolValue]) {
        //已经绑定了  需要取消绑定
        if (_shareManager) {
            [_shareManager release];
            _shareManager = nil;
        }
        _shareManager = [[FHShareManager alloc] init];
        _shareManager.delegate = self;
        _shareManager.type = SINAWEIBO;
        [_shareManager logout];
    }else{
        //还未绑定，点击绑定
        if (_shareManager) {
            [_shareManager release];
            _shareManager = nil;
        }
        _shareManager = [[FHShareManager alloc] init];
        _shareManager.delegate = self;
        _shareManager.type = SINAWEIBO;
        [_shareManager login];
    }
}

- (IBAction)toggleDownLoad:(id)sender {
    NSString *shoudlDownload=[[NSUserDefaults standardUserDefaults]stringForKey:@"down"];
    if ([shoudlDownload boolValue]) {
        [[NSUserDefaults standardUserDefaults]setObject:@"NO" forKey:@"down"];
        self.downStateLabel.text=@"仅Wifi";
        self.downStateLabel.textColor=[UIColor orangeColor];
        self.downStateIcon.image=[UIImage imageNamed:@"more_go_press.png"];
    }else{
      [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:@"down"];
        self.downStateLabel.text=@"不限";
        self.downStateLabel.textColor=[UIColor blackColor];
        self.downStateIcon.image=[UIImage imageNamed:@"more_go.png"];
    }
    [[NSUserDefaults standardUserDefaults]synchronize];
}

/**
 ** @Desc   TODO:绑定腾讯微博
 ** @author 王尧
 ** @param  N/A
 ** @return N/A
 ** @since
 */
- (IBAction)flushCache:(id)sender {
    [[SDImageCache sharedImageCache] clearMemory];
    [[SDImageCache sharedImageCache]clearDisk];
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"缓存清理" message:@"已清空" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    NSLog(@"clear cache");
    BOOL shouldLoad=[[NSUserDefaults standardUserDefaults]boolForKey:@"shouldDownLoadImage"];
    if (shouldLoad) {
        NSLog(@"yes");
    }else{
        NSLog(@"no");
    }
//[[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"shouldDownLoadImage"];
}

- (IBAction)bindTecent:(id)sender
{
    TCWBEngine *tcweibo = [[[TCWBEngine alloc] initWithAppKey:TCAppKey andSecret:TCAppSecret andRedirectUrl:TCAppRedirectURI] autorelease];
    BOOL isLogin = [tcweibo isLoggedIn];
    if (isLogin) {
        //已经绑定了  需要取消绑定
        if (_shareManager) {
            [_shareManager release];
            _shareManager = nil;
        }
        _shareManager = [[FHShareManager alloc] init];
        _shareManager.delegate = self;
        _shareManager.type = TCWEIBO;
        [_shareManager setTCweiboRootController:app.viewController];
        [_shareManager logout];
    }else{
        //还未绑定，点击绑定
        if (_shareManager) {
            [_shareManager release];
            _shareManager = nil;
        }
        _shareManager = [[FHShareManager alloc] init];
        _shareManager.delegate = self;
        _shareManager.type = TCWEIBO;
        [_shareManager setTCweiboRootController:app.viewController];
        [_shareManager login];
    }
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
        controller.body = SHARE_INFO;
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
            [app shareMsgToWeixin_Session:SHARE_INFO];
            break;
        case 2:
            [app shareMsgToWeixin_TimeLine:SHARE_INFO];
            break;
        case 3:
        {
            if (_shareManager) {
                [_shareManager release];
                _shareManager = nil;
            }
            _shareManager = [[FHShareManager alloc] init];
            _shareManager.type = SINAWEIBO;
            [app.viewController pushShareViewController:_shareManager shareTextInfo:SHARE_INFO shareImageUrl:nil shareImage:[UIImage imageWithContentsOfFile:[MHTool getResourcesFile:@"code.png"]]];
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
            [app.viewController pushShareViewController:_shareManager shareTextInfo:SHARE_INFO shareImageUrl:nil shareImage:[UIImage imageWithContentsOfFile:[MHTool getResourcesFile:@"code.png"]]];
        }
            break;
        case 5:
            
            break;
            
        default:
            break;
    }
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
    /*
        {"currentVersion":{"description":"1、添加资讯短信分享地址\r\n2、4.0以上收藏量不增加bug修正\r\n3、列表加载当前页记录bug修正\r\n4、首页焦点图默认加载图修改\r\n5、无网络应用打开出错\r\n6、下拉刷新逻辑修正\r\n7、微博转发优化\r\n8、图片加载方式优化","id":8,"versionNum":"0.3.3"}}
     */
    
    NSDictionary *dict = [responseString JSONValue];
    if (dict && [dict isKindOfClass:[NSDictionary class]]) {
        NSDictionary *infoDict = [dict objectForKey:@"currentVersion"];
        if (infoDict && [infoDict isKindOfClass:[NSDictionary class]]) {
            NSString *desc = [infoDict objectForKey:@"description"];
            NSString *versionNum = [infoDict objectForKey:@"versionNum"];
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"当前版本:%@",versionNum] message:desc delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
        }
    }
}

#pragma mark
#pragma mark =======FHShareManagerDelegate=======
/**   函数名称 :shareFailed
 **   函数作用 :TODO:分享失败
 **   函数参数 :
 **   函数返回值:
 **/
-(void)shareFailed:(NSString *)errorMsg
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:errorMsg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
    [alertView release];
}

/**   函数名称 :shareSuccess
 **   函数作用 :TODO:分享成功
 **   函数参数 :
 **   函数返回值:
 **/
-(void)shareSuccess
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"分享成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
    [alertView release];
}

- (void)viewDidUnload {
    [self setInnerScrollView:nil];
    [self setDownStateLabel:nil];
    [self setDownStateIcon:nil];
    [super viewDidUnload];
}
@end
