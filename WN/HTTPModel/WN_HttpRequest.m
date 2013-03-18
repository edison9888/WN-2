//
//  DJ_HttpRequest.m
//  Deji_Plaza
//
//  Created by 王尧 on 12-12-28.
//  Copyright (c) 2012年 王尧. All rights reserved.
//

#import "WN_HttpRequest.h"
#import "WN_Http.h"
#import "WN_ParserEngine.h"

@implementation WN_HttpRequest

- (void)dealloc
{
    if (_httpRequest) {
        [_httpRequest cancel];
        _httpRequest.delegate = nil;
        [_httpRequest release];
        _httpRequest = nil;
    }
    [super dealloc];
}

/**   函数名称 :initRequestWithDelegate:
 **   函数作用 :TODO:初始化
 **   函数参数 :delegate 回调对象
 **   函数返回值:
 **/
- (id)initRequestWithDelegate:(id)delegate
{
    self = [super init];
    if (self) {
        self.delegate = delegate;
        //初始化数据解析引擎
        _parserEngine = [WN_ParserEngine shareInstance];
    }
    return self;
}

/**   函数名称 :requestWithURL:
 **   函数作用 :TODO:通过URL发出请求
 **   函数参数 :N/A
 **   函数返回值:N/A
 **/
- (void)requestWithURL:(NSString *)url
{
    NSLog(@"%s,%d\n%@",__func__,__LINE__,url);
    
    if (_httpRequest) {
        [_httpRequest cancel];
        [_httpRequest setDelegate:nil];
        [_httpRequest release];
        _httpRequest=nil;
    }
    if (url && [url length] > 0) {
        //初始化网络请求
        _httpRequest = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:url]];
        _httpRequest.delegate = self;
        [_httpRequest startAsynchronous];
    }
}

#pragma mark- =================================Function declaration=======================================================
/**
 ** @Desc   TODO:请求 焦点列表数据 (focus_listJson)
 ** @author 王尧
 ** @param  N/A
 ** @return N/A
 ** @since
 */
- (void)requestFocusListAction
{
    [self requestWithURL:FOCUS_LIST_URL];
}

/**
 ** @Desc   TODO:请求时尚资讯列表
 ** @author 王尧
 ** @param  currentPage 当前页  pageCount 没一页的数量
 ** @return N/A
 ** @since
 */
- (void)requestFashionNewsActionWith:(int)currentPage pageCount:(int)pageCount
{
    [self requestWithURL:[NSString stringWithFormat:NEWS_LIST_URL,currentPage,pageCount]];
}

/**
 ** @Desc   TODO:促销信息列表
 ** @author 王尧
 ** @param  currentPage 当前页  pageCount 没一页的数量
 ** @return N/A
 ** @since
 */
- (void)requestPromotionListActionWith:(int)currentPage pageCount:(int)pageCount
{
    [self requestWithURL:[NSString stringWithFormat:PROMOTION_LIST_URL,currentPage,pageCount]];
}

/**
 ** @Desc   TODO:商品分类列表
 ** @author 王尧
 ** @param  N/A
 ** @return N/A
 ** @since  
 */
- (void)requestGoodsCatagoryListAction
{
    [self requestWithURL:GOODS_CATE_LIST_URL];
}

/**
 * TODO: 请求某个类别的列表
 * @author Wangyao
 * @param  currentPage 当前页  pageCount 没一页的数量  cataId 类别ID
 * @return
 * @since  
 */
- (void)requestGoodsListActionWith:(int)currentPage pageCount:(int)pageCount cataId:(int)cataId
{
    [self requestWithURL:[NSString stringWithFormat:GOODS_LIST_URL,cataId,currentPage,pageCount]];
}


/**
 ** @Desc   TODO:请求门市列表
 ** @author 王尧
 ** @param  N/A
 ** @return N/A
 ** @since  
 */
- (void)requestShopListAction
{
    [self requestWithURL:SHOP_LIST_URL];
}

#pragma mark- =================================ASIHTTPRequestDelegate===================================================
/**   函数名称 :requestFinished:
 **   函数作用 :TODO:网络请求成功
 **   函数参数 :request  请求对象
 **   函数返回值:
 **/
- (void)requestFinished:(ASIHTTPRequest *)request
{
    if ( self.delegate && [self.delegate respondsToSelector:@selector(httpRequestFinished:)]) {
        [self.delegate httpRequestFinished:request.responseString];
    }
}
/**   函数名称 :requestFailed:
 **   函数作用 :TODO:网络请求失败
 **   函数参数 :request  请求对象
 **   函数返回值:
 **/
- (void)requestFailed:(ASIHTTPRequest *)request
{
    if ( self.delegate && [self.delegate respondsToSelector:@selector(httpRequestError:)]) {
        [self.delegate httpRequestError:request.responseString];
    }
}


@end
