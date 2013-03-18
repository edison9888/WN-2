//
//  InfoCell.h
//  WN
//
//  Created by 王尧 on 13-2-19.
//  Copyright (c) 2013年 BuildRun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FashionNewsNode.h"
#import "GoodsNode.h"
#import "ShopInfoNode.h"
#import "PromotionNode.h"

@interface InfoCell : UITableViewCell

@property (nonatomic, retain) IBOutlet UIImageView *titleImageView;

//时尚资讯cell
@property (nonatomic, retain) IBOutlet UILabel     *titleLabel;

@property (nonatomic, retain) IBOutlet UILabel     *introLabel;


//商品详情Cell
//价格Label
@property (nonatomic, retain) IBOutlet UILabel *priceLabel;
//收藏数量label
@property (nonatomic, retain) IBOutlet UILabel *collectionNumLabel;
//门市列表cell
@property (nonatomic, retain) IBOutlet UILabel *addressLabel;
@property (nonatomic, retain) IBOutlet UILabel *addressEnglishLabel;

@property (nonatomic, retain) IBOutlet UILabel *addtelLabel;





/**
 ** @Desc   TODO:刷新时尚资讯
 ** @author 王尧
 ** @param  N/A
 ** @return N/A
 ** @since
 */
- (void)refreshFashionNewsCellInfo:(FashionNewsNode *)node;

/**
 ** @Desc   TODO:刷新商品详情列表
 ** @author 王尧
 ** @param  (GoodsNode *)node 商品节点
 ** @return N/A
 ** @since
 */
- (void)refreshGoodsDetaiCellInfo:(GoodsNode *)node;

/**
 ** @Desc   TODO:刷新门市列表
 ** @author 王尧
 ** @param  (ShopInfoNode *)node 商店
 ** @return N/A
 ** @since
 */
- (void)refreshShopListCellInfo:(ShopInfoNode *)node;

/**
 * TODO: 刷新促销信息
 * @author Wangyao
 * @param  (PromotionNode *)node 促销节点
 * @return
 * @since
 */
- (void)refreshPromotionCellInfo:(PromotionNode *)node;
@end
