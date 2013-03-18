//
//  GoodsNode.h
//  WN
//
//  Created by 王 尧 on 13-2-17.
//  Copyright (c) 2013年 BuildRun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodsNode : NSObject
@property (nonatomic, retain) NSString *categoryName;
@property (nonatomic, assign) NSInteger favNum;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, retain) NSString *intro;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *picURL;
@property (nonatomic, assign) NSInteger price;
@property (nonatomic, retain) NSString *taobaoURL;
@end
