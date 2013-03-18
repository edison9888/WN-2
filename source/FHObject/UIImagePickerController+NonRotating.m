//
//  UIImagePickerController+NonRotating.m
//  Education
//
//  Created by 王尧 on 12-10-29.
//  Copyright (c) 2012年 UReading. All rights reserved.
//

#import "UIImagePickerController+NonRotating.h"

@implementation UIImagePickerController (NonRotating)
- (BOOL)shouldAutorotate
{
    return NO;
}

-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}
@end
