//
//  TabBarView.m
//  WN
//
//  Created by 王 尧 on 13-2-16.
//  Copyright (c) 2013年 BuildRun. All rights reserved.
//

#import "TabBarView.h"

#define tag_plus 123
@implementation TabBarView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

/**
 * TODO: 初始化界面
 * @author Wangyao
 * @param  N/A
 * @return N/A
 * @since  N/A
 */
- (void)initView
{
    TabItemView *item1 = [[[NSBundle mainBundle] loadNibNamed:@"TabItemView" owner:self options:nil] lastObject];
    item1.delegate = self;
    item1.tag = tag_plus + 0;
    [item1 initViewWithType:TAB_TYPE_INFO_NEWS];
    [item1 selectItem];
    [item1 setFrame:CGRectMake(0, 13, item1.frame.size.width, item1.frame.size.height)];
    [self addSubview:item1];
    
    
    TabItemView *item2 = [[[NSBundle mainBundle] loadNibNamed:@"TabItemView" owner:self options:nil] lastObject];
    item2.delegate = self;
    item2.tag = tag_plus + 1;
    [item2 initViewWithType:TAB_TYPE_NEW_GOODS];
    [item2 setFrame:CGRectMake(item1.frame.size.width, 13, item2.frame.size.width, item2.frame.size.height)];
    [self addSubview:item2];
    
    TabItemView *item3 = [[[NSBundle mainBundle] loadNibNamed:@"TabItemView" owner:self options:nil] lastObject];
    item3.delegate = self;
    item3.tag = tag_plus + 2;
    [item3 initViewWithType:TAB_TYPE_SHOP];
    [item3 setFrame:CGRectMake(item2.frame.size.width*2, 13, item3.frame.size.width, item3.frame.size.height)];
    [self addSubview:item3];
    
    TabItemView *item4 = [[[NSBundle mainBundle] loadNibNamed:@"TabItemView" owner:self options:nil] lastObject];
    item4.delegate = self;
    item4.tag = tag_plus + 3;
    [item4 initViewWithType:TAB_TYPE_COLLECTION];
    [item4 setFrame:CGRectMake(item2.frame.size.width*3, 13, item4.frame.size.width, item4.frame.size.height)];
    [self addSubview:item4];
    
    TabItemView *item5 = [[[NSBundle mainBundle] loadNibNamed:@"TabItemView" owner:self options:nil] lastObject];
    item5.delegate = self;
    item5.tag = tag_plus + 4;
    [item5 initViewWithType:TAB_TYPE_MORE];
    [item5 setFrame:CGRectMake(item2.frame.size.width*4, 13, item5.frame.size.width, item5.frame.size.height)];
    [self addSubview:item5];
}

- (void)awakeFromNib
{
    [self initView];
}

#pragma mark-==========================TabItemViewDelegate================================
/**
 * TODO: 选中item后回调
 * @author Wangyao
 * @param  item 选中项
 * @return N/A
 * @since
 */
- (void)itemSelect:(TabItemView *)item
{
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[TabItemView class]]) {
            [(TabItemView *)view deselectItem];
        }
    }
    
    int index = item.tag - tag_plus;
    if (self.delegate && [self.delegate respondsToSelector:@selector(itemDidSelectedIndex:)]) {
        [self.delegate itemDidSelectedIndex:index];
    }
    
}




@end
