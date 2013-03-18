//
//  WeiBoItemCell.m
//  WN
//
//  Created by 王尧 on 13-2-24.
//  Copyright (c) 2013年 BuildRun. All rights reserved.
//

#import "WeiBoItemCell.h"
#import "WeiBoNode.h"

@interface WeiBoItemCell ()

@property (nonatomic, retain) WeiBoNode *weiBoNode;

@end

@implementation WeiBoItemCell

- (void)dealloc
{
    self.iconImageView = nil;
    self.weiboNameLabel = nil;
    self.dateNameLabel = nil;
    self.weiboInfoLabel = nil;
    self.weiboRetweetLabel = nil;
    self.weiboImageView = nil;
    self.weiBoNode = nil;
    self.sourceLabel = nil;
    [super dealloc];
}


- (void)initSysAlloc
{
    
}

- (void)initView
{
    for (UIView *view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    int h = 0;
    self.iconImageView = [[[UIImageView alloc] initWithFrame:CGRectMake(4, 17, 40, 40)] autorelease];
    [self.iconImageView setImageWithURL:[NSURL URLWithString:self.weiBoNode.iconImageUrl] placeholderImage:nil];
    [self.contentView addSubview:self.iconImageView];
    
    self.weiboNameLabel = [[[UILabel alloc] initWithFrame:CGRectMake(48, 17, 117, 21)] autorelease];
    [self.weiboNameLabel setText:self.weiBoNode.screen_name];
    [self.weiboNameLabel setFont:[UIFont systemFontOfSize:13.0f]];
    [self.weiboNameLabel setTextAlignment:NSTextAlignmentLeft];
    [self.weiboNameLabel setNumberOfLines:0];
    [self.weiboNameLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [self.weiboNameLabel setBackgroundColor:[UIColor clearColor]];
    [self.contentView addSubview:self.weiboNameLabel];
    
    
    
    self.dateNameLabel = [[[UILabel alloc] initWithFrame:CGRectMake(173, 17, 142, 21)] autorelease];
    [self.dateNameLabel setText:self.weiBoNode.createDate];
    [self.dateNameLabel setFont:[UIFont systemFontOfSize:13.0f]];
    [self.dateNameLabel setTextAlignment:NSTextAlignmentRight];
    [self.dateNameLabel setNumberOfLines:0];
    [self.dateNameLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [self.dateNameLabel setBackgroundColor:[UIColor clearColor]];
    [self.contentView addSubview:self.dateNameLabel];
    
    
    CGSize infoSize = [self.weiBoNode.shareText sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(266, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    self.weiboInfoLabel = [[[UILabel alloc] initWithFrame:CGRectMake(self.weiboNameLabel.frame.origin.x, 5+self.weiboNameLabel.frame.origin.y + self.weiboNameLabel.frame.size.height, infoSize.width, infoSize.height)] autorelease];
    [self.weiboInfoLabel setText:self.weiBoNode.shareText];
    [self.weiboInfoLabel setBackgroundColor:[UIColor clearColor]];
    [self.weiboInfoLabel setNumberOfLines:0];
    [self.weiboInfoLabel setFont:[UIFont systemFontOfSize:14.0f]];
    [self.weiboInfoLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [self.contentView addSubview:self.weiboInfoLabel];
    h += self.weiboInfoLabel.frame.origin.y + self.weiboInfoLabel.frame.size.height;
    
    if (self.weiBoNode.reTweetWweiBoNode) {
        CGSize retweetSize = [self.weiBoNode.reTweetWweiBoNode.shareText sizeWithFont:[UIFont systemFontOfSize:12.0f] constrainedToSize:CGSizeMake(266, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
        self.weiboRetweetLabel = [[[UILabel alloc] initWithFrame:CGRectMake(self.weiboNameLabel.frame.origin.x, 5+self.weiboInfoLabel.frame.origin.y + self.weiboInfoLabel.frame.size.height, retweetSize.width, retweetSize.height)] autorelease];
        [self.weiboRetweetLabel setText:self.weiBoNode.reTweetWweiBoNode.shareText];
        [self.weiboRetweetLabel setLineBreakMode:NSLineBreakByWordWrapping];
        [self.weiboRetweetLabel setNumberOfLines:0];
        [self.weiboRetweetLabel setBackgroundColor:[UIColor lightGrayColor]];
        [self.weiboRetweetLabel setFont:[UIFont systemFontOfSize:12.0f]];
        [self.contentView addSubview:self.weiboRetweetLabel];
        h += self.weiboRetweetLabel.frame.size.height+5;
        
    }
    
    if (self.weiBoNode.thumbImageUrl) {
        self.weiboImageView = [[[UIImageView alloc] initWithFrame:CGRectMake(self.weiboNameLabel.frame.origin.x, 5+h, 85, 85)] autorelease];
        [self.weiboImageView setImageWithURL:[NSURL URLWithString:self.weiBoNode.thumbImageUrl] placeholderImage:nil];
        [self.contentView addSubview:self.weiboImageView];
        h += self.weiboImageView.frame.size.height+5;
    }

    self.sourceLabel = [[[UILabel alloc] initWithFrame:CGRectMake(self.weiboNameLabel.frame.origin.x, h+5, 272, 21)] autorelease];
    [self.sourceLabel setText:self.weiBoNode.source];
    [self.sourceLabel setNumberOfLines:0];
    [self.sourceLabel setBackgroundColor:[UIColor clearColor]];
    [self.sourceLabel setTextAlignment:NSTextAlignmentLeft];
    [self.sourceLabel setFont:[UIFont systemFontOfSize:13.0f]];
    [self.contentView addSubview:self.sourceLabel];
    h += self.sourceLabel.frame.size.height+5;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier weiBoNode:(WeiBoNode *)node
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.weiBoNode = node;
    }
    return self;
}




/**
 ** @Desc:   TODO:返回cell的高度（根据数据内容返回高度）
 ** @Author: StackHero
 ** @Params: N/A
 ** @Return: N/A
 ** @Since:
 **/
- (CGFloat)returnCellHeight:(WeiBoNode *)weiboNode
{
    int h = 0;
    self.iconImageView = [[[UIImageView alloc] initWithFrame:CGRectMake(4, 17, 40, 40)] autorelease];

    
    self.weiboNameLabel = [[[UILabel alloc] initWithFrame:CGRectMake(48, 17, 117, 21)] autorelease];

    
    
    
    self.dateNameLabel = [[[UILabel alloc] initWithFrame:CGRectMake(173, 17, 142, 21)] autorelease];

    
    
    CGSize infoSize = [weiboNode.shareText sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(266, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    self.weiboInfoLabel = [[[UILabel alloc] initWithFrame:CGRectMake(self.weiboNameLabel.frame.origin.x, 5+self.weiboNameLabel.frame.origin.y + self.weiboNameLabel.frame.size.height, infoSize.width, infoSize.height)] autorelease];
    [self.weiboInfoLabel setLineBreakMode:NSLineBreakByWordWrapping];
    h += self.weiboInfoLabel.frame.origin.y + self.weiboInfoLabel.frame.size.height;
    
    if (weiboNode.reTweetWweiBoNode) {
        CGSize retweetSize = [weiboNode.reTweetWweiBoNode.shareText sizeWithFont:[UIFont systemFontOfSize:12.0f] constrainedToSize:CGSizeMake(266, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
        self.weiboRetweetLabel = [[[UILabel alloc] initWithFrame:CGRectMake(self.weiboNameLabel.frame.origin.x, 5+self.weiboInfoLabel.frame.origin.y + self.weiboInfoLabel.frame.size.height, retweetSize.width, retweetSize.height)] autorelease];
        h += self.weiboRetweetLabel.frame.size.height+5;
        
    }
    
    if (weiboNode.thumbImageUrl) {
        self.weiboImageView = [[[UIImageView alloc] initWithFrame:CGRectMake(self.weiboNameLabel.frame.origin.x, 5+h, 85, 85)] autorelease];

        h += self.weiboImageView.frame.size.height+5;
    }
    
    self.sourceLabel = [[[UILabel alloc] initWithFrame:CGRectMake(self.weiboNameLabel.frame.origin.x, h+5, 272, 21)] autorelease];


    h += self.sourceLabel.frame.size.height+5;
    
    NSLog(@"height is %d",h);
    return h;
}

- (void)refreshCellInfoWith:(WeiBoNode *)weiboNode
{
    self.weiBoNode = weiboNode;
    [self initView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
