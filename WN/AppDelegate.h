//
//  AppDelegate.h
//  WN
//
//  Created by 王 尧 on 13-2-16.
//  Copyright (c) 2013年 BuildRun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "WXApi.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,WXApiDelegate,MHNetWorkListennerDelegate,UIAlertViewDelegate>{
    NSDictionary *notiInfo;
}

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ViewController *viewController;

@property (strong, nonatomic) UINavigationController *rootNavigationController;

@property (assign, nonatomic) BOOL isEnableWifi;

//=================微信分享================
/**   函数名称 :shareMsgToWeixin
 **   函数作用 :TODO:分享消息到微信到某个会话
 **   函数参数 :
 **   函数返回值:
 **/
-(void)shareMsgToWeixin_Session:(NSString *)msg;
/**   函数名称 :shareMsgToWeixin_TimeLine
 **   函数作用 :TODO:分享消息到微信朋友圈
 **   函数参数 :
 **   函数返回值:
 **/
-(void)shareMsgToWeixin_TimeLine:(NSString *)msg;
/**   函数名称 :shareMsgToWeixin
 **   函数作用 :TODO:分享图片到微信
 **   函数参数 :
 **   函数返回值:
 **/
- (void)sharePhotoToWeixin:(UIImage *)img description:(NSString *)desc;

-(void)updateUIWithPushInfo:(NSDictionary *)pushInfo;

@end

extern AppDelegate *app;
