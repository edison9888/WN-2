//
//  MWaitView.m
//  DZJYPT
//
//  Created by shenzhen on 12-7-31.
//  Copyright (c) 2012年 imohoo. All rights reserved.
//

#import "MWaitView.h"
#import <QuartzCore/QuartzCore.h>
#import "MHTool/MHFile.h"

@implementation MWaitView

- (id)init
{
    UIImage *image=[UIImage imageWithContentsOfFile:[MHFile getResourcesFile:@"loading.png"]];
    CGRect frame=CGRectMake(0, 0, image.size.width, image.size.height);
    self = [super initWithFrame:frame];
    if (self) {
        self.hidden=YES;
        self.backgroundColor=[UIColor clearColor];
        
        _imageView=[[UIImageView alloc] initWithImage:image];
        [self addSubview:_imageView];
        
        
        
        self.center=CGPointMake(1024/2, 748/2);
    }
    return self;
}

-(void)dealloc{
    if (_imageView) {
        [_imageView release];
        _imageView=nil;
    }
    [super dealloc];
}

-(void)startAnimating{
    [self.layer removeAllAnimations];
    
    int direction = -1;
    CABasicAnimation* rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat:(2 * M_PI) * direction];
    rotationAnimation.duration = 1.0f;
    rotationAnimation.repeatCount = 99999;
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [self.layer addAnimation:rotationAnimation forKey:@"rotateAnimation"];
}

-(void)stopAnimating{
    [self.layer removeAllAnimations];
}

-(void)start{
    self.hidden=NO;
    [self startAnimating];
}

-(void)stop{
    self.hidden=YES;
    [self stopAnimating];
}

@end
