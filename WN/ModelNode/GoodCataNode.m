//
//  GoodCataNode.m
//  WN
//
//  Created by 王尧 on 13-2-17.
//  Copyright (c) 2013年 BuildRun. All rights reserved.
//

#import "GoodCataNode.h"

@implementation GoodCataNode

- (void)dealloc
{
    self.name = nil;
    self.picURL = nil;
    [super dealloc];
}

@end
