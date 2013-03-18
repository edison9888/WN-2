//
//  TabItemView.h
//  WN
//
//  Created by 王 尧 on 13-2-16.
//  Copyright (c) 2013年 BuildRun. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    //情报
    TAB_TYPE_INFO_NEWS,
    //新品
    TAB_TYPE_NEW_GOODS,
    //门市
    TAB_TYPE_SHOP,
    //收藏
    TAB_TYPE_COLLECTION,
    //更多
    TAB_TYPE_MORE
}TAB_TYPE;

@class TabItemView;
@protocol TabItemViewDelegate <NSObject>

/**
 * TODO: 选中item后回调
 * @author Wangyao
 * @param  item 选中项
 * @return N/A
 * @since
 */
- (void)itemSelect:(TabItemView *)item;

@end

@interface TabItemView : UIView
//背景图
@property (nonatomic, retain) IBOutlet UIImageView *bgImageView;
//图标
@property (nonatomic, retain) IBOutlet UIImageView *iconImageView;
//标题名称
@property (nonatomic, retain) IBOutlet UILabel     *titleLabel;
//
@property (nonatomic, assign) TAB_TYPE selfType;

@property (nonatomic, assign) id<TabItemViewDelegate> delegate;

- (void)initViewWithType:(TAB_TYPE)type;

/**
 ** @Desc   TODO:item选中
 ** @author 王尧
 ** @param  N/A 
 ** @return N/A 
 ** @since  
 */
- (IBAction)itemSelectAction:(id)sender;

/**
 * TODO: 选中操作
 * @author Wangyao
 * @param
 * @return
 * @since  
 */
- (void)selectItem;


/**
 * TODO: 取消 选中操作
 * @author Wangyao
 * @param
 * @return
 * @since
 */
- (void)deselectItem;

@end
