//
//  WN_Http.h
//  WN
//
//  Created by 王尧 on 13-2-17.
//  Copyright (c) 2013年 BuildRun. All rights reserved.
//

#ifndef WN_WN_Http_h
#define WN_WN_Http_h

//焦点列表数据 (focus_listJson)
#define FOCUS_LIST_URL @"http://iprefer.yulingtech.com/woning/focus_listJson.do"

//焦点详情 (focus_showInfoJson)
#define FOCUS_SHOWINFO_URL @"http://iprefer.yulingtech.com/focus_showInfoJson.do?focusId=%d"

//焦点详情webview (focus_showInfoJson)
#define FOCUS_SHOWINFO_JSP_URL @"http://iprefer.yulingtech.com/focus_showInfoJsp.do?focusId=%d"

//时尚资讯列表接口 (news_listJson)
#define NEWS_LIST_URL @"http://iprefer.yulingtech.com/news_listJson.do?pageNow=%d&pageCount=%d"

//时尚资讯详情 (news_showInfoJson)
#define NEWS_SHOWINFO_URL @"http://iprefer.yulingtech.com/news_showInfoJson.do?newsId=%d"

//时尚资讯详情webview (news_showInfoJsp)
#define NEWS_SHOWINFO_JSP_URL @"http://iprefer.yulingtech.com/news_showInfoJsp.do?newsId=%d"

//促销信息默认(有效)列表接口 (promotion_listJson)
#define PROMOTION_LIST_URL @"http://iprefer.yulingtech.com/promotion_listJson.do?pageNow=%d&pageCount=%d"

//商品分类列表接口 (goodsCategory_listJson)
#define GOODS_CATE_LIST_URL @"http://iprefer.yulingtech.com/goodsCategory_listJson.do"

//商品列表接口 (goods_listJson)
#define GOODS_LIST_URL @"http://iprefer.yulingtech.com/goods_listJson.do?categoryId=%d&pageNow=%d&pageCount=%d"

//商品被收藏接口 (goods_collection)
#define GOODS_COLLECTION_URL @"http://iprefer.yulingtech.com/goods_collection.do?goodsId=%d"

//门市列表接口 (shop_listJson)
#define SHOP_LIST_URL @"http://iprefer.yulingtech.com/shop_listJson.do"

//版本更新 (version_getCurrentVersion)
#define VERSION_UPDATE_URL @"http://iprefer.yulingtech.com/version_getCurrentVersion.do"

//品牌文化详情接口 (companyInfo_showInfoJson)
#define COMPANY_SHOWINFO_URL @"http://iprefer.yulingtech.com/companyInfo_showInfoJson.do"

//品牌文化详情webview (companyInfo_showInfoJsp)
#define COMPANY_INFO_SHOW_JSP_URL @"http://iprefer.yulingtech.com/companyInfo_showInfoJsp.do"

//淘宝主页
#define TAO_BAO_URL @"http://shop.m.taobao.com/shop/shop_index.htm?shop_id=60692849"

//促销信息全部列表接口 (promotion_listAllJson)
#define PROMOTION_LISTALL_URL @"http://iprefer.yulingtech.com/promotion_listAllJson.do?pageNow=%d&pageCount=%d"

//促销信息失效列表接口 (promotion_listInvalidJson)
#define PROMOTION_LIST_INCALID_URL @"http://iprefer.yulingtech.com/promotion_listInvalidJson.do?pageNow=%d&pageCount=%d"

//消息通知接口 (notices_getTodayNotices)
#define NOTICE_GET_URL @"http://iprefer.yulingtech.com/notices_getIosNotices.do?taken=%@"

#define WEI_BO_INFO_URL @"https://api.weibo.com/2/statuses/user_timeline.json?uid=1713429071&count=10&page=%d&access_token=2.00_8MopCr5YNmD58265fb946f2iXVD"


#endif
