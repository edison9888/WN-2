//
//  AppDelegate.m
//  WN
//
//  Created by 王 尧 on 13-2-16.
//  Copyright (c) 2013年 BuildRun. All rights reserved.
//

#import "AppDelegate.h"

#import "ViewController.h"

#import "WN_HttpRequest.h"

#import "WN_Http.h"



AppDelegate *app;

@implementation AppDelegate

- (void)dealloc
{
    [_window release];
    [_viewController release];
    app = nil;
    [super dealloc];
}

- (void)initNetWorkListener
{
    MHNetWorkListenner *netWorkListener = [MHNetWorkListenner sharedManager];
    [netWorkListener setDelegate:self];
    [netWorkListener startNetWorkeWatch];
    if ([netWorkListener checkNowNetWorkStatus]==kReachableViaWiFi) {
        app.isEnableWifi=YES;
    }else{
        app.isEnableWifi=NO;
    }
}


/*
 * 函数作用:wifi可用时触发
 * 函数参数:
 * 函数返回值:
 * 修改于:20111102
 */
- (void)netWorkStatusWillEnabledViaWifi
{
    NSLog(@"is in Wifi");
    self.isEnableWifi = YES;
  //  [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"shouldDownloadImage"];
}

/*
 * 函数作用:网络是3G or 2G时触发
 * 函数参数:
 * 函数返回值:
 * 修改于:20111102
 */
- (void)netWorkStatusWillEnabledViaWWAN
{
    NSLog(@"is in 2G");
    self.isEnableWifi = NO;
    /*
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"网络" message:@"没有wifi，是否要下载图片" delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
    [alert show];
    [alert release];
     */
}


/*
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) {
        NSLog(@"fou");
        [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"shouldDownloadImage"];
        
    }else{
        NSLog(@"shi");
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"shouldDownloadImage"];
    }
}

 */


//初始化数据
- (void)initData
{
    //初始化收藏信息
    NSMutableDictionary *dict = [[NSUserDefaults standardUserDefaults] objectForKey:COLLECTION_INFO];
    if (!dict) {
        NSMutableDictionary *collectDict = [[NSMutableDictionary  alloc] init];
        [[NSUserDefaults standardUserDefaults] setObject:collectDict forKey:COLLECTION_INFO];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [collectDict release];
    }
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.isEnableWifi = YES;  
    app = self;
    [self initData];
    [self initNetWorkListener];
    
    
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    
    self.viewController = [[[ViewController alloc] initWithNibName:@"ViewController" bundle:nil] autorelease];
    self.rootNavigationController = [[[UINavigationController alloc] initWithRootViewController:self.viewController] autorelease];
    [self.rootNavigationController.view setBackgroundColor:[UIColor redColor]];
//    [self.rootNavigationController.view setFrame:CGRectMake(0, 0, 320, 460)];
    [self.rootNavigationController setNavigationBarHidden:YES];
    self.window.rootViewController = self.rootNavigationController;
//    [self.window addSubview:self.rootNavigationController.view];
    [self.window makeKeyAndVisible];
    
    //向微信注册
    [WXApi registerApp:WEIXIN_APPID];
/*
    NSLog(@"options%@",launchOptions);
    if (launchOptions!=nil) {
        NSDictionary* dictionary = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
		if (dictionary != nil)
		{
			NSLog(@"Launched from push notification: %@", dictionary);
            [self updateUIWithPushInfo:dictionary];
		}
        
        application.applicationIconBadgeNumber=0;
        
    }

*/
    
    
    NSLog(@"options%@",launchOptions);
    if (launchOptions!=nil) {
        NSDictionary* dictionary = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
		if (dictionary != nil)
		{
            
            /*
            UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"test" message:[NSString stringWithFormat:@"%@",dictionary] delegate:self cancelButtonTitle:@"yes" otherButtonTitles:nil, nil];
            [alertView show];
            [alertView release];
             */
        [self updateUIWithPushInfo:dictionary];
		}
        
        application.applicationIconBadgeNumber=0;
        
    }
    
    
    
    
    
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
     (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
    
 
    
    return YES;
}

#pragma mark -
#pragma mark ========微信代理===========
/**   函数名称 :onReq
 **   函数作用 :TODO:微信请求
 **   函数参数 :
 **   函数返回值:
 **/
-(void) onReq:(BaseReq*)req
{
    if([req isKindOfClass:[GetMessageFromWXReq class]])
    {
        
    }
    else if([req isKindOfClass:[ShowMessageFromWXReq class]])
    {
        
    }
    
}
/**   函数名称 :onResp
 **   函数作用 :TODO:微信响应
 **   函数参数 :
 **   函数返回值:
 **/
-(void) onResp:(BaseResp*)resp
{
    if([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        NSString *strMsg = [NSString stringWithFormat:@"分享微信%@", (resp.errCode)?@"失败":@"成功"];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
}

#pragma mark -
#pragma mark ========微信方法===========
/**   函数名称 :checkWeixinInstalled
 **   函数作用 :TODO:检查微信是否安装
 **   函数参数 :
 **   函数返回值:
 **/
-(BOOL)checkWeixinInstalled
{
    BOOL installed = [WXApi isWXAppInstalled];
    if (!installed) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"微信未安装，无法分享微信消息" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
    return installed;
}

/**   函数名称 :shareMsgToWeixin
 **   函数作用 :TODO:分享消息到微信到某个会话
 **   函数参数 :
 **   函数返回值:
 **/
-(void)shareMsgToWeixin_Session:(NSString *)msg
{
    //检查安装
    if (![self checkWeixinInstalled]) {
        return;
    }
    SendMessageToWXReq* req = [[[SendMessageToWXReq alloc] init]autorelease];
    req.bText = YES;
    req.text = msg;
    //个人会话
    req.scene = WXSceneSession;
    
    [WXApi sendReq:req];
}
/**   函数名称 :shareMsgToWeixin_TimeLine
 **   函数作用 :TODO:分享消息到微信朋友圈
 **   函数参数 :
 **   函数返回值:
 **/
-(void)shareMsgToWeixin_TimeLine:(NSString *)msg
{
    //检查安装
    if (![self checkWeixinInstalled]) {
        return;
    }
    SendMessageToWXReq* req = [[[SendMessageToWXReq alloc] init]autorelease];
    req.bText = YES;
    req.text = msg;
    //朋友圈
    req.scene = WXSceneTimeline;
    
    [WXApi sendReq:req];
}


/**   函数名称 :shareMsgToWeixin
 **   函数作用 :TODO:分享图片到微信
 **   函数参数 :
 **   函数返回值:
 **/
-(void)sharePhotoToWeixin:(UIImage *)img description:(NSString *)desc
{
    //检查安装
    if (![self checkWeixinInstalled]) {
        return;
    }
    //发送内容给微信
    WXMediaMessage *message = [WXMediaMessage message];
    [message setThumbImage:img];
    
    WXImageObject *ext = [WXImageObject object];
    ext.imageData = UIImageJPEGRepresentation(img, 1.0);
    
    message.mediaObject = ext;
    message.description = desc;
    
    SendMessageToWXReq* req = [[[SendMessageToWXReq alloc] init]autorelease];
    req.bText = NO;
    req.message = message;
    //朋友圈
    req.scene = WXSceneTimeline;
    
    [WXApi sendReq:req];
}



- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [WXApi handleOpenURL:url delegate:self];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return  [WXApi handleOpenURL:url delegate:self];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [[NSUserDefaults standardUserDefaults]synchronize];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
	NSLog(@"My token is: %@", deviceToken);
    NSString* newToken = [deviceToken description];
	newToken = [newToken stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
	newToken = [newToken stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"new token:%@",newToken);
    
    if (![[NSUserDefaults standardUserDefaults]stringForKey:@"token"]) {
         [[NSUserDefaults standardUserDefaults]setObject:newToken forKey:@"token"];
     
        NSString *urlString=[NSString stringWithFormat:@"http://192.168.1.106:8080/WoNing/token_add.do?tokenString=%@",newToken];
        NSURL *url=[NSURL URLWithString:urlString];
       // NSURLRequest *request=[NSURLRequest requestWithURL:url];
    //[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        ASIHTTPRequest *request=[ASIHTTPRequest requestWithURL:url];
        [request setDelegate:self];
        [request startAsynchronous];
    }
    
}

- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
	NSLog(@"Failed to get token, error: %@", error);
}


/** receive notification in foreground
**
 **
 */
-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    
    
    
    UIApplicationState state=[application applicationState];
    if (state==UIApplicationStateActive) {
        
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:[[userInfo objectForKey:@"aps"] objectForKey:@"alert"] message:[[userInfo objectForKey:@"aps"] objectForKey:@"title"] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"查看",nil];
        notiInfo=[userInfo copy];
        [alertView show];
        [alertView release];
 
        return;
    }
    [self updateUIWithPushInfo:userInfo];
    
    application.applicationIconBadgeNumber = 0;

    
}


-(void)updateUIWithPushInfo:(NSDictionary *)pushInfo{
   // NSLog(@"%@",pushInfo);
    //NSLog(@"%@",[pushInfo objectForKey:@"aps"]);
    NSDictionary *aps=[pushInfo objectForKey:@"aps"];
    NSInteger cataId=[[aps objectForKey:@"category"]integerValue];
    NSInteger itemId=[[aps objectForKey:@"id"]integerValue];
    NSLog(@"%d  %d",cataId,itemId);
    TabBarView *tabBar=self.viewController.tabView;
    for (UIView *item in [tabBar subviews]) {
        if ([item isKindOfClass:[TabItemView class]]) {
            [(TabItemView*)item deselectItem];
        }
    }
    [(TabItemView*)[tabBar viewWithTag:124] selectItem];
    [self.viewController itemDidSelectedIndex:1];
    [self.viewController pushGoodsListViewControllerWithCataId:cataId withItemId:itemId];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==1) {
        [self updateUIWithPushInfo:notiInfo];
    }
}

@end
