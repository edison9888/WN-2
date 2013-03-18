//
//  FashionNewsNode.m
//  WN
//
//  Created by 王尧 on 13-2-17.
//  Copyright (c) 2013年 BuildRun. All rights reserved.
//

#import "FashionNewsNode.h"

@implementation FashionNewsNode

- (void)dealloc
{
    self.content = nil;
    self.intro = nil;
    self.picURL = nil;
    self.title = nil;
    [super dealloc];
}

@end
