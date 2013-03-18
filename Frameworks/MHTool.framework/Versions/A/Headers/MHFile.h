//
//  MHFile.h
//  YangziNew
//
//  Created by yao wang on 11-11-2.
//  Copyright (c) 2011年 imohoo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MHFile : NSObject
/*
 * 函数作用: 根据文件名称获取资源文件路径
 * 函数参数: filename  文件名称
 * 函数返回值: 返回资源文件路径
 */
+(NSString *)getResourcesFile:(NSString *)fileName;

/*
 * 函数作用: 根据文件名称获取Doc目录中文件路径
 * 函数参数: fileName  文件名称
 * 函数返回值: 返回Doc目录中文件路径
 */
+(NSString *)getLocalFilePath:(NSString *)fileName;

/*
 * 函数作用: 根据文件名称获取缓存目录中文件路径
 * 函数参数: fileName  文件名称
 * 函数返回值: 返回Doc目录中文件路径
 */
+(NSString *)getCacheFilePath:(NSString *)fileName;

/*
 * 函数作用: 根据目录名称创建文件夹目录
 * 函数参数: dir 目录名称
 * 函数返回值: 返回文件夹目录名称
 */
+(NSString *)createDir:(NSString *)dirName;

/*
 * 函数作用: 根据目录路径创建文件夹目录
 * 函数参数: 文件夹目录绝对路径
 * 函数返回值: N/A
 */
+(void)createDirWithDirPath:(NSString *)path;

/*
 * 函数作用: 根据文件名判断Doc目录中是否存在
 * 函数参数: fileName 文件目录名称
 * 函数返回值: 是否存在 BOOL  YES (存在) NO (不存在)
 */
+(BOOL)isExistsFileInDoc:(NSString *)fileName;

/*
 * 函数作用: 根据文件名判断资源文件中是否存在
 * 函数参数: fileName 文件目录名称
 * 函数返回值: 是否存在 BOOL  YES (存在) NO (不存在)
 */
+(BOOL)isExistsFileInRescource:(NSString *)fileName;

/*
 * 函数作用: 根据文件路径判断是否存在
 * 函数参数: filePath 文件目录名称
 * 函数返回值: 是否存在 BOOL  YES (存在) NO (不存在)
 */
+(BOOL)isExistsFile:(NSString *)filePath;

/*
 * 函数作用: 根据文件路径获取文件名称
 * 函数参数: filepath  文件的绝对路径
 * 函数返回值: 文件名称 (带文件类型的）
 */
+(NSString *)getFileNameByPath:(NSString *)filepath;

/*
 * 函数作用:  根据文件路径删除目录
 * 函数参数:  filepath 文件路径
 * 函数返回值: N/A
 */
+(void)removeDirByPath:(NSString *)filepath;

/*
 * 函数作用:  根据文件名称删除目录
 * 函数参数:  fileName 文件目录名称
 * 函数返回值: N/A
 */
+(void)removeDirByName:(NSString *)fileName;

/*
 * 函数名     getAllFileByName
 * 函数作用:  获取文件目录下所有文件名称
 * 函数参数:  fileName 文件目录名称
 * 函数返回值: 文件名arr
 */
+(NSArray *)getAllFileByName:(NSString *)path;

/*
 * 函数作用: copy文件
 * 函数参数: srcPath--原始文件  dstPath--目标文件
 * 函数返回值: 
 */
+(BOOL)copyFile:(NSString *)srcPath dstPath:(NSString *)dstPath;

@end
