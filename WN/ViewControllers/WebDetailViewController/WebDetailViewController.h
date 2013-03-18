//
//  WebDetailViewController.h
//  WN
//
//  Created by 王尧 on 13-2-17.
//  Copyright (c) 2013年 BuildRun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "BaseViewController.h"
#import "FHShareManager.h"
#import "FashionNewsNode.h"
#import "GoodsNode.h"

typedef enum {
    //资讯详情
    DETAIL_TYPE_FASHION_NEWS,
    //商品详情
    DETAIL_TYPE_GOODS,
    //焦点推荐
    DETAIL_TYPE_FOCUS_RECOM
}DETAIL_TYPE;

@interface WebDetailViewController : BaseViewController<UIActionSheetDelegate,MFMessageComposeViewControllerDelegate>
{
    //分享Manager
    FHShareManager *_shareManager;
}
@property (nonatomic, retain) IBOutlet UIWebView *webView;
@property (nonatomic, assign) id delegate;

@property (nonatomic, retain) IBOutlet UILabel *titleLabel;

@property (nonatomic, retain) IBOutlet UIButton *shareBtn;

@property (nonatomic, retain) FashionNewsNode *fashionNode;

@property (nonatomic, retain) IBOutlet UIButton *collectBtn;

@property (nonatomic, retain) GoodsNode        *goodsNode;

/**
 * TODO: 分享操作
 * @author Wangyao
 * @param  (id)sender 
 * @return
 * @since  
 */
- (IBAction)shareAction:(id)sender;

/**
 ** @Desc   TODO:返回操作
 ** @author 王尧
 ** @param  N/A
 ** @return N/A
 ** @since  
 */
- (IBAction)backAction:(id)sender;

/**
 ** @Desc   TODO:加载webview的内容
 ** @author 王尧
 ** @param  (NSString *)url webview需要加载的URL type 详情类型
 ** @return N/A
 ** @since
 */
- (void)loadWebViewWithUrl:(NSString *)url type:(DETAIL_TYPE)type;

/**
 * TODO: 加载品牌文化
 * @author Wangyao
 * @param
 * @return
 * @since
 */
- (void)loadWebPingPaiInfo:(NSString *)url;

/**
 * TODO: 加载淘宝主页
 * @author Wangyao
 * @param
 * @return
 * @since  
 */
- (void)loadWebTaoBaoView:(NSString *)url;

@end
