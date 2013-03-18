//
//  ViewController.h
//  WN
//
//  Created by 王 尧 on 13-2-16.
//  Copyright (c) 2013年 BuildRun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TabBarView.h"
#import "FHShareManager.h"
#import "FocusNode.h"
#import "CollectionViewController.h"


@interface ViewController : UIViewController<TabBarViewDelegate>

@property (nonatomic, retain) TabBarView *tabView;
@property (nonatomic, retain) CollectionViewController  *collectViewController;


/**
 ** @Desc   TODO:打开焦点详情界面
 ** @author 王尧
 ** @param  (id)node  详情节点
 ** @return N/A
 ** @since
 */
- (void)pushFocusDetaiWebViewController:(id)node;

- (void)pushWebView_Pingpai;
- (void)pushWebView_TaoBao;

/**
 ** @Desc   TODO:打开时尚资讯
 ** @author 王尧
 ** @param  N/A
 ** @return N/A
 ** @since
 */
- (void)pushFashionNewsListViewController;

/**
 ** @Desc   TODO:促销资讯界面
 ** @author 王尧
 ** @param  N/A
 ** @return N/A
 ** @since
 */
- (void)pushPromotionListViewController;

/**
 ** @Desc:   TODO:打开官方微博
 ** @Author: StackHero
 ** @Params: N/A
 ** @Return: N/A
 ** @Since:  
 **/
- (void)pushWeiBOListViewController;

/**
 * TODO: 商品列表界面
 * @author Wangyao
 * @param  cataId 类别ID
 * @return N/A
 * @since  N/A
 */
- (void)pushGoodsListViewControllerWithCataId:(int)cataId;
- (void)pushGoodsListViewControllerWithCataId:(int)cataId withItemId:(int)itemId;


- (void)pushShareViewController:(FHShareManager *)shareManager shareTextInfo:(NSString *)shareInfo shareImageUrl:(NSString *)imageUrl shareImage:(UIImage *)image;



@end
