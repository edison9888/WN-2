//
//  MHSystemTool.h
//  test
//
//  Created by libin li on 11-11-16.
//  Copyright (c) 2011年 imohoo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MHSystemTool : NSObject
/**   方法名称 :GetCurrentLocale
 **   方法作用 :获取当前手机里的区域
 **   方法参数 : 
 **   方法返回值:当前区域
 **/
+ (NSString *)currentLocale;

/**   方法名称 :GetCurrentLanguage
 **   方法作用 :获取当前手机里的语言
 **   方法参数 : 
 **   方法返回值:当前语言
 **/
+ (NSString *)currentLanguage;

/**   方法名称 :GetCurrentLanguage
 **   方法作用 :获取手机里所有语言
 **   方法参数 : 
 **   方法返回值:当前语言
 **/
+ (NSArray *)allLanguage;

/**   方法名称 :GetDeviceModel
 **   方法作用 :得到当前设备的model
 **   方法参数 : 
 **   方法返回值:model
 **/
+ (NSString *)deviceModel;
/**   方法名称 :GetDateString
 **   方法作用 :将日期字符串转换成date
 **   方法参数 : 
 **           formatter  ---要的格式，比如:@"MMM yyyy"
 **           date       ---日期
 **   方法返回值:格式
 **/
+ (NSDate *)stringDate:(NSString *)formatter string:(NSString *)string;

/**   方法名称 :GetDeviceCamera
 **   方法作用 :获取是否有摄像头
 **   方法参数 :
 **   方法返回值:uuid
 **/
+ (BOOL)deviceCamera;
/**   方法名称 :GetDeivceVersion
 **   方法作用 :设备系统版本号
 **   方法参数 :
 **   方法返回值:版本号
 **/
+ (NSString *)deivceVersion;
/**   方法名称 :GetDeivceName
 **   方法作用 :设备系统版本号
 **   方法参数 :
 **   方法返回值:设备名字
 **/
+ (NSString *)deivceName;
/**   方法名称 :GetDeviceBattery
 **   方法作用 :电池信息 
 **   方法参数 :
 **   方法返回值:电池信息 
 **/
+ (NSString *)deviceBattery;
/**   方法名称 :GetDeviceDefinition
 **   方法作用 :屏幕是否高清 
 **   方法参数 :
 **   方法返回值:屏幕是否高清 
 **/
+ (BOOL)deviceDefinition;

/**   方法名称 :locationService
 **   方法作用 :程序是否支持位置服务 
 **   方法参数 :
 **   方法返回值:程序是否支持位置服务
 **/
+(BOOL)locationService;

/**   方法名称 :programVersion
 **   方法作用 :获取项目的版本号 
 **   方法参数 :
 **   方法返回值:项目的版本号  
 **/
+(double)programVersion;

@end
