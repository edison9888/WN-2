//
//  MHTool.h
//  Card
//
//  Created by shenzhen on 12-1-31.
//  Copyright (c) 2012年 imohoo. All rights reserved.
//  verson: 1.00
//

#import <Foundation/Foundation.h>
#import "MHAnimationTool.h"
#import "MHCommonTool.h"
#import "MHFile.h"
#import "MHFont.h"
#import "MHSystemTool.h"
#import "MHCode.h"
#import "MHDeviceTool.h"

@interface MHTool : NSObject

#pragma mark
#pragma mark==================================================
#pragma mark===================加密解密工具======================
#pragma mark==================================================

/**   函数名称 :encodeBase64
 **   函数作用 :Base64加密
 **   函数参数 :        
 **   函数返回值:
 **/
+(NSData *)encodeBase64:(NSData *)data;

/**   函数名称 :encodeBase64
 **   函数作用 :Base64解密
 **   函数参数 :        
 **   函数返回值:
 **/
+(NSData *)decodeBase64:(NSData *)data;

/**   函数名称 :decodeString
 **   函数作用 :Base64解密
 **   函数参数 :        
 **   函数返回值:
 **/
+(NSData *)decodeBase64String:(NSString *)string;

/**   函数名称 :encodeDES
 **   函数作用 :des加密
 **   函数参数 :        
 **   函数返回值:
 **/
+ (NSString *)encodeDES:(NSString *)string;

/**   函数名称 :decodeDES
 **   函数作用 :des解密
 **   函数参数 :        
 **   函数返回值:
 **/
+ (NSString *)decodeDES:(NSString *)string; 


#pragma mark
#pragma mark==================================================
#pragma mark======================动画工具======================
#pragma mark==================================================

#pragma mark - move

/**   函数名称 :animationView:OriginMoveTo:time:selector:delegate:
 **   函数作用 :根据view的起始点做动画
 **   函数参数 : view：需要做动画的view toPoint：原点默认地址 time：动画时间
 selector：动画结束后调用的方法 delegate:代理对象           
 **   函数返回值:
 **/


+ (void)animationView:(UIView *)view 
         OriginMoveTo:(CGPoint)destPoint 
                 time:(float)time 
          repeatCount:(NSInteger)count
             selector:(SEL)selector 
             delegate:(id)delegate;


/**   函数名称 :animationView:CenterMoveTo:time:selector:delegate:
 **   函数作用 :根据view的起始点做动画
 **   函数参数 : view：需要做动画的view toPoint：原点默认地址 time：动画时间
 selector：动画结束后调用的方法 delegate:代理对象           
 **   函数返回值:
 **/
+ (void)animationView:(UIView *)view 
         CenterMoveTo:(CGPoint)destPoint 
                 time:(float)time
          repeatCount:(NSInteger)count
             selector:(SEL)selector 
             delegate:(id)delegate;


/**   函数名称 :animationView:FrameMoveTo:time:selector:delegate:
 **   函数作用 :根据view的起始点做动画
 **   函数参数 : view：需要做动画的view toPoint：原点默认地址 time：动画时间
 selector：动画结束后调用的方法 delegate:代理对象           
 **   函数返回值:
 **/
+ (void)animationView:(UIView *)view 
          FrameMoveTo:(CGRect)destFrame 
                 time:(float)time
          repeatCount:(NSInteger)count
             selector:(SEL)selector 
             delegate:(id)delegate;


#pragma mark - rotation

/**   函数名称 :animationView:time:rotationAngle:selector:delegate:
 **   函数作用 :界面旋转
 **   函数参数 : view：需要做动画的view time：动画时间 angle:旋转角度
 selector：动画结束后调用的方法 delegate:代理对象           
 **   函数返回值:
 **/


+ (void)animationView:(UIView *)view 
                 time:(float)time 
        rotationAngle:(CGFloat)angle 
             selector:(SEL)selector 
             delegate:(id)delegate;


#pragma mark - alpha

/**   函数名称 :animationAlphaFadeInOutView:time:resAlpha:destAlpha:selector:delegate:
 **   函数作用 :渐隐渐现动画
 **   函数参数 : view：需要做动画的view time：动画时间 resAlpha:起始透明度
 destAlpha：目的透明度 selector：动画结束后调用的方法 delegate:代理对象           
 **   函数返回值:
 **/

+ (void)animationAlphaFadeInOutView:(UIView *)view 
                               time:(float)time 
                           resAlpha:(float)resAlpha
                          destAlpha:(float)destAlpha
                           selector:(SEL)selector 
                           delegate:(id)delegate;

#pragma mark - push pop present dismiss

/**   函数名称 :animationPushView:time:viewExChange1:viewExChange2:selector:delegate:
 **   函数作用 :类似于地图的上翻 动画
 **   函数参数 : viewApplyTtansition：应用动画效果的view time：动画时间 view1,view2:需要交换的两个view           
 **   函数返回值:
 **/

+ (void)animationPushView:(UIView *)viewApplyTtansition 
                     time:(float)time 
            viewExChange1:(UIView *)view1 
            viewExChange2:(UIView *)view2;



/**   函数名称 :animationPopView:time:viewExChange1:viewExChange2:selector:delegate:
 **   函数作用 :类似于地图的上翻 动画
 **   函数参数 : viewApplyTtansition：应用动画效果的view time：动画时间 view1,view2:需要交换的两个view          
 **   函数返回值:
 **/

+ (void)animationPopView:(UIView *)viewApplyTtansition 
                    time:(float)time 
           viewExChange1:(UIView *)view1 
           viewExChange2:(UIView *)view2;


/**   函数名称 :animationPresentView:time:viewExChange1:viewExChange2:selector:delegate:
 **   函数作用 :类似于地图的上翻 动画
 **   函数参数 : viewApplyTtansition：应用动画效果的view time：动画时间 view1,view2:需要交换的两个view         
 **   函数返回值:
 **/

+ (void)animationPresentView:(UIView *)viewApplyTtansition 
                        time:(float)time 
               viewExChange1:(UIView *)view1 
               viewExChange2:(UIView *)view2;

/**   函数名称 :animationDismissView:time:viewExChange1:viewExChange2:selector:delegate:
 **   函数作用 :类似于地图的上翻 动画
 **   函数参数 : viewApplyTtansition：应用动画效果的view time：动画时间 view1,view2:需要交换的两个view          
 **   函数返回值:
 **/

+ (void)animationDismissView:(UIView *)viewApplyTtansition 
                        time:(float)time 
               viewExChange1:(UIView *)view1 
               viewExChange2:(UIView *)view2;


#pragma mark - Flip and Curl

/**   函数名称 :animationFlipFromLeftView:time:viewExChange1:viewExChange2:selector:delegate:
 **   函数作用 :左翻 动画
 **   函数参数 : viewApplyTtansition：应用动画效果的view time：动画时间 view1,view2:需要交换的两个view
 selector：动画结束后调用的方法 delegate:代理对象           
 **   函数返回值:
 **/

+ (void)animationFlipFromLeftView:(UIView *)viewApplyTtansition 
                             time:(float)time 
                    viewExChange1:(UIView *)view1 
                    viewExChange2:(UIView *)view2
                         selector:(SEL)selector 
                         delegate:(id)delegate;


/**   函数名称 :animationFlipFromRightView:time:viewExChange1:viewExChange2:selector:delegate:
 **   函数作用 :右翻 动画
 **   函数参数 : viewApplyTtansition：应用动画效果的view time：动画时间 view1,view2:需要交换的两个view
 selector：动画结束后调用的方法 delegate:代理对象           
 **   函数返回值:
 **/

+ (void)animationFlipFromRightView:(UIView *)viewApplyTtansition 
                              time:(float)time 
                     viewExChange1:(UIView *)view1 
                     viewExChange2:(UIView *)view2
                          selector:(SEL)selector 
                          delegate:(id)delegate;


/**   函数名称 :animationCurlUpView:time:viewExChange1:viewExChange2:selector:delegate:
 **   函数作用 :类似于地图的上翻 动画
 **   函数参数 : viewApplyTtansition：应用动画效果的view time：动画时间 view1,view2:需要交换的两个view
 selector：动画结束后调用的方法 delegate:代理对象           
 **   函数返回值:
 **/

+ (void)animationCurlUpView:(UIView *)viewApplyTtansition 
                       time:(float)time 
              viewExChange1:(UIView *)view1 
              viewExChange2:(UIView *)view2
                   selector:(SEL)selector 
                   delegate:(id)delegate;


/**   函数名称 :animationCurlDownView:time:viewExChange1:viewExChange2:selector:delegate:
 **   函数作用 :类似于地图的上翻 动画
 **   函数参数 : viewApplyTtansition：应用动画效果的view time：动画时间 view1,view2:需要交换的两个view
 selector：动画结束后调用的方法 delegate:代理对象           
 **   函数返回值:
 **/

+ (void)animationCurlDownView:(UIView *)viewApplyTtansition 
                         time:(float)time 
                viewExChange1:(UIView *)view1 
                viewExChange2:(UIView *)view2
                     selector:(SEL)selector 
                     delegate:(id)delegate;


#pragma mark - change Frame and Bounds

/**   函数名称 :animationChangeBoundsView:time:DestBounds:selector:delegate:
 **   函数作用 :改变view的Bounds 动画
 **   函数参数 : view：需要改变bounds的view time：动画时间 destBounds:view的最终bounds大小
 selector：动画结束后调用的方法 delegate:代理对象           
 **   函数返回值:
 **/

+ (void)animationChangeBoundsView:(UIView *)view 
                             time:(float)time 
                       DestBounds:(CGRect)destBounds 
                         selector:(SEL)selector 
                         delegate:(id)delegate;



/**   函数名称 :animationChangeFrameView:time:DestBounds:selector:delegate:
 **   函数作用 :改变view的Bounds 动画
 **   函数参数 : view：需要改变bounds的view time：动画时间 destBounds:view的最终bounds大小
 selector：动画结束后调用的方法 delegate:代理对象           
 **   函数返回值:
 **/

+ (void)animationChangeFrameView:(UIView *)view 
                            time:(float)time 
                       DestFrame:(CGRect)destFrame 
                        selector:(SEL)selector 
                        delegate:(id)delegate;

/**   函数名称 :ViewZoom
 **   函数作用 :view缩放
 **   函数参数 : 
 **           
 **   函数返回值:
 **/
+(void)animationScaleView:(UIView *)view 
                     time:(float)time 
               startScale:(float)startScale
                 endScale:(float)endScale 
                 selector:(SEL)selector 
                 delegate:(id)delegate;

/**   函数名称 :ViewMove
 **   函数作用 :view移动
 **   函数参数 : 
 **           
 **   函数返回值:
 **/
+(void)animationMoveView:(UIView *)view 
                    time:(float)time 
                  center:(CGPoint)center
                selector:(SEL)selector 
                delegate:(id)delegate;
/**   函数名称 :ViewMove
 **   函数作用 :view移动
 **   函数参数 : 
 **           
 **   函数返回值:
 **/
+(void)animationMoveView:(UIView *)view 
                    time:(float)time 
                    rect:(CGRect)rect
                selector:(SEL)selector 
                delegate:(id)delegate;

#pragma mark
#pragma mark==================================================
#pragma mark======================通用函数======================
#pragma mark==================================================

/**   函数名称 :dateToString
 **   函数作用 :date根据formatter转换成string
 **   函数参数 :
 **           formatter  ---要的格式，比如:@"MMM yyyy"
 **           date       ---日期
 **   函数返回值:格式
 **/
+(NSString*)dateToString:(NSString *)formatter date:(NSDate *)date;


/**   函数名称 :dateToString
 **   函数作用 :date根据formatter转换成string
 **   函数参数 : 
 **           formatter  ---要的格式，比如:@"MMM yyyy"
 **           timeInterval       ---时间戳
 **   函数返回值:格式
 **/
+(NSString*)dateToString:(NSString *)formatter timeInterval:(NSTimeInterval)timeInterval;

/**   函数名称 :dateToString
 **   函数作用 :date根据formatter转换成string
 **   函数参数 : 
 **           formatter  ---要的格式，比如:@"MMM yyyy"
 **           secs       ---日期的时间辍
 **   函数返回值:格式
 **/
+(NSString*)dateToString:(NSString *)formatter secs:(NSTimeInterval)secs;

/**   函数名称 :getCurrentTime
 **   函数作用 :获取当前时间
 **   函数参数 : 
 **           formatter  ---要的格式，比如:@"MMM yyyy"
 **   函数返回值:格式
 **/
+(NSString *)getCurrentTime:(NSString *)formatter;

/**   函数名称 :convertDateFormatter
 **   函数作用 :将日期从原格式转换成需要的格式
 **   函数参数 : 
 **           sourceFormatter  ---原格式
 **           targetFormatter  ---要的格式，比如:@"MMM yyyy"
 **           dateString       ---日期
 **   函数返回值:格式
 **/
+(NSString*)convertDateFormatter:(NSString*)sourceFormatter 
                 targetFormatter:(NSString*)targetFormatter  
                      dateString:(NSString*)dateString;


/**   函数名称 :stringToDate
 **   函数作用 :将日期字符串转换成date
 **   函数参数 : 
 **           formatter  ---要的格式，比如:@"MMM yyyy"
 **           dateString ---日期
 **   函数返回值:date
 **/
+(NSDate *)stringToDate:(NSString *)formatter dateString:(NSString *)dateString;


/**   函数名称 :charToUTF8String
 **   函数作用 :将char数据转换成utf8格式的string
 **   函数参数 : 
 **           charData  ---需转换的char数据
 **   函数返回值:utf8格式string
 **/
+(NSString *)charToUTF8String:(const char *)charData;


/**   函数名称 :stringToMD5Value
 **   函数作用 :将字符串转成MD5
 **   函数参数 : 
 **           string    ---需转换的string
 **   函数返回值:md5编码后的值
 **/
+(NSString *)stringToMD5Value:(NSString *)string;


/**   函数名称 :randNumber
 **   函数作用 :得到随机数字
 **   函数参数 :   max －－随机数的最大值
 **   函数返回值:随机数
 **/
+(int)randNumber:(int)max;


/**   函数名称 :replaceStringToString
 **   函数作用 :替换不需要的字符
 **   函数参数 :   needReplaceStr   ---需要替换的string
 replaceString    ---需要替换掉的特殊字符
 toReplaceString  ---替换成需要的字符
 **   函数返回值:替换后string
 **/
+(NSString *)replaceStringToString:(NSString *)needReplaceStr
                     replaceString:(NSString *)replaceString
                   toReplaceString:(NSString *)toReplaceString;


/**   函数名称 :replaceFirstAndEndSpace
 **   函数作用 :去除首尾空格
 **   函数参数 :   buf   ---需要替换的string
 **   函数返回值:去除首尾空格后的string
 **/
+(NSString *)trimString:(NSString *)buf;


/**   函数名称 :DataToUTF8String
 **   函数作用 :将data类型的数据,转成UTF8的数据
 **   函数参数 :   data   ---需要转化的data
 **   函数返回值:utf8格式string
 **/
+(NSString *)dataToUTF8String:(NSData *)data;


/**   函数名称 :toRadians
 **   函数作用 :角度转弧度  
 **   函数参数 :  角度
 **   函数返回值:  弧度
 **/
//角度转弧度  
+ (CGFloat)toRadians:(CGFloat)degree;  
//弧度转角度  
+ (CGFloat)toDegrees:(CGFloat)radian;  



/**   函数名称 :changeDataToEncodinString
 **   函数作用 :将data转换成所需格式的string  
 **   函数参数 :  
 **            data ---所需转化的data
 **         encodin ---编码格式
 **   函数返回值:  转换好的string
 **/
+(NSString *)changeDataToEncodinString:(NSData *)data encodin:(NSStringEncoding )encodin;



/**   函数名称 :alertWithTitle
 **   函数作用 :提醒工具 
 **   函数参数 :  title               ---提醒的标题(可以为nil)
 **              Message            ---提醒的内容(可以为nil)
 **             delegate            ---delegate(可以为nil)
 **            cancelButton         ---取消按钮(可以为nil)
 **             otherButton         ---其他按钮(可以为nil)
 **   函数返回值:  无
 **/
+(void)alertWithTitle:(NSString *)title 
              Message:(NSString *)message 
             delegate:(id)delegate 
         cancelButton:(NSString *)cancelButton
          otherButton:(NSString *)otherButton;

/**   函数名称 :stringIsValidEmail:
 **   函数作用 :检测邮箱是否合法 
 **   函数参数 : 待检测的邮箱地址
 **   函数返回值:  YES 合法 NO 不合法
 **/
+ (BOOL)stringIsValidEmail:(NSString *)checkString;

/**   函数名称 :getScreenShot:
 **   函数作用 :获取屏幕截图
 **   函数参数 : view--屏幕
 **   函数返回值:屏幕的UIImage
 **/
+(UIImage *)getScreenShot:(UIView *)view;

/**   函数名称 :saveDataToUserDefaults:
 **   函数作用 :保存数据到沙盒
 **   函数参数 :
 **   函数返回值:
 **/
+(void)saveDataToUserDefaults:(NSString *)key value:(NSString *)vallue;
/**   函数名称 :getDataFromUserDefaults:
 **   函数作用 :读取数据到沙盒
 **   函数参数 :
 **   函数返回值:
 **/
+(id)getDataFromUserDefaults:(NSString *)key;

/**   函数名称 :createUUID
 **   函数作用 :创建UUID
 **   函数参数 : 
 **   函数返回值:
 **/
+(NSString *)createUUID;

#pragma mark
#pragma mark==================================================
#pragma mark======================文件操作======================
#pragma mark==================================================

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

#pragma mark
#pragma mark==================================================
#pragma mark======================文字操作======================
#pragma mark==================================================
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

#pragma mark
#pragma mark==================================================
#pragma mark======================系统工具======================
#pragma mark==================================================
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
 **   方法返回值:版本号
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
#pragma mark
#pragma mark==================================================
#pragma mark======================设备工具======================
#pragma mark==================================================
/**   函数名称 :macAddress
 **   函数作用 :得到mac
 **   函数参数 :  macAddress
 **   函数返回值: mac值
 **/
+(NSString *)macAddress;

@end
