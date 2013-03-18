//
//  GoodsNode.m
//  WN
//
//  Created by 王 尧 on 13-2-17.
//  Copyright (c) 2013年 BuildRun. All rights reserved.
//

#import "GoodsNode.h"

@implementation GoodsNode

- (void)dealloc
{
    self.categoryName = nil;
    self.intro = nil;
    self.name = nil;
    self.picURL = nil;
    self.taobaoURL = nil;
    
    [super dealloc];
}

@end
