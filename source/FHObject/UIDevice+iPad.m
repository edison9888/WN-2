//
//  UIDevice+iPad.m
//  teacher
//
//  Created by shenzhen on 12-9-4.
//  Copyright (c) 2012年 imohoo. All rights reserved.
//

#import "UIDevice+iPad.h"

@implementation UIDevice (iPad)

- (BOOL) isIPad
{
	if ([self respondsToSelector:@selector(userInterfaceIdiom)])
	{
		return (self.userInterfaceIdiom == UIUserInterfaceIdiomPad);
	}
	else
	{
		return NO; // cannot be iPad, OS &lt; 3.2
	}
}

-(NSString *)machineType{
    return [UIDevice currentDevice].model;
}

@end
