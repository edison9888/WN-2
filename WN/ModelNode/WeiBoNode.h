//
//  WeiBoNode.h
//  WN
//
//  Created by 王尧 on 13-2-23.
//  Copyright (c) 2013年 BuildRun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeiBoNode : NSObject

@property (nonatomic, retain) NSString *createDate;
@property (nonatomic, retain) NSString *thumbImageUrl;
@property (nonatomic, retain) NSString *shareText;
@property (nonatomic, retain) NSString *source;
@property (nonatomic, retain) NSString *screen_name;

@property (nonatomic, retain) NSString *iconImageUrl;
@property (nonatomic, retain) WeiBoNode *reTweetWweiBoNode;

- (void)setSource:(NSString *)source;

@end
