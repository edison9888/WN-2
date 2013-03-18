//
//  FHShareManager.m
//  FHShare
//
//  Created by wangyaoon 13-1-3.
//  Copyright (c) 2013年 wangyao. All rights reserved.
//

#import "FHShareManager.h"
#import "JSON.h"

@implementation FHShareManager

@synthesize sinaweibo = _sinaweibo;
@synthesize tcweibo = _tcweibo;

#pragma mark-
#pragma mark========life circle=============
-(id)init
{
    self = [super init];
    if (self) {
        //新浪
        _sinaweibo = [[SinaWeibo alloc] initWithAppKey:SinaAppKey appSecret:SinaAppSecret appRedirectURI:SinaAppRedirectURI andDelegate:self];
        //腾讯
        _tcweibo = [[TCWBEngine alloc] initWithAppKey:TCAppKey andSecret:TCAppSecret andRedirectUrl:TCAppRedirectURI];
    }
    
    return self;
}


- (void)dealloc
{
    self.sinaweibo.delegate = nil;
    [self.sinaweibo release];
    self.tcweibo = nil;
    [super dealloc];
}

#pragma mark-
#pragma mark========公用方法=============
/**   函数名称 :shareMessage
 **   函数作用 :TODO:分享信息
 **   函数参数 :
 **   函数返回值:
 **/
-(void)shareMessage:(NSString *)msg
{
    switch (_type) {
        //新浪
        case SINAWEIBO:
            [self shareMessageToSina:msg];
            break;
        //腾讯
        case TCWEIBO:
            [self shareMessageToTC:msg];
            break;
        default:
            break;
    }
}

/**   函数名称 :shareMessage:Image
 **   函数作用 :TODO:分享图片信息
 **   函数参数 :
 **   函数返回值:
 **/
-(void)shareMessage:(NSString *)msg Image:(UIImage *)image
{
    switch (_type) {
            //新浪
        case SINAWEIBO:
            [self shareToSinaMessage:msg Image:image];
            break;
            //腾讯
        case TCWEIBO:
            [self shareToTCMessage:msg Image:image];
            break;
        default:
            break;
    }
}

/**   函数名称 :shareMessage:ImageUrl
 **   函数作用 :TODO:分享图片信息(url)
 **   函数参数 :
 **   函数返回值:
 **/
-(void)shareMessage:(NSString *)msg ImageUrl:(NSString *)imageUrl
{
    switch (_type) {
            //新浪
        case SINAWEIBO:
            [self shareToSinaMessage:msg ImageUrl:imageUrl];
            break;
            //腾讯
        case TCWEIBO:
            [self shareToTCMessage:msg ImageUrl:imageUrl];
            break;
        default:
            break;
    }
}

/**   函数名称 :login
 **   函数作用 :TODO:登陆
 **   函数参数 :
 **   函数返回值:
 **/
-(void)login
{
    switch (_type) {
            //新浪
        case SINAWEIBO:
            [_sinaweibo logIn];
            break;
            //腾讯
        case TCWEIBO:
            [_tcweibo logInWithDelegate:self
                              onSuccess:@selector(onSuccessLogin)
                              onFailure:@selector(onFailureLogin:)];
            break;
        default:
            break;
    }
}

/**   函数名称 :logout
 **   函数作用 :TODO:登出
 **   函数参数 :
 **   函数返回值:
 **/
-(void)logout
{
    switch (_type) {
            //新浪
        case SINAWEIBO:
            [_sinaweibo logOut];
            break;
            //腾讯
        case TCWEIBO:
            if ([_tcweibo logOut]) {
                //发通知，告知 取消绑定成功wangyao.
                [[NSNotificationCenter defaultCenter] postNotificationName:TECENT_DID_CANCELBIND object:nil];
            }
            break;
        default:
            break;
    }
}
#pragma mark-
#pragma mark========腾讯微博私有方法=============
/**   函数名称 :setTCweiboRootController
 **   函数作用 :TODO:设置腾讯微博根控制器
 **   函数参数 :
 **   函数返回值:
 **/
-(void)setTCweiboRootController:(UIViewController *)controller
{
    [_tcweibo setRootViewController:controller];
}

#pragma mark-
#pragma mark========信息分享=============
/****************新浪******************/
/**   函数名称 :shareMessageToSina
 **   函数作用 :TODO:分享信息到新浪
 **   函数参数 :
 **   函数返回值:
 **/
-(void)shareMessageToSina:(NSString *)msg
{
    if (![_sinaweibo isLoggedIn]) {
        [self loadSinaAuthData];
    }
    if ([_sinaweibo isLoggedIn]) {
        [_sinaweibo requestWithURL:@"statuses/update.json"
                           params:[NSMutableDictionary dictionaryWithObjectsAndKeys:msg, @"status", nil]
                       httpMethod:@"POST"
                         delegate:self];
    }
    else
        [_sinaweibo logIn];
}

/**   函数名称 :shareToSinaMessage:Image
 **   函数作用 :TODO:分享图片信息到新浪
 **   函数参数 :
 **   函数返回值:
 **/
-(void)shareToSinaMessage:(NSString *)msg Image:(UIImage *)image
{
    if ([_sinaweibo isLoggedIn]) {
        [_sinaweibo requestWithURL:@"statuses/upload.json"
                           params:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   msg, @"status",
                                   image, @"pic", nil]
                       httpMethod:@"POST"
                         delegate:self];
    }
    else
        [_sinaweibo logIn];
}

/**   函数名称 :shareToSinaMessage:ImageUrl
 **   函数作用 :TODO:分享图片信息到新浪
 **   函数参数 :
 **   函数返回值:
 **/
-(void)shareToSinaMessage:(NSString *)msg ImageUrl:(NSString *)imageUrl
{
    if ([_sinaweibo isLoggedIn]) {
        [_sinaweibo requestWithURL:@"statuses/upload.json"
                            params:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                    msg, @"status",
                                    imageUrl, @"url", nil]
                        httpMethod:@"POST"
                          delegate:self];
    }
    else
        [_sinaweibo logIn];
}
/****************腾讯******************/
/**   函数名称 :shareMessageToTC
 **   函数作用 :TODO:分享信息到腾讯
 **   函数参数 :
 **   函数返回值:
 **/
-(void)shareMessageToTC:(NSString *)msg
{
    if ([_tcweibo isLoggedIn]) {
        [_tcweibo postTextTweetWithFormat:@"json"
                                  content:msg
                                 clientIP:_ip
                                longitude:nil
                              andLatitude:nil
                              parReserved:nil
                                 delegate:self
                                onSuccess:@selector(successCallBack:)
                                onFailure:@selector(failureCallBack:)];
    }
    else
        [_tcweibo logInWithDelegate:self
                          onSuccess:@selector(onSuccessLogin)
                          onFailure:@selector(onFailureLogin:)];
    
}

/**   函数名称 :shareToTCMessage:Image
 **   函数作用 :TODO:分享图片信息到腾讯
 **   函数参数 :
 **   函数返回值:
 **/
-(void)shareToTCMessage:(NSString *)msg Image:(UIImage *)image
{
    if ([_tcweibo isLoggedIn]) {
        [_tcweibo postPictureTweetWithFormat:@"json"
                                     content:msg
                                    clientIP:_ip
                                         pic:UIImageJPEGRepresentation(image, 1.0)
                              compatibleFlag:nil
                                   longitude:nil
                                 andLatitude:nil
                                 parReserved:nil
                                    delegate:self
                                   onSuccess:@selector(successCallBack:)
                                   onFailure:@selector(failureCallBack:)];
    }
    else
        [_tcweibo logInWithDelegate:self
                          onSuccess:@selector(onSuccessLogin)
                          onFailure:@selector(onFailureLogin:)];
}

/**   函数名称 :shareToTCMessage:Image
 **   函数作用 :TODO:分享图片信息到腾讯(url)
 **   函数参数 :
 **   函数返回值:
 **/
-(void)shareToTCMessage:(NSString *)msg ImageUrl:(NSString *)imageUrl
{
    if ([_tcweibo isLoggedIn]) {
        [_tcweibo postPictureURLTweetWithFormat:@"json"
                                        content:msg
                                       clientIP:_ip
                                         picURL:imageUrl
                                 compatibleFlag:nil
                                      longitude:nil
                                    andLatitude:nil
                                    parReserved:nil
                                       delegate:self
                                      onSuccess:@selector(successCallBack:)
                                      onFailure:@selector(failureCallBack:)];
    }
    else
        [_tcweibo logInWithDelegate:self
                          onSuccess:@selector(onSuccessLogin)
                          onFailure:@selector(onFailureLogin:)];
}

/****************人人******************/

#pragma mark-
#pragma mark========认证数据相关=============
/**   函数名称 :storeAuthData
 **   函数作用 :TODO:存储认证数据
 **   函数参数 :
 **   函数返回值:
 **/
- (void)storeAuthData
{
    switch (_type) {
        //新浪
        case SINAWEIBO:
            [self storeSinaAuthData];
            break;
            
        default:
            break;
    }
}

/**   函数名称 :removeAuthData
 **   函数作用 :TODO:删除认证数据
 **   函数参数 :
 **   函数返回值:
 **/
- (void)removeAuthData
{
    switch (_type) {
            //新浪
        case SINAWEIBO:
            [self removeSinaAuthData];
            break;
            
        default:
            break;
    }
}

/**   函数名称 :loadSinaAuthData
 **   函数作用 :TODO:读取新浪认证数据
 **   函数参数 :
 **   函数返回值:
 **/
-(void)loadSinaAuthData
{
    NSDictionary *authData = [[NSUserDefaults standardUserDefaults] objectForKey:@"SinaWeiboAuthData"];
    if (!authData) {
        return;
    }
    _sinaweibo.accessToken = [authData objectForKey:@"AccessTokenKey"],
    _sinaweibo.expirationDate =[authData objectForKey:@"ExpirationDateKey"];
    _sinaweibo.userID =[authData objectForKey:@"UserIDKey"];
    _sinaweibo.refreshToken =[authData objectForKey:@"refresh_token"]; 
}

/**   函数名称 :storeSinaAuthData
 **   函数作用 :TODO:存储新浪认证数据
 **   函数参数 :
 **   函数返回值:
 **/
-(void)storeSinaAuthData
{
    NSDictionary *authData = [NSDictionary dictionaryWithObjectsAndKeys:
                              _sinaweibo.accessToken, @"AccessTokenKey",
                              _sinaweibo.expirationDate, @"ExpirationDateKey",
                              _sinaweibo.userID, @"UserIDKey",
                              _sinaweibo.refreshToken, @"refresh_token", nil];
    [[NSUserDefaults standardUserDefaults] setObject:authData forKey:@"SinaWeiboAuthData"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:SINA_DID_BIND object:nil];
}

/**   函数名称 :removeSinaAuthData
 **   函数作用 :TODO:删除新浪认证数据
 **   函数参数 :
 **   函数返回值:
 **/
-(void)removeSinaAuthData
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"SinaWeiboAuthData"];
    [[NSNotificationCenter defaultCenter] postNotificationName:SINA_DID_CANCELBIND object:nil];
}

#pragma mark-
#pragma mark========sina delegate=============
/**   函数名称 :sinaweiboDidLogIn
 **   函数作用 :TODO:新浪微博登陆
 **   函数参数 :
 **   函数返回值:
 **/
- (void)sinaweiboDidLogIn:(SinaWeibo *)sinaweibo
{
    NSLog(@"sinaweiboDidLogIn userID = %@ accesstoken = %@ expirationDate = %@ refresh_token = %@", _sinaweibo.userID, _sinaweibo.accessToken, _sinaweibo.expirationDate,_sinaweibo.refreshToken);
    [self storeAuthData];
    if (_delegate && [_delegate respondsToSelector:@selector(didLogin)]) {
        [_delegate didLogin];
    }
}

/**   函数名称 :sinaweiboDidLogOut
 **   函数作用 :TODO:新浪微博登出
 **   函数参数 :
 **   函数返回值:
 **/
- (void)sinaweiboDidLogOut:(SinaWeibo *)sinaweibo
{
    NSLog(@"sinaweiboDidLogOut");
    [self removeAuthData];
    if (_delegate && [_delegate respondsToSelector:@selector(didlogout)]) {
        [_delegate didlogout];
    }
}

/**   函数名称 :sinaweiboLogInDidCancel
 **   函数作用 :TODO:新浪微博取消登陆
 **   函数参数 :
 **   函数返回值:
 **/
- (void)sinaweiboLogInDidCancel:(SinaWeibo *)sinaweibo
{
    NSLog(@"sinaweiboLogInDidCancel");
}

/**   函数名称 :logInDidFailWithError
 **   函数作用 :TODO:新浪微博失败
 **   函数参数 :
 **   函数返回值:
 **/
- (void)sinaweibo:(SinaWeibo *)sinaweibo logInDidFailWithError:(NSError *)error
{
    NSLog(@"sinaweibo logInDidFailWithError %@", error);
    if (_delegate && [_delegate respondsToSelector:@selector(loginFailed:)]) {
        [_delegate loginFailed:@"新浪微博登陆失败"];
    }
}

/**   函数名称 :accessTokenInvalidOrExpired
 **   函数作用 :TODO:新浪微博token失效
 **   函数参数 :
 **   函数返回值:
 **/
- (void)sinaweibo:(SinaWeibo *)sinaweibo accessTokenInvalidOrExpired:(NSError *)error
{
    NSLog(@"sinaweiboAccessTokenInvalidOrExpired %@", error);
    [self removeAuthData];
}


/**   函数名称 :didFailWithError
 **   函数作用 :TODO:新浪微博请求分享失败
 **   函数参数 :
 **   函数返回值:
 **/
- (void)request:(SinaWeiboRequest *)request didFailWithError:(NSError *)error
{
    //获取用户信息失败
    if ([request.url hasSuffix:@"users/show.json"])
    {
        NSLog(@"获取用户信息失败");
    }
    //获取用户时间线失败
    else if ([request.url hasSuffix:@"statuses/user_timeline.json"])
    {
        NSLog(@"获取用户时间线失败");
    }
    //分享信息失败
    else if ([request.url hasSuffix:@"statuses/update.json"])
    {
        NSLog(@"分享信息失败");
    }
    //分享图片失败
    else if ([request.url hasSuffix:@"statuses/upload.json"])
    {
        NSLog(@"分享图片失败");
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(shareFailed:)]) {
        [_delegate shareFailed:@"新浪微博分享失败"];
    }
}

/**   函数名称 :didFinishLoadingWithResult
 **   函数作用 :TODO:新浪微博请求分享成功
 **   函数参数 :
 **   函数返回值:
 **/
- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result
{
    //获取用户信息成功
    if ([request.url hasSuffix:@"users/show.json"])
    {
        NSLog(@"获取用户信息成功");
    }
    //获取用户时间线成功
    else if ([request.url hasSuffix:@"statuses/user_timeline.json"])
    {
        NSLog(@"获取用户时间线成功");
    }
    //分享信息成功
    else if ([request.url hasSuffix:@"statuses/update.json"])
    {
        NSLog(@"分享信息成功");
    }
    //分享图片成功
    else if ([request.url hasSuffix:@"statuses/upload.json"])
    {
        NSLog(@"分享图片成功");
    }
    
    NSLog(@"分享信息成功");
    
    if (_delegate && [_delegate respondsToSelector:@selector(shareSuccess)]) {
        [_delegate shareSuccess];
    }
    
}

#pragma mark-
#pragma mark========腾讯 delegate=============
/**   函数名称 :onSuccessLogin
 **   函数作用 :TODO:腾讯微博登陆成功
 **   函数参数 :
 **   函数返回值:
 **/
- (void)onSuccessLogin
{
    NSLog(@"腾讯微博登陆成功");
    [[NSNotificationCenter defaultCenter] postNotificationName:TECENT_DID_BIND object:nil];
    if (_delegate && [_delegate respondsToSelector:@selector(didLogin)]) {
        [_delegate didLogin];
    }
}

/**   函数名称 :onFailureLogin
 **   函数作用 :TODO:腾讯微博登陆失败
 **   函数参数 :
 **   函数返回值:
 **/
- (void)onFailureLogin:(NSError *)error
{
    /* error 仅包含错误码
       获取方式 [error code]*/
    
    NSLog(@"登陆失败,errorCode %d",[error code]);
    if (_delegate && [_delegate respondsToSelector:@selector(loginFailed:)]) {
        [_delegate loginFailed:@"腾讯微博登陆失败"];
    }
}

/**   函数名称 :onSuccessAuthorizeLogin
 **   函数作用 :TODO:腾讯微博授权成功
 **   函数参数 :
 **   函数返回值:
 **/
- (void)onSuccessAuthorizeLogin
{
     NSLog(@"腾讯微博授权成功");
}

/**   函数名称 :postStart
 **   函数作用 :TODO:腾讯微博分享开始发送
 **   函数参数 :
 **   函数返回值:
 **/
- (void)postStart {
}

/**   函数名称 :createSuccess
 **   函数作用 :TODO:腾讯微博分享成功
 **   函数参数 :
 **   函数返回值:
 **/
- (void)createSuccess:(NSDictionary *)dict {
    NSLog(@"%s %@", __FUNCTION__,dict);
    if ([[dict objectForKey:@"ret"] intValue] == 0) {
        NSLog(@"腾讯微博发送成功");
    }else {
        NSLog(@"腾讯微博发送失败");
    }
}

/**   函数名称 :createFail
 **   函数作用 :TODO:腾讯微博分享失败
 **   函数参数 :
 **   函数返回值:
 **/
- (void)createFail:(NSError *)error {
    NSLog(@"error is %@",error);
    NSLog(@"腾讯微博发送失败");
}

/**   函数名称 :successCallBack
 **   函数作用 :TODO:腾讯微博分享成功
 **   函数参数 :
 **   函数返回值:
 **/
- (void)successCallBack:(id)result{
    NSLog(@"腾讯微博发送成功");
    if (_delegate && [_delegate respondsToSelector:@selector(shareSuccess)]) {
        [_delegate shareSuccess];
    }
}

/**   函数名称 :failureCallBack
 **   函数作用 :TODO:腾讯微博分享失败
 **   函数参数 :
 **   函数返回值:
 **/
- (void)failureCallBack{
    NSLog(@"腾讯微博发送失败");
    if (_delegate && [_delegate respondsToSelector:@selector(shareFailed:)]) {
        [_delegate shareFailed:@"腾讯微博分享失败"];
    }
}

@end
