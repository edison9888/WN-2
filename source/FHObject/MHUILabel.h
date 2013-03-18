//
//  MHUILabel.h
//  Education
//
//  Created by 赵化 on 12-10-23.
//  Copyright (c) 2012年 UReading. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum VerticalAlignment {
    VerticalAlignmentTop,
    VerticalAlignmentMiddle,
    VerticalAlignmentBottom,
} VerticalAlignment;


@interface MHUILabel : UILabel{
@private
    VerticalAlignment verticalAlignment_;
}


@property (nonatomic, assign) VerticalAlignment verticalAlignment;

@end
