//
//  BaseViewController.h
//  WN
//
//  Created by 王尧 on 13-2-17.
//  Copyright (c) 2013年 BuildRun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WN_HttpRequest.h"

@interface BaseViewController : UIViewController<WN_HttpRequestDelegate>
@property (nonatomic, retain) WN_HttpRequest *httpRequest;


- (void)resumNavigationController;

- (void)fullNavigationController;

@end
