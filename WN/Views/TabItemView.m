//
//  TabItemView.m
//  WN
//
//  Created by 王 尧 on 13-2-16.
//  Copyright (c) 2013年 BuildRun. All rights reserved.
//

#import "TabItemView.h"




@implementation TabItemView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (void)initViewWithType:(TAB_TYPE)type
{
    self.selfType =type;
    switch (type) {
        case TAB_TYPE_INFO_NEWS:
            self.iconImageView.image = [UIImage imageWithContentsOfFile:[MHFile getResourcesFile:@"tab_icon01.png"]];
            [self.titleLabel setText:@"情报"];
            
            break;
        case TAB_TYPE_NEW_GOODS:
           self.iconImageView.image = [UIImage imageWithContentsOfFile:[MHFile getResourcesFile:@"tab_icon02.png"]];
            [self.titleLabel setText:@"新品"];
            break;
        case TAB_TYPE_SHOP:
            self.iconImageView.image = [UIImage imageWithContentsOfFile:[MHFile getResourcesFile:@"tab_icon03.png"]];
            [self.titleLabel setText:@"门市"];
            break;
        case TAB_TYPE_COLLECTION:
            self.iconImageView.image = [UIImage imageWithContentsOfFile:[MHFile getResourcesFile:@"tab_icon04.png"]];
            [self.titleLabel setText:@"收藏"];
            break;
        case TAB_TYPE_MORE:
            self.iconImageView.image = [UIImage imageWithContentsOfFile:[MHFile getResourcesFile:@"tab_icon05.png"]];
            [self.titleLabel setText:@"更多"];
            break;
        default:
            break;
    }
}


/**
 * TODO: 选中操作
 * @author Wangyao
 * @param
 * @return
 * @since
 */
- (void)selectItem
{
    self.bgImageView.image = [UIImage imageWithContentsOfFile:[MHFile getResourcesFile:@"tab_icon_press_bg.png"]];
    [self.titleLabel setTextColor:[UIColor whiteColor]];
    switch (self.selfType) {
        case TAB_TYPE_INFO_NEWS:
            self.iconImageView.image = [UIImage imageWithContentsOfFile:[MHFile getResourcesFile:@"tab_icon01_press.png"]];
            
            break;
        case TAB_TYPE_NEW_GOODS:
            self.iconImageView.image = [UIImage imageWithContentsOfFile:[MHFile getResourcesFile:@"tab_icon02_press.png"]];
            break;
        case TAB_TYPE_SHOP:
            self.iconImageView.image = [UIImage imageWithContentsOfFile:[MHFile getResourcesFile:@"tab_icon03_press.png"]];
            
            break;
        case TAB_TYPE_COLLECTION:
            self.iconImageView.image = [UIImage imageWithContentsOfFile:[MHFile getResourcesFile:@"tab_icon04_press.png"]];
            
            break;
        case TAB_TYPE_MORE:
            self.iconImageView.image = [UIImage imageWithContentsOfFile:[MHFile getResourcesFile:@"tab_icon05_press.png"]];
            
            break;
        default:
            break;
    }
}


/**
 * TODO: 取消 选中操作
 * @author Wangyao
 * @param
 * @return
 * @since
 */
- (void)deselectItem
{
    self.bgImageView.image = nil;
    [self.titleLabel setTextColor:[UIColor blackColor]];
    switch (self.selfType) {
        case TAB_TYPE_INFO_NEWS:
            self.iconImageView.image = [UIImage imageWithContentsOfFile:[MHFile getResourcesFile:@"tab_icon01.png"]];
            [self.titleLabel setText:@"情报"];
            
            break;
        case TAB_TYPE_NEW_GOODS:
            self.iconImageView.image = [UIImage imageWithContentsOfFile:[MHFile getResourcesFile:@"tab_icon02.png"]];
            [self.titleLabel setText:@"新品"];
            break;
        case TAB_TYPE_SHOP:
            self.iconImageView.image = [UIImage imageWithContentsOfFile:[MHFile getResourcesFile:@"tab_icon03.png"]];
            [self.titleLabel setText:@"门市"];
            break;
        case TAB_TYPE_COLLECTION:
            self.iconImageView.image = [UIImage imageWithContentsOfFile:[MHFile getResourcesFile:@"tab_icon04.png"]];
            [self.titleLabel setText:@"收藏"];
            break;
        case TAB_TYPE_MORE:
            self.iconImageView.image = [UIImage imageWithContentsOfFile:[MHFile getResourcesFile:@"tab_icon05.png"]];
            [self.titleLabel setText:@"更多"];
            break;
        default:
            break;
    }
}

/**
 ** @Desc   TODO:item选中
 ** @author 王尧
 ** @param  N/A
 ** @return N/A
 ** @since
 */
- (IBAction)itemSelectAction:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(itemSelect:)]) {
        [self.delegate itemSelect:self];
    }
    
    [self selectItem];
}

@end
