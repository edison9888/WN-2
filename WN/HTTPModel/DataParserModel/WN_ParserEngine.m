//
//  DJ_ParserEngine.m
//  Deji_Plaza
//
//  Created by 王 尧 on 12-12-28.
//  Copyright (c) 2012年 王尧. All rights reserved.
//

#import "WN_ParserEngine.h"
#import "WN_Http.h"

@implementation WN_ParserEngine

static WN_ParserEngine *_sharedInstance = nil;

#pragma mark- =================================Singleton Constructor=======================================
/**   函数名称 :shareInstance:
 **   函数作用 :TODO:获取数据解析单例
 **   函数参数 :N/A
 **   函数返回值:DJ_ParserEngine 单例对象
 **/
+ (WN_ParserEngine *)shareInstance
{
    if (_sharedInstance == nil)
    {
        _sharedInstance = [NSAllocateObject([self class], 0, NULL) init];
    }
    return _sharedInstance;
}

+ (id) allocWithZone:(NSZone *)zone
{
    return [[self shareInstance] retain];
}

- (id) copyWithZone:(NSZone*)zone
{
    return self;
}

- (id) retain
{
    return self;
}

- (NSUInteger) retainCount
{
    return NSUIntegerMax;
}

- (oneway void) release
{
    
}

- (id) autorelease
{
    return self;
}

#pragma mark- =======================================Function declaration==========================================

@end
