//
//  MoreViewController.h
//  WN
//
//  Created by 王尧 on 13-2-18.
//  Copyright (c) 2013年 BuildRun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import <MessageUI/MessageUI.h>
#import "FHShareManager.h"

@interface MoreViewController : BaseViewController<UIActionSheetDelegate,MFMessageComposeViewControllerDelegate,FHShareManagerDelegate,UIScrollViewDelegate>
{
    //分享Manager
    FHShareManager *_shareManager;
}

@property (nonatomic, retain) IBOutlet UILabel *sinaBindState;
@property (nonatomic, retain) IBOutlet UILabel *tecentBindState;
@property (retain, nonatomic) IBOutlet UIScrollView *innerScrollView;
@property (retain, nonatomic) IBOutlet UILabel *downStateLabel;
@property (retain, nonatomic) IBOutlet UIImageView *downStateIcon;

/**
 ** @Desc   TODO:打开淘宝
 ** @author 王尧
 ** @param  N/A
 ** @return N/A
 ** @since
 */
- (IBAction)openTaoBao:(id)sender;

/**
 ** @Desc   TODO:打开品牌文化
 ** @author 王尧
 ** @param  N/A
 ** @return N/A
 ** @since  
 */
- (IBAction)openPinpaiCulture:(id)sender;

/**
 ** @Desc   TODO:版本检测
 ** @author 王尧
 ** @param  N/A
 ** @return N/A
 ** @since
 */
- (IBAction)versionCheck:(id)sender;

/**
 ** @Desc   TODO:分享好友
 ** @author 王尧
 ** @param  N/A
 ** @return N/A
 ** @since
 */
- (IBAction)shareToFrend:(id)sender;

/**
 ** @Desc   TODO:绑定新浪微博
 ** @author 王尧
 ** @param  N/A
 ** @return N/A
 ** @since
 */
- (IBAction)bindSina:(id)sender;


/**
 ** @Desc todo:toggleDownload image
 */

- (IBAction)toggleDownLoad:(id)sender;

/**
 ** @Desc   TODO:绑定腾讯微博
 ** @author 王尧
 ** @param  N/A
 ** @return N/A
 ** @since
 */
- (IBAction)flushCache:(id)sender;
- (IBAction)bindTecent:(id)sender;
@end
