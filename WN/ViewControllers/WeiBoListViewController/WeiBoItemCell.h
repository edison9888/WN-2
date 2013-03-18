//
//  WeiBoItemCell.h
//  WN
//
//  Created by 王尧 on 13-2-24.
//  Copyright (c) 2013年 BuildRun. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WeiBoNode;
@interface WeiBoItemCell : UITableViewCell

@property (nonatomic, retain) UIImageView *iconImageView;
@property (nonatomic, retain) UILabel     *weiboNameLabel;
@property (nonatomic, retain) UILabel     *dateNameLabel;
@property (nonatomic, retain) UILabel     *weiboInfoLabel;
@property (nonatomic, retain) UILabel     *weiboRetweetLabel;
@property (nonatomic, retain) UIImageView *weiboImageView;
@property (nonatomic, retain) UILabel     *sourceLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier weiBoNode:(WeiBoNode *)node;


/**
 ** @Desc:   TODO:返回cell的高度（根据数据内容返回高度）
 ** @Author: StackHero
 ** @Params: N/A
 ** @Return: N/A
 ** @Since:
 **/
- (CGFloat)returnCellHeight:(WeiBoNode *)weiboNode;

- (void)refreshCellInfoWith:(WeiBoNode *)weiboNode;

@end
