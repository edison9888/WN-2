//
//  InfoViewController.h
//  WN
//
//  Created by 王 尧 on 13-2-16.
//  Copyright (c) 2013年 BuildRun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface InfoViewController : BaseViewController<UIScrollViewDelegate>

@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) IBOutlet UIPageControl *pageController;

/**
 ** @Desc   TODO:时尚资讯
 ** @author 王尧
 ** @param  sender消息对象
 ** @return N/A
 ** @since
 */
- (IBAction)fashionListAction:(id)sender;

/**
 ** @Desc   TODO:打开促销信息
 ** @author 王尧
 ** @param  N/A
 ** @return N/A
 ** @since
 */
- (IBAction)promotionNewsAction:(id)sender;

/**
 ** @Desc:   TODO:打开官方微博
 ** @Author: StackHero
 ** @Params: N/A
 ** @Return: N/A
 ** @Since:  
 **/
- (IBAction)weiboOffcialAction:(id)sender;

@end
