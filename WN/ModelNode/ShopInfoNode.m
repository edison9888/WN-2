//
//  ShopInfoNode.m
//  WN
//
//  Created by 王尧 on 13-2-18.
//  Copyright (c) 2013年 BuildRun. All rights reserved.
//

#import "ShopInfoNode.h"

@implementation ShopInfoNode

- (void)dealloc
{
    self.address = nil;
    self.addressE = nil;
    self.intro = nil;
    self.name = nil;
    self.picURL = nil;
    self.tel = nil;
    self.tel2 = nil;
    
    [super dealloc];
}

@end
