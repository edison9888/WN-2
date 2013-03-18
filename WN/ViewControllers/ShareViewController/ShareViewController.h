//
//  ShareViewController.h
//  WN
//
//  Created by 王尧 on 13-2-20.
//  Copyright (c) 2013年 BuildRun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FHShareManager.h"

@interface ShareViewController : UIViewController<FHShareManagerDelegate,UITextViewDelegate>

//标题
@property (nonatomic, retain) IBOutlet UILabel *titleLabel;
//分享的图片
@property (nonatomic, retain) IBOutlet UIImageView *shareImageView;
//剩余文字
@property (nonatomic, retain) IBOutlet UILabel   *textInfoLabel;

@property (nonatomic, retain) IBOutlet UITextView   *textView;

@property (nonatomic, retain) IBOutlet UIButton *shareButton;

/**
 ** @Desc   TODO:分享按钮
 ** @author 王尧
 ** @param  N/A
 ** @return N/A
 ** @since  
 */
- (IBAction)shareAction:(id)sender;

/**
 ** @Desc   TODO:返回按钮
 ** @author 王尧
 ** @param  N/A
 ** @return N/A
 ** @since
 */
- (IBAction)backAction:(id)sender;

/**
 ** @Desc   TODO:打开分享界面
 ** @author 王尧
 ** @param  N/A
 ** @return N/A
 ** @since
 */
- (void)openShareViewAction:(FHShareManager *)shareManager shareTextInfo:(NSString *)shareInfo shareImageUrl:(NSString *)imageUrl shareImage:(UIImage *)image;

@end
