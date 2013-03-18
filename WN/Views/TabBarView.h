//
//  TabBarView.h
//  WN
//
//  Created by 王 尧 on 13-2-16.
//  Copyright (c) 2013年 BuildRun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TabItemView.h"
@protocol TabBarViewDelegate <NSObject>

/**
 * TODO: 某个模块被选中
 * @author Wangyao
 * @param  index  选中的下标
 * @return N/A
 * @since  2013 02 16
 */
- (void)itemDidSelectedIndex:(int)index;

@end

@interface TabBarView : UIView<TabItemViewDelegate>

@property (nonatomic, assign) id<TabBarViewDelegate> delegate;

@end
