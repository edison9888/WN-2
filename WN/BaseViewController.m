//
//  BaseViewController.m
//  WN
//
//  Created by 王尧 on 13-2-17.
//  Copyright (c) 2013年 BuildRun. All rights reserved.
//

#import "BaseViewController.h"
#import "AppDelegate.h"
@interface BaseViewController ()



@end



@implementation BaseViewController

- (void)dealloc
{
    self.httpRequest = nil;
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

- (void)resumNavigationController
{
    [app.viewController.tabView setHidden:NO];
    [self.navigationController.view setFrame:CGRectMake(0, 0, 320, 400)];
}

- (void)fullNavigationController
{
    [app.viewController.tabView setHidden:YES];
    [self.navigationController.view setFrame:CGRectMake(0, 0, 320, 460)];
}


- (void)viewDidLoad
{
    self.httpRequest = [[[WN_HttpRequest alloc] initRequestWithDelegate:self] autorelease];
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
}

@end
