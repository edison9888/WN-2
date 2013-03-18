//
//  FHShareManager.h
//  FHShare
//
//  Created by wangyao on 13-1-3.
//  Copyright (c) 2013年 wangyao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SinaWeibo.h"
#import "TCWBEngine.h"

//新浪
#define SinaAppKey          GETKEY(@"SinaWeiBoAppKey")
#define SinaAppSecret       GETKEY(@"SinaWeiBoAppSecret")
#define SinaAppRedirectURI  GETKEY(@"SinaWeiBoAppRedirectUrl")
//腾讯
#define TCAppKey            GETKEY(@"TCWeiBoAppKey")
#define TCAppSecret         GETKEY(@"TCWeiBoAppSecret")
#define TCAppRedirectURI    GETKEY(@"TCWeiBoAppRedirectUrl")

typedef enum {
    SINAWEIBO = 1001,           /* 新浪微博 */
    TCWEIBO,             /* 腾讯微博 */
    RENREN,              /* 人人 */
} ShareType;


@protocol FHShareManagerDelegate <NSObject>

/**   函数名称 :shareSuccess
 **   函数作用 :TODO:分享成功
 **   函数参数 :
 **   函数返回值:
 **/
-(void)shareSuccess;
/**   函数名称 :shareFailed
 **   函数作用 :TODO:分享失败
 **   函数参数 :
 **   函数返回值:
 **/
-(void)shareFailed:(NSString *)errorMsg;
/**   函数名称 :didLogin
 **   函数作用 :TODO:成功登陆
 **   函数参数 :
 **   函数返回值:
 **/
-(void)didLogin;
/**   函数名称 :loginFailed
 **   函数作用 :TODO:登陆失败
 **   函数参数 :
 **   函数返回值:
 **/
-(void)loginFailed:(NSString *)errorMsg;
/**   函数名称 :didlogout
 **   函数作用 :TODO:登出
 **   函数参数 :
 **   函数返回值:
 **/
-(void)didlogout;

@end

@interface FHShareManager : NSObject <SinaWeiboDelegate,SinaWeiboRequestDelegate>
{
    //新浪
    SinaWeibo *_sinaweibo;
    //腾讯
    TCWBEngine *_tcweibo;
    //当前IP
    NSString *_ip;
}

//平台类型
@property (nonatomic,assign) ShareType type;
//是否绑定
@property (nonatomic,assign) BOOL isBind;
//代理
@property (nonatomic,assign) id <FHShareManagerDelegate> delegate;

@property (nonatomic,retain) SinaWeibo *sinaweibo;
@property (nonatomic,retain) TCWBEngine *tcweibo;

/**   函数名称 :shareMessage
 **   函数作用 :TODO:分享信息
 **   函数参数 :
 **   函数返回值:
 **/
-(void)shareMessage:(NSString *)msg;

/**   函数名称 :shareMessage:Image
 **   函数作用 :TODO:分享图片信息(图片)
 **   函数参数 :
 **   函数返回值:
 **/
-(void)shareMessage:(NSString *)msg Image:(UIImage *)image;

/**   函数名称 :shareMessage:ImageUrl
 **   函数作用 :TODO:分享图片信息(url)
 **   函数参数 :
 **   函数返回值:
 **/
-(void)shareMessage:(NSString *)msg ImageUrl:(NSString *)imageUrl;


/**   函数名称 :login
 **   函数作用 :TODO:登陆
 **   函数参数 :
 **   函数返回值:
 **/
-(void)login;

/**   函数名称 :logout
 **   函数作用 :TODO:登出
 **   函数参数 :
 **   函数返回值:
 **/
-(void)logout;

/*腾讯分享专有调用方法*/
/**   函数名称 :setTCweiboRootController
 **   函数作用 :TODO:设置腾讯微博根控制器
 **   函数参数 :
 **   函数返回值:
 **/
-(void)setTCweiboRootController:(UIViewController *)controller;
@end
