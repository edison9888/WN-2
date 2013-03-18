//
//  MHFont.h
//  YangziNew
//
//  Created by yao wang on 11-11-2.
//  Copyright (c) 2011年 imohoo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MHFont : NSObject

/*
 * 函数作用: 初始化指定大小得 微软雅黑 字体
 * 函数参数: size 字体大小
 * 函数返回值: UIFont
 */
+ (UIFont *)myFontWithSize:(int)size;
/*
 * 函数作用: 初始化指定大小得 微软雅黑(粗体) 字体
 * 函数参数: size  字体大小
 * 函数返回值: UIFont
 */
+ (UIFont *)myBoldFontWithSize:(int)size;
/*
 * 函数作用: 初始化指定名称 指定大小得字体
 * 函数参数: fontName  字体名称  size 字体大小
 * 函数返回值: UIFont
 */
+ (UIFont *)myFontWithName:(NSString *)fontName size:(int)size;

/*
 * 函数作用: 获取系统所有字体名称
 * 函数参数: 
 * 函数返回值: 字体名称数组
 */
+ (NSArray *)systemAllFontNames;


@end
