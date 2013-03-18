//
//  DJ_HttpRequest.h
//  Deji_Plaza
//
//  Created by 王尧 on 12-12-28.
//  Copyright (c) 2012年 王尧. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WN_ParserEngine.h"

#pragma mark-======================================DJ_HttpRequestDelegate=====================================
@protocol WN_HttpRequestDelegate <NSObject>
@optional

/**   函数名称 :httpRequestError:
 **   函数作用 :TODO:服务器请求错误
 **   函数参数 :errorInfo 错误信息
 **   函数返回值:
 **/
- (void)httpRequestError:(NSString *)errorInfo;

/**
 ** @Desc   TODO:网络请求回调成功
 ** @author 王尧
 ** @param  N/A
 ** @return N/A
 ** @since  
 */
- (void)httpRequestFinished:(NSString *)responseString;

@end
#pragma mark-======================================Class declaration=====================================
@interface WN_HttpRequest : NSObject<ASIHTTPRequestDelegate>
{
    ASIHTTPRequest *_httpRequest;
    WN_ParserEngine *_parserEngine;
}

@property (nonatomic,assign) id delegate;

/**   函数名称 :initRequestWithDelegate:
 **   函数作用 :TODO:构造函数
 **   函数参数 :delegate 回调对象
 **   函数返回值:
 **/
- (id)initRequestWithDelegate:(id)delegate;

#pragma mark- =================================Function declaration=======================================================
/**   函数名称 :requestWithURL:
 **   函数作用 :TODO:通过URL发出请求
 **   函数参数 :N/A
 **   函数返回值:N/A
 **/
- (void)requestWithURL:(NSString *)url;
/**
 ** @Desc   TODO:请求 焦点列表数据 (focus_listJson)
 ** @author 王尧
 ** @param  N/A
 ** @return N/A
 ** @since  
 */
- (void)requestFocusListAction;

/**
 ** @Desc   TODO:请求时尚资讯列表
 ** @author 王尧
 ** @param  currentPage 当前页  pageCount 没一页的数量
 ** @return N/A
 ** @since  
 */
- (void)requestFashionNewsActionWith:(int)currentPage pageCount:(int)pageCount;

/**
 ** @Desc   TODO:促销信息列表
 ** @author 王尧
 ** @param  N/A currentPage 当前页  pageCount 没一页的数量
 ** @return N/A
 ** @since
 */
- (void)requestPromotionListActionWith:(int)currentPage pageCount:(int)pageCount;

/**
 ** @Desc   TODO:商品分类列表
 ** @author 王尧
 ** @param  N/A
 ** @return N/A
 ** @since
 */
- (void)requestGoodsCatagoryListAction;

/**
 * TODO: 请求某个类别的列表
 * @author Wangyao
 * @param  currentPage 当前页  pageCount 没一页的数量  cataId 类别ID
 * @return
 * @since
 */
- (void)requestGoodsListActionWith:(int)currentPage pageCount:(int)pageCount cataId:(int)cataId;

/**
 ** @Desc   TODO:请求门市列表
 ** @author 王尧
 ** @param  N/A
 ** @return N/A
 ** @since
 */
- (void)requestShopListAction;

@end
