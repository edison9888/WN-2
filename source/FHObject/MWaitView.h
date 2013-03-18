//
//  MWaitView.h
//  DZJYPT
//
//  Created by shenzhen on 12-7-31.
//  Copyright (c) 2012年 imohoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MWaitView : UIView{
    UIImageView         *_imageView;
}


-(void)start;
-(void)stop;
@end
