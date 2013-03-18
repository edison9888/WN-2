//
//  InfoCell.m
//  WN
//
//  Created by 王尧 on 13-2-19.
//  Copyright (c) 2013年 BuildRun. All rights reserved.
//

#import "InfoCell.h"


@implementation InfoCell

- (void)dealloc
{
    self.titleImageView = nil;
    self.titleLabel = nil;
    self.introLabel = nil;
    
    self.priceLabel = nil;
    self.collectionNumLabel = nil;
    
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

/**
 ** @Desc   TODO:刷新时尚资讯
 ** @author 王尧
 ** @param  (FashionNewsNode *)node  时尚单品节点
 ** @return N/A
 ** @since  
 */
- (void)refreshFashionNewsCellInfo:(FashionNewsNode *)node
{
    [self.titleImageView setImageWithURL:[NSURL URLWithString:node.picURL] placeholderImage:nil];
    [self.titleLabel setText:node.title];
    [self.introLabel setText:node.intro];
}

/**
 ** @Desc   TODO:刷新商品详情列表
 ** @author 王尧
 ** @param  (GoodsNode *)node 商品节点
 ** @return N/A 
 ** @since  
 */
- (void)refreshGoodsDetaiCellInfo:(GoodsNode *)node
{
    [self.titleImageView setImageWithURL:[NSURL URLWithString:node.picURL] placeholderImage:nil];
    [self.titleLabel setText:node.name];
    [self.introLabel setText:node.intro];
    
    self.collectionNumLabel.text = [NSString stringWithFormat:@"%d",node.favNum];
    self.priceLabel.text = [NSString stringWithFormat:@"¥%d",node.price];
}

//
/**
 ** @Desc   TODO:刷新门市列表
 ** @author 王尧
 ** @param  (ShopInfoNode *)node 商店
 ** @return N/A
 ** @since
 */
- (void)refreshShopListCellInfo:(ShopInfoNode *)node
{
    [self.titleImageView setImageWithURL:[NSURL URLWithString:node.picURL] placeholderImage:nil];
    [self.titleLabel setTextColor:[UIColor colorWithRed:71.0f/255.0f green:186.0f/255.0f blue:190.0f/255.0f alpha:1.0]];
    [self.titleLabel setText:node.name];
    
    [self.addressLabel setText:node.address];
    [self.addressEnglishLabel setText:node.addressE];
    [self.addtelLabel setText:node.tel];
    
}

/**
 * TODO: 刷新促销信息
 * @author Wangyao
 * @param  (PromotionNode *)node 促销节点
 * @return
 * @since  
 */
- (void)refreshPromotionCellInfo:(PromotionNode *)node
{
    [self.titleLabel setTextColor:[UIColor colorWithRed:71.0f/255.0f green:186.0f/255.0f blue:190.0f/255.0f alpha:1.0]];
    [self.titleLabel setText:node.title];
    
    [self.introLabel setText:node.intro];
}


@end
